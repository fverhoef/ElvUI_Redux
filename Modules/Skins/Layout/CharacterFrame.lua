local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)

local CATEGORY_HEADER_HEIGHT = 23
local CATEGORY_SPACING = 5
local ITEM_LEVEL_HEIGHT = 27
local STAT_HEIGHT = 18
local attributeIndex = {["STRENGTH"] = 1, ["AGILITY"] = 2, ["STAMINA"] = 3, ["INTELLECT"] = 4, ["SPIRIT"] = 5}
local enhancementCategories = {
    "PLAYERSTAT_MELEE_COMBAT",
    "PLAYERSTAT_RANGED_COMBAT",
    "PLAYERSTAT_SPELL_COMBAT",
    "PLAYERSTAT_DEFENSES"
}

function Skins:LayoutCharacterFrame()
    -- resize model
    _G.CharacterModelFrame:SetSize(231, 320)
    _G.CharacterModelFrame:SetFrameLevel(10)

    -- make sure resistances are on top
    _G.CharacterResistanceFrame:SetFrameLevel(11)
    _G.PaperDollItemsFrame:SetFrameLevel(11)

    -- hide default attributes frame
    _G.CharacterAttributesFrame:Hide()

    -- create new stats pane
    _G.CharacterFrame.originalWidth = _G.CharacterFrame:GetWidth()
    _G.PaperDollFrame.CharacterStatsPane = Skins:CreateCharacterStatsPane()

    -- adjust frame width
    Skins:SecureHook("CharacterFrame_ShowSubFrame", function()
        if _G.PaperDollFrame:IsShown() then
            _G.CharacterFrame:SetWidth(_G.CharacterFrame.originalWidth + _G.PaperDollFrame.CharacterStatsPane:GetWidth() - 71)
            _G.UIPanelWindows["CharacterFrame"].width = _G.CharacterFrame:GetWidth() - 30
        else
            _G.CharacterFrame:SetWidth(_G.CharacterFrame.originalWidth)
            _G.UIPanelWindows["CharacterFrame"].width = _G.CharacterFrame:GetWidth()
        end
    end)

    -- move close button when switching between tabs, and show/hide level/guild texts
    Skins:SecureHook("ToggleCharacter", function()
        if _G.PaperDollFrame:IsShown() then
            _G.CharacterFrameCloseButton:SetPoint("CENTER", _G.CharacterFrame, "TOPRIGHT", -46, -25)
            _G.CharacterLevelText:Show()
            if _G.CharacterGuildText then
                _G.CharacterGuildText:Show()
            end
        else
            _G.CharacterFrameCloseButton:SetPoint("CENTER", _G.CharacterFrame, "TOPRIGHT", -44, -25)
            _G.CharacterLevelText:Hide()
            if _G.CharacterGuildText then
                _G.CharacterGuildText:Hide()
            end
        end
        if _G.HonorFrame then
            if _G.HonorFrame:IsShown() then
                _G.HonorLevelText:Show()
                _G.HonorGuildText:Show()
            else
                _G.HonorLevelText:Hide()
                _G.HonorGuildText:Hide()
            end
        end
    end)

    -- reparent level/guild texts
    _G.CharacterLevelText:SetParent(_G.CharacterNameFrame)
    _G.CharacterLevelText:ClearAllPoints()
    _G.CharacterLevelText:SetPoint("TOP", _G.CharacterNameFrame, "BOTTOM", 0, -10)

    if _G.CharacterGuildText then
        _G.CharacterGuildText:SetParent(_G.CharacterNameFrame)

        -- update name/level/guild texts
        Skins:SecureHook("PaperDollFrame_SetLevel", function()
            local class = E:UnlocalizedClassName(UnitClass("player"))
            local classColor = _G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[class] or _G.RAID_CLASS_COLORS[class]
            _G.CharacterLevelText:SetFormattedText(_G.PLAYER_LEVEL, UnitLevel("player"),
                                                   Addon:Hex(1, 1, 1) .. UnitRace("player") .. "|r",
                                                   Addon:Hex(classColor) .. UnitClass("player") .. "|r")
        end)
        Skins:SecureHook("PaperDollFrame_SetGuild", function()
            local guildName, title, rank = GetGuildInfo("player")
            if guildName then
                _G.CharacterGuildText:SetFormattedText(_G.GUILD_TITLE_TEMPLATE, title, Addon:Hex(0, 230 / 255, 0) .. guildName .. "|r")
            end
        end)
    end

    Skins:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", Skins.UpdateCharacterStatsPane)
    _G.CharacterFrame:HookScript("OnShow", Skins.UpdateCharacterStatsPane)
