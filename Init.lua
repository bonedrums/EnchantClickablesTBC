local addonName, addon = ...

local function EC_spellIsKnown(spell_id)
    t = GetSpellInfo(GetSpellInfo(spell_id))
    if t == nil then
        return false
    end
    return true
end

local function EC_HaveMats(spell_id)
    tReturn = IsUsableSpell(spell_id)
    return tReturn
end

-- Create main frame
local function CreateMainFrame()
    local frame = CreateFrame("Frame", "EnchantListFrame", UIParent)
    frame:SetSize(256, 400)
    frame:EnableMouse(false)
    frame:Hide() -- Start hidden
    
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0)
    
    -- Add container for enchant buttons
    frame.enchantContainer = CreateFrame("Frame", nil, frame)
    frame.enchantContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -25)
    frame.enchantContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    
    return frame
end

-- Function to update frame position relative to trade window
local function UpdateFramePosition(frame)
    if TradeFrame and TradeFrame:IsVisible() then
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 5, 0)
        frame:Show()
    else
        frame:Hide()
    end
end

-- Create individual enchant frame
local function CreateEnchantFrame(parent, enchant, index, totalButtons)
    local frame = CreateFrame("Button", "EnchantButton"..index, parent, "SecureActionButtonTemplate")
    frame:SetSize(240, 30)
    -- Calculate position from bottom
    local bottomOffset = 32 * (totalButtons - index)
    frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 8, bottomOffset)
    
    local spellName = GetSpellInfo(enchant.spell_id)
    local spellIcon = enchant.icon_id
    if not spellName then
        print("Warning: Could not find spell info for ID:", enchant.spell_id)
        return
    end
    
    frame:SetAttribute("type", "spell")
    frame:SetAttribute("spell", spellName)
    frame:EnableMouse(true)
    
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.1, 0.1, 0.1, 0)
    
    local icon = frame:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("LEFT", frame, "LEFT", 4, 0)
    icon:SetTexture(spellIcon)
    
    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetPoint("LEFT", icon, "RIGHT", 8, 0)
    text:SetText(spellName)
    text:SetTextColor(0, 1, 0)
    
    frame:SetScript("OnEnter", function(self)
        bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
    end)
    frame:SetScript("OnLeave", function(self)
        bg:SetColorTexture(0.1, 0.1, 0.1, 0)
    end)
    
    return frame
end

-- Function to clear all enchant buttons
local function ClearEnchantFrames(container)
    if container then
        local child = container:GetChildren()
        while child do
            child:Hide()
            child:SetParent(nil)
            child = container:GetChildren()
        end
    end
end

-- Function to update enchants based on traded item
local function UpdateEnchantsForItem(mainFrame)
    -- Always clear existing enchant frames first
    ClearEnchantFrames(mainFrame.enchantContainer)

    local tItemLink = GetTradeTargetItemLink(7)
    if not tItemLink then return end
    
    local itemName, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(tItemLink)
    if not itemEquipLoc or not EnchantList[itemEquipLoc] then return end
    
    -- First count valid enchants
    local validEnchants = {}
    for _, enchant in ipairs(EnchantList[itemEquipLoc]) do
        if EC_spellIsKnown(enchant.spell_id) and EC_HaveMats(enchant.spell_id) then
            table.insert(validEnchants, enchant)
        end
    end
    
    -- Create new enchant frames for the item type
    for index, enchant in ipairs(validEnchants) do
        CreateEnchantFrame(mainFrame.enchantContainer, enchant, index, #validEnchants)
    end
end

-- Initialize everything
local function InitializeAddon()
    local mainFrame = CreateMainFrame()
    return mainFrame
end

-- Event frame for initialization and trade window monitoring
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("TRADE_SHOW")
eventFrame:RegisterEvent("TRADE_CLOSED")
eventFrame:RegisterEvent("TRADE_UPDATE")
eventFrame:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
eventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")

local mainFrame = nil

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        mainFrame = InitializeAddon()
    elseif event == "TRADE_SHOW" or event == "TRADE_CLOSED" then
        if mainFrame then
            ClearEnchantFrames(mainFrame.enchantContainer)
            UpdateFramePosition(mainFrame)
        end
    elseif event == "TRADE_UPDATE" or event == "TRADE_TARGET_ITEM_CHANGED" or event == "UNIT_INVENTORY_CHANGED" then
        if mainFrame and mainFrame:IsVisible() then
            UpdateEnchantsForItem(mainFrame)
        end
    end
end)