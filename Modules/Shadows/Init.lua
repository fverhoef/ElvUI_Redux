local addonName, addonTable = ...
local Addon = addonTable[1]
local Shadows = Addon:NewModule(addonName .. "Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Shadows = Shadows
local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local AFK = E:GetModule('AFK')
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local LO = E:GetModule("Layout")
local NP = E:GetModule("NamePlates")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Shadows:Initialize()
    Shadows:CreateShadows()
    Shadows:RegisterEvent("GROUP_ROSTER_UPDATE", Shadows.GROUP_ROSTER_UPDATE)
end

function Shadows:CreateShadows()
    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    Shadows:CreateShadow(_G.GameMenuFrame)
    Shadows:CreateShadow(_G.InterfaceOptionsFrame)
    Shadows:CreateShadow(_G.VideoOptionsFrame)
    Shadows:CreateShadow(_G.ScriptErrorsFrame)
    Shadows:CreateShadow(_G.StackSplitFrame)
    Shadows:CreateShadow(_G.ElvLootFrame)
    Shadows:CreateShadow(_G.LootFrame)
    Shadows:CreateShadow(_G.LootHistoryFrame)
    Shadows:CreateShadow(_G.MasterLooterFrame)
    Shadows:CreateShadow(_G.ReadyCheckFrame)
    Shadows:CreateShadow(_G.WorldMapFrame)
    Shadows:CreateShadow(_G.ColorPickerFrame)
    Shadows:CreateShadow(_G.CopyChatFrame)
    Shadows:CreateShadow(_G.GuildMemberDetailFrame)

    -- skin chat panels
    Shadows:CreateShadow(_G.LeftChatPanel.backdrop)
    Shadows:CreateShadow(_G.LeftChatToggleButton)
    Shadows:CreateShadow(_G.RightChatPanel.backdrop)
    Shadows:CreateShadow(_G.RightChatToggleButton)

    -- action bars
    for i = 1, 10 do
        Shadows:CreateShadow(AB.handledBars["bar" .. i])
    end

    -- skin popups
    for i = 1, 4 do
        Shadows:CreateShadow(_G["StaticPopup" .. i])
    end
    for i = 1, 4 do
        Shadows:CreateShadow(_G["ElvUI_StaticPopup" .. i])
    end

    -- skin any tab that isn't handled by Skins.HandleTab
    for i = 1, _G.MAX_SKILLLINE_TABS do
        Shadows:CreateShadow(_G["SpellBookSkillLineTab" .. i])
    end

    -- skins bags
    Shadows:CreateShadow(B.BagFrame)
    Shadows:CreateShadow(B.BankFrame)
    Shadows:CreateShadow(B.SellFrame)

    -- skin character equipment slot items
    for _, slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Shadows:CreateShadow(slot)
        end
    end

    -- Minimap
    Shadows:CreateShadow(_G.MMHolder)

    -- Mirror Timers
    for i = 1, 3 do
        Shadows:CreateShadow(_G["MirrorTimer" .. i .. "StatusBar"])
    end
    
    -- Raid Utility Panel
    Shadows:CreateShadow(_G.RaidUtilityPanel)
    Shadows:CreateShadow(_G.RaidUtility_ShowButton)
    Shadows:CreateShadow(_G.RaidUtility_CloseButton)
    Shadows:CreateShadow(_G.RaidControlButton)
    
    -- Help
    if Addon.isClassic then
        Shadows:CreateShadow(_G.HelpFrameHeader.backdrop)
    end

    -- ElvUI panels
    Shadows:CreateShadow(LO.BottomPanel)
    Shadows:CreateShadow(LO.TopPanel)

    -- vehicle Leave
    Shadows:CreateShadow(_G.MainMenuBarVehicleLeaveButton)

    -- Unit Frames
    Shadows:CreateUnitFrameShadows("player")
    Shadows:CreateUnitFrameShadows("pet")
    Shadows:CreateUnitFrameShadows("pettarget")
    Shadows:CreateUnitFrameShadows("target")
    Shadows:CreateUnitFrameShadows("targettarget")
    Shadows:CreateUnitFrameShadows("targettargettarget")
    Shadows:CreateUnitFrameShadows("focus")

    -- Unit Frame Groups
    Shadows:CreateUnitGroupShadows("arena")
    Shadows:CreateUnitGroupShadows("assist")
    Shadows:CreateUnitGroupShadows("boss")
    Shadows:CreateUnitGroupShadows("party")
    Shadows:CreateUnitGroupShadows("raid")
    Shadows:CreateUnitGroupShadows("raid40")
    Shadows:CreateUnitGroupShadows("raidpet")
    Shadows:CreateUnitGroupShadows("tank")

    -- plugins
    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            Shadows:CreateShadow(ccb.MageBar)
            for i, button in ipairs(ccb.MageBar.buttons) do
                Shadows:CreateShadow(button.CurrentAction or button)
            end
        end

        if ccb.ShamanBar then
            Shadows:CreateShadow(ccb.ShamanBar)
            for i, button in ipairs(ccb.ShamanBar.buttons) do
                Shadows:CreateShadow(button.CurrentAction or button)
            end
        end
    end
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Shadows:CreateShadow(_G[merathilis[1].Title .. "TopPanel"])
        Shadows:CreateShadow(_G[merathilis[1].Title .. "BottomPanel"])
    end
end

function Shadows:CreateUnitFrameShadows(frame)
    local unitFrame = UF[frame]
    if unitFrame and (not frame.shadow) then
        if unitFrame.USE_MINI_POWERBAR then
            Shadows:CreateShadow(unitFrame.Health)
        else
            Shadows:CreateShadow(unitFrame)
        end
        if unitFrame.Castbar then
            Shadows:CreateShadow(unitFrame.Castbar.Holder)
            Shadows:CreateShadow(unitFrame.Castbar.ButtonIcon.bg, nil, unitFrame.db.castbar.iconAttached)
        end
        if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
            Shadows:CreateShadow(unitFrame.Power.Holder)
        end
        if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
            Shadows:CreateShadow(unitFrame.ClassBarHolder)
        end
        if unitFrame.Auras and not Shadows:IsHooked(unitFrame.Auras, "PostUpdateIcon") then
            Shadows:SecureHook(unitFrame.Auras, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if unitFrame.Buffs and not Shadows:IsHooked(unitFrame.Buffs, "PostUpdateIcon") then
            Shadows:SecureHook(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if unitFrame.Debuffs and not Shadows:IsHooked(unitFrame.Debuffs, "PostUpdateIcon") then
            Shadows:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
    end
end

function Shadows:CreateUnitGroupShadows(group)
    local header = UF[group]
    if header then
        if header.groups then
            for i, group in next, header.groups do
                for j, obj in next, group do
                    if type(obj) == "table" then
                        if obj.unit then
                            if obj.USE_MINI_POWERBAR then
                                Shadows:CreateShadow(obj.Health)
                                Shadows:CreateShadow(obj.Power)
                            else
                                Shadows:CreateShadow(obj)
                            end
                            if obj.Castbar then
                                Shadows:CreateShadow(obj.Castbar.Holder)
                            end
                        end
                    end
                end
            end
        else
            -- tank, assist
            -- TODO: targets
            for i, obj in next, header do
                if type(obj) == "table" then
                    if obj.unit then
                        if obj.USE_MINI_POWERBAR then
                            Shadows:CreateShadow(obj.Health)
                            Shadows:CreateShadow(obj.Power)
                        else
                            Shadows:CreateShadow(obj)
                        end
                        if obj.Castbar then
                            Shadows:CreateShadow(obj.Castbar.Holder)
                        end
                    end
                end
            end
        end
    end
end

function Shadows:CreateShadow(frame, config, isHidden)
    if frame and (not frame.shadow) then        
        if (not config) then
            config = E.db[addonName].shadows
        end
        frame.shadow = (frame.backdrop or frame):CreateShadow(nil, true)
        frame.shadow.config = config
        frame.shadow.isHidden = frame.shadow.isHidden or ishidden
        Shadows:RegisterShadow(frame.shadow)
        Shadows:UpdateShadow(frame.shadow)
    end
end

function Shadows:UpdateShadows()
    if UnitAffectingCombat("player") then
        Shadows:ScheduleTimer("UpdateShadows", 1)
        return
    end

    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            bar.shadow.isHidden = E.db[addonName].shadows.shadowPerButton

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[j]
                button.shadow.isHidden = not E.db[addonName].shadows.shadowPerButton
            end
        end
    end

    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            ccb.MageBar.shadow.isHidden = E.db[addonName].shadows.shadowPerButton
            for i, button in ipairs(ccb.MageBar.buttons) do
                (button.CurrentAction or button).shadow.isHidden = not E.db[addonName].shadows.shadowPerButton
            end
        end

        if ccb.ShamanBar then
            ccb.ShamanBar.shadow.isHidden = E.db[addonName].shadows.shadowPerButton
            for i, button in ipairs(ccb.ShamanBar.buttons) do
                (button.CurrentAction or button).shadow.isHidden = not E.db[addonName].shadows.shadowPerButton
            end
        end
    end

    for shadow, _ in pairs(Shadows.registeredShadows) do
        Shadows:UpdateShadow(shadow)
    end
end

function Shadows:UpdateShadow(shadow)
    if not E.db[addonName].shadows.enabled or shadow.isHidden then
        shadow:Hide()
    else
        shadow:Show()

        local frame = shadow:GetParent()
        shadow:SetFrameLevel(0)
        shadow:SetOutside(frame, shadow.config.size or 3, shadow.config.size or 3)
        shadow:SetBackdrop({edgeFile = LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(2 + (shadow.config.size or 3))})
        shadow:SetBackdropColor(shadow.config.color[1], shadow.config.color[2], shadow.config.color[3], 0)
        shadow:SetBackdropBorderColor(unpack(shadow.config.color))
    end
end

function Shadows:GROUP_ROSTER_UPDATE()
    Shadows:UpdateShadows()
end