end

function Skins:CreateCharacterStatsPane()
    local frame = CreateFrame("Frame", addonName .. "CharacterStatsPane", _G.PaperDollFrame)
    frame:SetSize(150 + 128, 3 * CATEGORY_HEADER_HEIGHT + ITEM_LEVEL_HEIGHT + 12 * STAT_HEIGHT + 2 * CATEGORY_SPACING)
    frame:SetPoint("TOPRIGHT", _G.PaperDollFrame, "TOPRIGHT", 0, -74)

    frame.ItemLevel = Skins:CreateCharacterStatsPane_ItemLevel(frame)
    frame.Attributes = Skins:CreateCharacterStatsPane_Attributes(frame)
    frame.Enhancements = Skins:CreateCharacterStatsPane_Enhancements(frame)

    return frame
end

function Skins:CreateCharacterStatsPane_ItemLevel(parent)
    local frame = CreateFrame("Frame", addonName .. "CharacterStatsPaneItemLevel", parent)
    frame:SetSize(198, CATEGORY_HEADER_HEIGHT + ITEM_LEVEL_HEIGHT)
    frame:SetPoint("TOP", parent, "TOP", 0, 0)

    frame.Header = CreateFrame("Frame", addonName .. "CharacterStatsPaneItemLevelLabel", parent)
    frame.Header:SetSize(198, CATEGORY_HEADER_HEIGHT)
    frame.Header:SetPoint("TOP", frame, "TOP", 0, 0)
    frame.Header.Text = frame.Header:CreateFontString(nil, "OVERLAY")
    frame.Header.Text:SetAllPoints()
    frame.Header.Text:SetJustifyH("CENTER")
    frame.Header.Text:SetJustifyV("CENTER")
    frame.Header.Text:SetShadowOffset(1, -1)
    frame.Header.Text:SetFont(_G.STANDARD_TEXT_FONT, 13)
    frame.Header.Text:SetText(_G.STAT_AVERAGE_ITEM_LEVEL)

    frame.Value = CreateFrame("Frame", addonName .. "CharacterStatsPaneItemLevelLabel", parent)
    frame.Value:SetSize(145, ITEM_LEVEL_HEIGHT)
    frame.Value:SetPoint("TOP", frame.Header, "BOTTOM", 0, 0)
    frame.Value.Text = frame.Value:CreateFontString(nil, "OVERLAY")
    frame.Value.Text:SetAllPoints()
    frame.Value.Text:SetJustifyH("CENTER")
    frame.Value.Text:SetJustifyV("CENTER")
    frame.Value.Text:SetShadowOffset(1, -1)
    frame.Value.Text:SetFont(_G.STANDARD_TEXT_FONT, 15)
    frame.Value.Background = frame.Value:CreateTexture("BACKGROUND")
    frame.Value.Background:SetAllPoints()
    frame.Value.Background:SetTexture([[Interface\PaperDollInfoFrame\PaperDollInfoPart1]])
    frame.Value.Background:SetTexCoord(10 / 1024, 155 / 1024, 758 / 1024, 784 / 1024)
    frame.Value.Background:SetAlpha(0.3)
    frame.Value.Background:SetDesaturated(1)

    return frame
