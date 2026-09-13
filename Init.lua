local addonName, addon = ...

-- ---------------------------------------------------------------------------
-- Options
-- ---------------------------------------------------------------------------
-- true  = one click casts the enchant AND drops it on the customer's
--         "Will not be traded" item. If the item already has an enchant the
--         normal "Replace enchant?" popup still appears (and the partner is
--         whispered), so nothing is overwritten without your confirmation.
-- false = one click casts the enchant and leaves the targeting cursor up for
--         you to click the item yourself (original behaviour).
local AUTO_APPLY = true

-- ---------------------------------------------------------------------------
-- API shims. The 2.5.5 client still ships the classic globals; fall back to
-- the C_* namespaces if they are ever removed.
-- ---------------------------------------------------------------------------
local GetItemInfo = GetItemInfo or (C_Item and C_Item.GetItemInfo)
local GetSpellInfo = GetSpellInfo or function(spell)
    local info = C_Spell and C_Spell.GetSpellInfo(spell)
    if info then
        return info.name, nil, info.iconID, info.castTime, info.minRange, info.maxRange, info.spellID
    end
end
local IsUsableSpell = IsUsableSpell or (C_Spell and C_Spell.IsSpellUsable)
local GetItemCount = GetItemCount or (C_Item and C_Item.GetItemCount)

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------
local function GetItemNameFromID(itemId)
    return (GetItemInfo(itemId))
end

-- Tradeskill recipes aren't in the spellbook, so IsSpellKnown() is useless;
-- looking the spell up by *name* only succeeds if the player has learned it.
local function SpellIsKnown(spell_id)
    local name = GetSpellInfo(spell_id)
    if not name then
        return false
    end
    return GetSpellInfo(name) ~= nil
end

local function HaveMats(spell_id)
    return IsUsableSpell(spell_id) and true or false
end

local function IsSplit(essence)
    return string.find(essence.name, "split") ~= nil
end

local function HaveEnoughEssence(essence)
    local count = GetItemCount(essence.item_id) or 0
    -- splits need 1 greater, joins need 3 lesser
    if IsSplit(essence) then
        return count >= 1
    end
    return count >= 3
end

-- ---------------------------------------------------------------------------
-- Frames
-- ---------------------------------------------------------------------------
local BUTTON_HEIGHT = 25

local function CreateMainFrame()
    local frame = CreateFrame("Frame", "EnchantListFrame", UIParent)
    frame:SetSize(256, 400)
    frame:SetFrameStrata("HIGH") -- stay clickable above other UI panels
    frame:EnableMouse(false)
    frame:Hide()

    frame.enchantContainer = CreateFrame("Frame", nil, frame)
    frame.enchantContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -25)
    frame.enchantContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)

    return frame
end

local function UpdateFramePosition(frame)
    if TradeFrame and TradeFrame:IsVisible() then
        frame:ClearAllPoints()
        frame:SetPoint("BOTTOMLEFT", TradeFrame, "BOTTOMRIGHT", 5, 0)
        frame:Show()
    else
        frame:Hide()
    end
end

-- Buttons are created once and reused, instead of being recreated (and
-- leaked) on every TRADE_UPDATE / inventory event.
local buttonPool = {}

local function AcquireButton(parent, index)
    local button = buttonPool[index]
    if not button then
        button = CreateFrame("Button", "EnchantClickablesButton" .. index, parent, "SecureActionButtonTemplate")
        button:SetSize(240, 23)
        button:EnableMouse(true)
        button:SetMouseClickEnabled(true)

        -- The modern client only processes the click phase that matches
        -- useOnKeyDown (default: the ActionButtonUseKeyDown CVar, which is on).
        -- A plain Button only registers LeftButtonUp, so with the CVar on the
        -- click was silently dropped. Register both phases and pin the action
        -- to mouse release so it fires exactly once.
        button:RegisterForClicks("AnyDown", "AnyUp")
        button:SetAttribute("useOnKeyDown", false)

        button.bg = button:CreateTexture(nil, "BACKGROUND")
        button.bg:SetAllPoints()
        button.bg:SetColorTexture(0.1, 0.1, 0.1, 0)

        button.icon = button:CreateTexture(nil, "ARTWORK")
        button.icon:SetSize(20, 20)
        button.icon:SetPoint("LEFT", button, "LEFT", 4, 0)

        button.text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        button.text:SetPoint("LEFT", button.icon, "RIGHT", 8, 0)

        button:SetScript("OnEnter", function(self)
            self.bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
        end)
        button:SetScript("OnLeave", function(self)
            self.bg:SetColorTexture(0.1, 0.1, 0.1, 0)
        end)

        buttonPool[index] = button
    end

    -- clear whatever action the button carried last time
    button:SetAttribute("type", nil)
    button:SetAttribute("spell", nil)
    button:SetAttribute("item", nil)
    button:SetAttribute("macrotext", nil)
    button:ClearAllPoints()
    return button
