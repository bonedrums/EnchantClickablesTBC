local addonName, addon = ...

-- Function to count items in bags
local function GetItemCount(itemId)
    local count = 0
    for bag = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local itemLink = C_Container.GetContainerItemLink(bag, slot)
            if itemLink then
                local _, _, itemString = strfind(itemLink, "item:(%d+)")
                if itemString and tonumber(itemString) == itemId then
                    local info = C_Container.GetContainerItemInfo(bag, slot)
                    if info then
                        count = count + info.stackCount
                    end
                end
            end
        end
    end
    return count
end

-- Function to get item name from ID
local function GetItemNameFromID(itemId)
    local itemName = GetItemInfo(itemId)
    return itemName
end

local function SpellIsKnown(spell_id)
    t = GetSpellInfo(GetSpellInfo(spell_id))
    if t == nil then
        return false
    end
    return true
end

local function HaveMats(spell_id)
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
        frame:SetPoint("BOTTOMLEFT", TradeFrame, "BOTTOMRIGHT", 5, 0)
        frame:Show()
    else
        frame:Hide()
    end
end

-- Create individual essence frame
local function CreateEssenceFrame(parent, essence, index, totalButtons)
    local frame = CreateFrame("Button", "EssenceButton"..index, parent, "SecureActionButtonTemplate")
    frame:SetSize(240, 23)
    -- Calculate position from bottom
    local bottomOffset = 25 * (totalButtons - index)
    frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 8, bottomOffset)
    
    local itemName = GetItemNameFromID(essence.item_id)
    if not itemName then
        print("Warning: Could not find item info for ID:", essence.item_id)
        return
    end
    
    frame:SetAttribute("type", "item")
    frame:SetAttribute("item", itemName)
    frame:EnableMouse(true)
    
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.1, 0.1, 0.1, 0)
    
    local icon = frame:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("LEFT", frame, "LEFT", 4, 0)
    icon:SetTexture(essence.icon_id)
    
    local text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    text:SetPoint("LEFT", icon, "RIGHT", 8, 0)
    text:SetText(itemName)
    
    -- Check if it's a split or join based on name
    local isSplit = string.find(essence.name, "split")
    local itemCount = GetItemCount(essence.item_id)
    
    -- Set color based on whether we have enough items
    if (isSplit and itemCount >= 1) or (not isSplit and itemCount >= 3) then
        text:SetTextColor(0, 1, 0)  -- Green if we have enough
    else
        text:SetTextColor(1, 0, 0)  -- Red if we don't
    end
    
    frame:SetScript("OnEnter", function(self)
        bg:SetColorTexture(0.2, 0.2, 0.2, 0.8)
    end)
    frame:SetScript("OnLeave", function(self)
        bg:SetColorTexture(0.1, 0.1, 0.1, 0)
    end)
    
    return frame
end

-- Create individual enchant frame
local function CreateEnchantFrame(parent, enchant, index, totalButtons)
    local frame = CreateFrame("Button", "EnchantButton"..index, parent, "SecureActionButtonTemplate")
    frame:SetSize(240, 23)
    -- Calculate position from bottom
    local bottomOffset = 25 * (totalButtons - index)
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
local function onUpdate(mainFrame)
    UpdateFramePosition(mainFrame)
    -- Always clear existing enchant frames first
    ClearEnchantFrames(mainFrame.enchantContainer)

    -- Get valid enchants for the item
    local validEnchants = {}
    local tItemLink = GetTradeTargetItemLink(7)
    if tItemLink then 
        local itemName, _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(tItemLink)
        if itemEquipLoc and EnchantList[itemEquipLoc] then
            for _, enchant in ipairs(EnchantList[itemEquipLoc]) do
                if SpellIsKnown(enchant.spell_id) and HaveMats(enchant.spell_id) then
                    table.insert(validEnchants, enchant)
                end
            end
        end
    end
    
    -- Get valid essence splits/joins
    local validEssences = {}
    for _, essence in ipairs(EnchantList["ESSENCE"]) do
        local itemCount = GetItemCount(essence.item_id)
        local isSplit = string.find(essence.name, "split")
        
        -- For splits we need at least 1, for joins we need at least 3
        if (isSplit and itemCount >= 1) or (not isSplit and itemCount >= 3) then
            table.insert(validEssences, essence)
        end
    end
    
    -- Create frames for item enchants
    local totalButtons = #validEnchants + #validEssences
    for index, enchant in ipairs(validEnchants) do
        CreateEnchantFrame(mainFrame.enchantContainer, enchant, index, totalButtons)
    end
    
    -- Create frames for essences after enchants
    for index, essence in ipairs(validEssences) do
        CreateEssenceFrame(mainFrame.enchantContainer, essence, index + #validEnchants, totalButtons)
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
eventFrame:RegisterEvent("TRADE_REPLACE_ENCHANT")

local mainFrame = nil

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        mainFrame = InitializeAddon()
    elseif event == "TRADE_SHOW" or event == "TRADE_CLOSED" then
        if mainFrame then
            onUpdate(mainFrame)
        end
    elseif event == "TRADE_UPDATE" or event == "TRADE_TARGET_ITEM_CHANGED" or event == "UNIT_INVENTORY_CHANGED" then
        if mainFrame and mainFrame:IsVisible() then
            onUpdate(mainFrame)
        end
    elseif event == "TRADE_REPLACE_ENCHANT" then
        local e1, e2 = ...
        local tMsg = "Replace " .. e1 .. " with " .. e2 .. "?"
        local tTradePartner = GetUnitName("NPC")
        SendChatMessage(tMsg, "WHISPER", "Common", tTradePartner)
    end
end)