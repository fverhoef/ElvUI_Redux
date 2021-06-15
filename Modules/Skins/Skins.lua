local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon:NewModule(addonName .. "Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Skins = Skins
local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local AFK = E:GetModule("AFK")
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local LO = E:GetModule("Layout")
local NP = E:GetModule("NamePlates")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Skins:Initialize()
    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    local additionalFrames = {
        _G.GameMenuFrame,
        _G.InterfaceOptionsFrame,
        _G.VideoOptionsFrame,
        _G.ScriptErrorsFrame,
        _G.StackSplitFrame,
        _G.ElvLootFrame,
        _G.LootFrame,
        _G.LootHistoryFrame,
        _G.MasterLooterFrame,
        _G.ReadyCheckFrame,
        _G.WorldMapFrame,
        _G.ColorPickerFrame,
        _G.CopyChatFrame,
        _G.GuildMemberDetailFrame,
        _G.ItemSocketingFrame,
        _G.MMHolder,
        B.BagFrame,
        B.BankFrame,
        B.SellFrame
    }

    for i = 1, 4 do
        table.insert(additionalFrames, _G["StaticPopup" .. i])
        table.insert(additionalFrames, _G["ElvUI_StaticPopup" .. i])
    end

    for _, frame in ipairs(additionalFrames) do
        Skins:HandleFrame(frame)
    end

    -- skin chat panels
    Skins:HandleChatPanel(_G.LeftChatPanel)
    Skins:HandleButton(_G.LeftChatToggleButton)
    Skins:HandleChatPanel(_G.RightChatPanel)
    Skins:HandleButton(_G.RightChatToggleButton)

    -- skill book tabs
    for i = 1, _G.MAX_SKILLLINE_TABS do
        Skins:HandleTab(_G["SpellBookSkillLineTab" .. i], false, "RIGHT")
    end

    -- skin character equipment slot items
    for _, slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Skins:HandleItemButton(slot)
        end
    end

    -- Mirror Timers
    for i = 1, 3 do
        Skins:HandleStatusBar(_G["MirrorTimer" .. i .. "StatusBar"])
    end

    -- Raid Utility Panel
    Skins:HandleFrame(_G.RaidUtilityPanel)
    Skins:HandleRaidUtilityButton(_G.RaidUtility_ShowButton)
    Skins:HandleRaidUtilityButton(_G.RaidUtility_CloseButton)
    Skins:HandleRaidUtilityButton(_G.RaidControlButton)

    -- Help
    if Addon.isClassic then
        Skins:HandleFrame(_G.HelpFrameHeader)
    end

    -- ElvUI panels
    Skins:HandlePanel(LO.BottomPanel, "BOTTOM")
    Skins:HandlePanel(LO.TopPanel, "TOP")
    Skins:HandlePanel(AFK.AFKMode.bottom, "BOTTOM")

    -- Unit Frames
    Skins:HandleUnitFrame("player")
    Skins:HandleUnitFrame("pet")
    Skins:HandleUnitFrame("pettarget")
    Skins:HandleUnitFrame("target")
    Skins:HandleUnitFrame("targettarget")
    Skins:HandleUnitFrame("targettargettarget")
    Skins:HandleUnitFrame("focus")

    -- Unit Frame Groups
    Skins:HandleUnitFrameGroup("arena")
    Skins:HandleUnitFrameGroup("assist")
    Skins:HandleUnitFrameGroup("boss")
    Skins:HandleUnitFrameGroup("party")
    Skins:HandleUnitFrameGroup("raid")
    Skins:HandleUnitFrameGroup("raid40")
    Skins:HandleUnitFrameGroup("raidpet")
    Skins:HandleUnitFrameGroup("tank")

    -- action bars
    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            Skins:HandleActionBar(bar)

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[j]
                Skins:HandleActionButton(button)
            end
        end
    end

    -- vehicle Leave
    Skins:HandleActionButton(_G.MainMenuBarVehicleLeaveButton)

    -- plugins: ElvUI_ClassicClassBars
    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            Skins:HandleActionBar(ccb.MageBar)

            for i, button in ipairs(ccb.MageBar.buttons) do
                Skins:HandleActionButton(button.CurrentAction or button)
            end
        end

        if ccb.ShamanBar then
            Skins:HandleActionBar(ccb.ShamanBar)

            for i, button in ipairs(ccb.ShamanBar.buttons) do
                Skins:HandleActionButton(button.CurrentAction or button)
            end
        end
    end

    -- plugins: ElvUI_MerathilisUI
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Skins:HandlePanel(_G[merathilis[1].Title .. "TopPanel"], "TOP")
        Skins:HandlePanel(_G[merathilis[1].Title .. "BottomPanel"], "BOTTOM")
    end

    Skins:RegisterEvent("GROUP_ROSTER_UPDATE", Skins.GROUP_ROSTER_UPDATE)
end

function Skins:Update()
    if UnitAffectingCombat("player") then
        Skins:ScheduleTimer("Update", 1)
        return
    end

    local config = E.db[addonName].skins

    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            bar.shadow.isHidden = config.shadows.shadowPerButton

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[j]
                button.shadow.isHidden = not config.shadows.shadowPerButton
            end
        end
    end

    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            ccb.MageBar.shadow.isHidden = config.shadows.shadowPerButton
            for i, button in ipairs(ccb.MageBar.buttons) do
                (button.CurrentAction or button).shadow.isHidden = not config.shadows.shadowPerButton
            end
        end

        if ccb.ShamanBar then
            ccb.ShamanBar.shadow.isHidden = config.shadows.shadowPerButton
            for i, button in ipairs(ccb.ShamanBar.buttons) do
                (button.CurrentAction or button).shadow.isHidden = not config.shadows.shadowPerButton
            end
        end
    end

    for shadow, _ in pairs(Skins.registry.shadows) do
        shadow:Update()
    end

    for border, _ in pairs(Skins.registry.borders) do
        --border:Update()
    end
end

function Skins:GROUP_ROSTER_UPDATE()
    Skins:Update()
end

function Skins:GetBorderColor(frame)
    local color
    local parent = frame.backdrop or frame
    if parent.GetBackdropBorderColor then
        color = {parent:GetBackdropBorderColor()}
    end

    return color or E.media.bordercolor
end