end

function Skins:CreateCharacterStatsPane_Attributes(parent)
    local frame = CreateFrame("Frame", addonName .. "CharacterStatsPaneAttributes", parent)
    frame:SetSize(168, CATEGORY_HEADER_HEIGHT + 6 * STAT_HEIGHT)
    frame:SetPoint("TOP", parent.ItemLevel, "BOTTOM", 0, -CATEGORY_SPACING)

    frame.Header = CreateFrame("Frame", addonName .. "CharacterStatsPaneAttributesHeader", parent)
    frame.Header:SetSize(168, CATEGORY_HEADER_HEIGHT)
    frame.Header:SetPoint("TOP", frame, "TOP", 0, 0)
    frame.Header.Text = frame.Header:CreateFontString(nil, "OVERLAY")
    frame.Header.Text:SetAllPoints()
    frame.Header.Text:SetJustifyH("CENTER")
    frame.Header.Text:SetJustifyV("CENTER")
    frame.Header.Text:SetShadowOffset(1, -1)
    frame.Header.Text:SetFont(_G.STANDARD_TEXT_FONT, 13)
    frame.Header.Text:SetText(_G.STAT_CATEGORY_ATTRIBUTES)

    local stat1 = _G["PlayerStatFrameLeft1"]
    local stat2 = _G["PlayerStatFrameLeft2"]
    local stat3 = _G["PlayerStatFrameLeft3"]
    local stat4 = _G["PlayerStatFrameLeft4"]
    local stat5 = _G["PlayerStatFrameLeft5"]
    local stat6 = _G["PlayerStatFrameLeft6"]

    Skins:HandleStat(stat1, frame, false, {"TOPLEFT", frame.Header, "BOTTOMLEFT", 0, 0},
                     {"TOPRIGHT", frame.Header, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat2, frame, true, {"TOPLEFT", stat1, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat1, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat3, frame, false, {"TOPLEFT", stat2, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat2, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat4, frame, true, {"TOPLEFT", stat3, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat3, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat5, frame, false, {"TOPLEFT", stat4, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat4, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat6, frame, true, {"TOPLEFT", stat5, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat5, "BOTTOMRIGHT", 0, 0})

    return frame
end

function Skins:CreateCharacterStatsPane_Enhancements(parent)
    local frame = CreateFrame("Frame", addonName .. "CharacterStatsPaneEnhancements", parent)
    frame:SetSize(168, CATEGORY_HEADER_HEIGHT + 6 * STAT_HEIGHT)
    frame:SetPoint("TOP", parent.Attributes, "BOTTOM", 0, -CATEGORY_SPACING)

    frame.Header = CreateFrame("Frame", addonName .. "CharacterStatsPaneEnhancementsHeader", parent)
    frame.Header:SetSize(168, CATEGORY_HEADER_HEIGHT)
    frame.Header:SetPoint("TOP", frame, "TOP", 0, 0)
    frame.Header.Text = frame.Header:CreateFontString(nil, "OVERLAY")
    frame.Header.Text:SetAllPoints()
    frame.Header.Text:SetJustifyH("CENTER")
    frame.Header.Text:SetJustifyV("CENTER")
    frame.Header.Text:SetShadowOffset(1, -1)
    frame.Header.Text:SetFont(_G.STANDARD_TEXT_FONT, 13)
    frame.Header.Text:SetText(_G.STAT_CATEGORY_ENHANCEMENTS)

    frame.Header.ButtonPrevious = CreateFrame("Button", addonName .. "CharacterStatsPaneEnhancementsPrevious", frame.Header)
    frame.Header.ButtonPrevious:SetSize(16, 16)
    frame.Header.ButtonPrevious:SetNormalTexture(Addon.media.textures.arrowUp_ElvUI)
    frame.Header.ButtonPrevious:GetNormalTexture():SetRotation(math.pi / 2)
    frame.Header.ButtonPrevious:SetPoint("LEFT", frame.Header, "LEFT", 0, 0)
    frame.Header.ButtonPrevious:SetScript("OnEnter", function(btn)
        _G.GameTooltip:SetOwner(frame.Header.ButtonPrevious, "ANCHOR_TOPLEFT")
        _G.GameTooltip:SetText("Previous Category") -- TODO: Localization
        _G.GameTooltip:Show()

        local r, g, b = unpack(E.media.rgbvaluecolor)
        btn:GetNormalTexture():SetVertexColor(r, g, b)
    end)
    frame.Header.ButtonPrevious:SetScript("OnLeave", function(btn)
        _G.GameTooltip:Hide()
        btn:GetNormalTexture():SetVertexColor(1, 1, 1)
    end)
    frame.Header.ButtonPrevious:SetScript("OnClick", function()
        frame:PreviousCategory()
    end)

    frame.Header.ButtonNext = CreateFrame("Button", addonName .. "CharacterStatsPaneEnhancementsNext", frame.Header)
    frame.Header.ButtonNext:SetNormalTexture(Addon.media.textures.arrowUp_ElvUI)
    frame.Header.ButtonNext:GetNormalTexture():SetRotation(-math.pi / 2)
    frame.Header.ButtonNext:SetPoint("RIGHT", frame.Header, "RIGHT", 0, 0)
    frame.Header.ButtonNext:SetSize(16, 16)
    frame.Header.ButtonNext:SetScript("OnEnter", function(btn)
        _G.GameTooltip:SetOwner(frame.Header.ButtonNext, "ANCHOR_TOPLEFT")
        _G.GameTooltip:SetText("Next Category") -- TODO: Localization
        _G.GameTooltip:Show()

        local r, g, b = unpack(E.media.rgbvaluecolor)
        btn:GetNormalTexture():SetVertexColor(r, g, b)
    end)
    frame.Header.ButtonNext:SetScript("OnLeave", function(btn)
        _G.GameTooltip:Hide()
        btn:GetNormalTexture():SetVertexColor(1, 1, 1)
    end)
    frame.Header.ButtonNext:SetScript("OnClick", function()
        frame:NextCategory()
    end)

    local stat1 = _G["PlayerStatFrameRight1"]
    local stat2 = _G["PlayerStatFrameRight2"]
    local stat3 = _G["PlayerStatFrameRight3"]
    local stat4 = _G["PlayerStatFrameRight4"]
    local stat5 = _G["PlayerStatFrameRight5"]
    local stat6 = _G["PlayerStatFrameRight6"]

    Skins:HandleStat(stat1, frame, false, {"TOPLEFT", frame.Header, "BOTTOMLEFT", 0, 0},
                     {"TOPRIGHT", frame.Header, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat2, frame, true, {"TOPLEFT", stat1, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat1, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat3, frame, false, {"TOPLEFT", stat2, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat2, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat4, frame, true, {"TOPLEFT", stat3, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat3, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat5, frame, false, {"TOPLEFT", stat4, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat4, "BOTTOMRIGHT", 0, 0})
    Skins:HandleStat(stat6, frame, true, {"TOPLEFT", stat5, "BOTTOMLEFT", 0, 0}, {"TOPRIGHT", stat5, "BOTTOMRIGHT", 0, 0})

    frame.Update = function(self)
        self.Header.Text:SetText(_G[GetCVar("playerStatRightDropdown")])
        PaperDollFrame_UpdateStats()
    end
    frame.PreviousCategory = function(self)
        local current = GetCVar("playerStatRightDropdown")
        for i, category in ipairs(enhancementCategories) do
            if category == current then
                SetCVar("playerStatRightDropdown", enhancementCategories[(i == 1 and 4) or (i - 1)])
                break
            end
        end
        frame:Update()
    end
    frame.NextCategory = function(self)
        local current = GetCVar("playerStatRightDropdown")
        for i, category in ipairs(enhancementCategories) do
            if category == current then
                SetCVar("playerStatRightDropdown", enhancementCategories[(i == 4 and 1) or (i + 1)])
                break
            end
        end
        frame:Update()
    end
    frame:Update()

    return frame
end

function Skins:HandleStat(stat, parent, showBackground, point1, point2)
    stat:SetHeight(STAT_HEIGHT)
    stat:ClearAllPoints()
    stat:SetParent(parent)
    stat:Point(unpack(point1))
    if point2 then
        stat:Point(unpack(point2))
    end
    if showBackground then
        Skins:CreateStatBackground(stat)
    end
end

function Skins:CreateStatBackground(entry)
    if entry.Background then
        return
    end

    entry.Background = entry:CreateTexture("BACKGROUND")
    entry.Background:SetAllPoints()
    entry.Background:SetTexture([[Interface\PaperDollInfoFrame\PaperDollInfoPart1]])
    entry.Background:SetTexCoord(0 / 1024, 160 / 1024, 789 / 1024, 805 / 1024)
    entry.Background:SetAlpha(0.3)
    entry.Background:SetDesaturated(1)
end

function Skins:UpdateCharacterStatsPane()
    if not _G.CharacterFrame:IsShown() then
        return
    end

    Skins:UpdateAverageItemLevel()
    SetCVar("playerStatLeftDropdown", "PLAYERSTAT_BASE_STATS")
    PaperDollFrame_UpdateStats()
end

local function GetPlayerItemLevel()
    local slots = {
        "HeadSlot",
        "NeckSlot",
        "ShoulderSlot",
        "BackSlot",
        "ChestSlot",
        "WristSlot",
        "HandsSlot",
        "WaistSlot",
        "LegsSlot",
        "FeetSlot",
        "Finger0Slot",
        "Finger1Slot",
        "Trinket0Slot",
        "Trinket1Slot",
        "MainHandSlot",
        "SecondaryHandSlot",
        "RangedSlot"
    }
    local totalItemLevel = 0
    local count = 0
    local hasTwoHander = false
    for i, slot in next, slots do
        local link = GetInventoryItemLink("player", GetInventorySlotInfo(slot))
        if link then
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc,
                  itemIcon = GetItemInfo(link)
            if itemEquipLoc == "INVTYPE_2HWEAPON" then
                hasTwoHander = true
            end
            if itemLevel then
                totalItemLevel = totalItemLevel + itemLevel
            end
            count = count + 1
        elseif slot ~= "SecondaryHandSlot" and hasTwoHander then
            count = count + 1
        end
    end

    return math.floor((count and totalItemLevel / count) or 0)
end

function Skins:UpdateAverageItemLevel()
    local itemLevel = GetPlayerItemLevel()
    if itemLevel then
        local itemLevelCategory
        if itemLevel >= E.db[addonName].skins.characterStats.itemLevels.legendary then
            itemLevelCategory = 5 -- legendary
        elseif itemLevel >= E.db[addonName].skins.characterStats.itemLevels.epic then
            itemLevelCategory = 4 -- epic
        elseif itemLevel >= E.db[addonName].skins.characterStats.itemLevels.rare then
            itemLevelCategory = 3 -- rare
        elseif itemLevel >= E.db[addonName].skins.characterStats.itemLevels.uncommon then
            itemLevelCategory = 2 -- uncommon
        elseif itemLevel >= E.db[addonName].skins.characterStats.itemLevels.common then
            itemLevelCategory = 1 -- common
        else
            itemLevelCategory = 0 -- poor
        end
        local r, g, b = GetItemQualityColor(itemLevelCategory)
        _G.PaperDollFrame.CharacterStatsPane.ItemLevel.Value.Text:SetText(Addon:Hex(r, g, b) .. itemLevel .. "|r")
    end
end