end

local function HideAllButtons()
    for _, button in ipairs(buttonPool) do
        button:Hide()
    end
end

local function SetupEnchantButton(button, enchant)
    local spellName = GetSpellInfo(enchant.spell_id)
    if not spellName then
        print(addonName .. ": could not find spell info for ID " .. tostring(enchant.spell_id))
        return false
    end

    if AUTO_APPLY then
        -- Same path ProEnchanters uses on this client: cast, then click the
        -- partner's slot-7 item so the enchant lands on it.
        button:SetAttribute("type", "macro")
        button:SetAttribute("macrotext", "/cast " .. spellName .. "\n/run TradeRecipientItem7ItemButton:Click()")
    else
        button:SetAttribute("type", "spell")
        button:SetAttribute("spell", spellName)
    end

    button.icon:SetTexture(enchant.icon_id)
    button.text:SetText(spellName)
    button.text:SetTextColor(0, 1, 0)
    return true
end

local function SetupEssenceButton(button, essence)
    local itemName = GetItemNameFromID(essence.item_id)
    if not itemName then
        -- item not in the client cache yet; it'll resolve on a later refresh
        return false
    end

    button:SetAttribute("type", "item")
    button:SetAttribute("item", itemName)

    button.icon:SetTexture(essence.icon_id)
    button.text:SetText(itemName)
    if HaveEnoughEssence(essence) then
        button.text:SetTextColor(0, 1, 0)
    else
        button.text:SetTextColor(1, 0, 0)
    end
    return true
end

-- ---------------------------------------------------------------------------
-- Refresh
-- ---------------------------------------------------------------------------
local refreshPending = false

local function onUpdate(mainFrame)
    UpdateFramePosition(mainFrame)

    -- Secure buttons can't be reconfigured in combat; try again when it ends.
    if InCombatLockdown() then
        refreshPending = true
        return
    end
    refreshPending = false

    HideAllButtons()
    if not mainFrame:IsShown() then
        return
    end

    -- Enchants that fit the item in the partner's "Will not be traded" slot
    local validEnchants = {}
    local tItemLink = GetTradeTargetItemLink(7)
    if tItemLink then
        local _, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(tItemLink)
        if itemEquipLoc and EnchantList[itemEquipLoc] then
            for _, enchant in ipairs(EnchantList[itemEquipLoc]) do
                if SpellIsKnown(enchant.spell_id) and HaveMats(enchant.spell_id) then
                    table.insert(validEnchants, enchant)
                end
            end
        end
    end

    -- Essence splits / joins we have the mats for
    local validEssences = {}
    for _, essence in ipairs(EnchantList["ESSENCE"]) do
        if HaveEnoughEssence(essence) then
            table.insert(validEssences, essence)
        end
    end

    local container = mainFrame.enchantContainer
    local total = #validEnchants + #validEssences
    local index = 0

    local function place(button)
        button:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", 8, BUTTON_HEIGHT * (total - index))
        button:Show()
    end

    for _, enchant in ipairs(validEnchants) do
        index = index + 1
        local button = AcquireButton(container, index)
        if SetupEnchantButton(button, enchant) then
            place(button)
        end
    end

    for _, essence in ipairs(validEssences) do
        index = index + 1
        local button = AcquireButton(container, index)
        if SetupEssenceButton(button, essence) then
            place(button)
        end
    end
end

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
local mainFrame = nil

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("TRADE_SHOW")
eventFrame:RegisterEvent("TRADE_CLOSED")
eventFrame:RegisterEvent("TRADE_UPDATE")
eventFrame:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
eventFrame:RegisterEvent("TRADE_REPLACE_ENCHANT")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        mainFrame = CreateMainFrame()

    elseif event == "TRADE_SHOW" or event == "TRADE_CLOSED" then
        if mainFrame then
            onUpdate(mainFrame)
        end

    elseif event == "TRADE_UPDATE" or event == "TRADE_TARGET_ITEM_CHANGED"
        or event == "UNIT_INVENTORY_CHANGED" or event == "BAG_UPDATE_DELAYED" then
        if mainFrame and mainFrame:IsVisible() then
            onUpdate(mainFrame)
        end

    elseif event == "PLAYER_REGEN_ENABLED" then
        if refreshPending and mainFrame then
            onUpdate(mainFrame)
        end

    elseif event == "TRADE_REPLACE_ENCHANT" then
        local existing, replacement = ...
        local partner = GetUnitName("NPC")
        if partner and existing and replacement then
            SendChatMessage("Replace " .. existing .. " with " .. replacement .. "?", "WHISPER", nil, partner)
        end
    end
end)
