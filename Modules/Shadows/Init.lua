local addonName, addonTable = ...
local Addon = addonTable[1]
local Shadows = Addon:NewModule(addonName .. "Shadows", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Shadows = Shadows
local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local LO = E:GetModule("Layout")
local NP = E:GetModule("NamePlates")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Shadows:Initialize()
    Shadows:CreateShadows()
    Shadows:ScheduleTimer("UpdateShadows", 1)
    Shadows:RegisterEvent("ADDON_LOADED", Shadows.ADDON_LOADED)
    Shadows:RegisterEvent("GROUP_ROSTER_UPDATE", Shadows.GROUP_ROSTER_UPDATE)
end

function Shadows:CreateShadows()
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

    -- Action Bars    
    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        Shadows:CreateShadow(AB.handledBars["bar" .. i])

        for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
            local button = bar.buttons[j]
            Shadows:CreateShadow(button)
        end
    end

    -- Addon Manager
    Shadows:CreateShadow(_G.AddonList)

    -- Bags
    Shadows:CreateShadow(B.BagFrame)
    Shadows:CreateShadow(B.BankFrame)

    -- BG Score
    if Addon.isClassic then
        Shadows:CreateShadow(_G.WorldStateScoreFrame.backdrop)
    end

    -- Chat
    Shadows:CreateShadow(_G.LeftChatPanel.backdrop)
    Shadows:CreateShadow(_G.LeftChatDataPanel)
    Shadows:CreateShadow(_G.LeftChatToggleButton)
    Shadows:CreateShadow(_G.RightChatPanel.backdrop)
    Shadows:CreateShadow(_G.RightChatDataPanel)
    Shadows:CreateShadow(_G.RightChatToggleButton)

    -- Data Bars
    Shadows:CreateShadow(DB.expBar)
    Shadows:CreateShadow(DB.petExpBar)
    Shadows:CreateShadow(DB.repBar)

    -- Channels
    Shadows:CreateShadow(_G.ChannelFrame)

    -- Chat Config
    Shadows:CreateShadow(_G.ChatConfigFrame)

    -- Character Frame
    Shadows:CreateShadow(_G.CharacterFrame.backdrop)
    if CharacterModelFrame.Background then
        Shadows:CreateShadow(_G.CharacterModelFrame)
    end
    Shadows:CreateShadow(_G.ReputationDetailFrame)
    for i = 1, #CHARACTERFRAME_SUBFRAMES do
        local tab = _G["CharacterFrameTab" .. i]
        if tab and false then
            Shadows:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.CharacterFrame:GetFrameLevel() - 1)
        end
    end
    local slots = {
        "HeadSlot",
        "NeckSlot",
        "ShoulderSlot",
        "BackSlot",
        "ChestSlot",
        "ShirtSlot",
        "TabardSlot",
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
    for i, slot in next, slots do
        local button = _G["Character" .. slot]
        if button then
            Shadows:CreateShadow(button)
        end
    end

    -- Color Picker
    Shadows:CreateShadow(_G.ColorPickerFrame)

    -- DressUp
    Shadows:CreateShadow(_G.DressUpFrame.backdrop)

    -- Friends Frame
    Shadows:CreateShadow(_G.FriendsFrame.backdrop)
    Shadows:CreateShadow(_G.AddFriendFrame)
    if Addon.isClassic then
        Shadows:CreateShadow(_G.GuildInfoFrame.backdrop)
        Shadows:CreateShadow(_G.GuildMemberDetailFrame)
        Shadows:CreateShadow(_G.GuildControlPopupFrame.backdrop)
    end
    Shadows:CreateShadow(_G.RaidInfoFrame)
    for i = 1, #_G.FRIENDSFRAME_SUBFRAMES do
        local tab = _G["FriendsFrameTab" .. i]
        if tab and false then
            Shadows:CreateShadow(tab.backdrop)
            -- tab.backdrop:SetFrameLevel(_G.FriendsFrame:GetFrameLevel() - 1)
        end
    end

    -- Game Menu
    Shadows:CreateShadow(_G.GameMenuFrame)

    -- Gossip
    Shadows:CreateShadow(_G.GossipFrame.backdrop)

    -- Guild Registrar
    Shadows:CreateShadow(_G.GuildRegistrarFrame.backdrop)

    -- Help
    Shadows:CreateShadow(_G.HelpFrame)
    if Addon.isClassic then
        Shadows:CreateShadow(_G.HelpFrameHeader.backdrop)
    end

    -- Interface Options
    Shadows:CreateShadow(_G.InterfaceOptionsFrame)

    -- Loot History
    Shadows:CreateShadow(_G.LootFrame)
    Shadows:CreateShadow(_G.LootHistoryFrame)
    Shadows:CreateShadow(_G.MasterLooterFrame)

    -- Mail Frame
    Shadows:CreateShadow(_G.MailFrame.backdrop)
    Shadows:CreateShadow(_G.OpenMailFrame.backdrop)

    -- Merchant Frame
    Shadows:CreateShadow(_G.MerchantFrame.backdrop)

    -- Minimap
    Shadows:CreateShadow(_G.MMHolder)

    -- Mirror Timers
    for i = 1, 3 do
        Shadows:CreateShadow(_G["MirrorTimer" .. i .. "StatusBar"])
    end

    -- Panels
    Shadows:CreateShadow(LO.BottomPanel)
    Shadows:CreateShadow(LO.TopPanel)

    -- Pet Stable Frame
    Shadows:CreateShadow(_G.PetStableFrame.backdrop)

    -- Petition Frame
    Shadows:CreateShadow(_G.PetitionFrame.backdrop)

    -- Popups    
    for i = 1, 4 do
        local popup = _G["StaticPopup" .. i]
        Shadows:CreateShadow(popup)
    end
    for i = 1, 4 do
        local popup = _G["ElvUI_StaticPopup" .. i]
        Shadows:CreateShadow(popup)
    end
    Shadows:CreateShadow(_G.StackSplitFrame)

    -- Quest Frame
    Shadows:CreateShadow(_G.QuestFrame.backdrop)
    if Addon.isClassic then
        Shadows:CreateShadow(_G.QuestLogFrame.backdrop)
    end

    -- Raid Utility Panel
    Shadows:CreateShadow(_G.RaidUtilityPanel)
    Shadows:CreateShadow(_G.RaidUtility_ShowButton)
    Shadows:CreateShadow(_G.RaidUtility_CloseButton)
    Shadows:CreateShadow(_G.RaidControlButton)

    -- Ready Check
    Shadows:CreateShadow(_G.ReadyCheckFrame)

    -- Script Errors
    Shadows:CreateShadow(_G.ScriptErrorsFrame)

    -- Spellbook Frame
    Shadows:CreateShadow(_G.SpellBookFrame.backdrop)
    for i = 1, _G.MAX_SKILLLINE_TABS do
        local tab = _G["SpellBookSkillLineTab" .. i]
        Shadows:CreateShadow(tab)
        -- tab:SetFrameLevel(_G.SpellBookFrame:GetFrameLevel() - 1)
    end

    -- Tabard
    Shadows:CreateShadow(_G.TabardFrame.backdrop)

    -- Taxi
    Shadows:CreateShadow(_G.TaxiFrame.backdrop)

    -- Tooltips	
    Shadows:CreateShadow(_G.GameTooltip)
    Shadows:CreateShadow(_G.GameTooltipStatusBar)
    Shadows:CreateShadow(_G.ItemRefTooltip)
    Shadows:CreateShadow(_G.ItemRefShoppingTooltip1)
    Shadows:CreateShadow(_G.ItemRefShoppingTooltip2)
    Shadows:CreateShadow(_G.AutoCompleteBox)
    Shadows:CreateShadow(_G.FriendsTooltip)
    Shadows:CreateShadow(_G.ShoppingTooltip1)
    Shadows:CreateShadow(_G.ShoppingTooltip2)
    Shadows:CreateShadow(_G.EmbeddedItemTooltip)
    Shadows:CreateShadow(DT.tooltip)
    -- TODO: Options dialog tooltips

    -- Trade
    Shadows:CreateShadow(_G.TradeFrame.backdrop)

    -- Tutorial
    Shadows:CreateShadow(_G.TutorialFrame)

    -- Video Options (System)
    Shadows:CreateShadow(_G.VideoOptionsFrame)

    -- World Map
    Shadows:CreateShadow(_G.WorldMapFrame)

    -- Plugins
    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            Shadows:CreateShadow(ccb.MageBar)
            for i, button in ipairs(ccb.MageBar.buttons) do
                Shadows:CreateShadow(button)
            end
        end

        if ccb.ShamanBar then
            Shadows:CreateShadow(ccb.ShamanBar)
            for i, button in ipairs(ccb.ShamanBar.buttons) do
                Shadows:CreateShadow(button)
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
        end
        if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
            Shadows:CreateShadow(unitFrame.Power.Holder)
        end
        if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
            Shadows:CreateShadow(unitFrame.ClassBarHolder)
        end
        hooksecurefunc(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
            Shadows:CreateShadow(button)
        end)
        hooksecurefunc(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Shadows:CreateShadow(button)
        end)
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

function Shadows:CreateShadow(frame, config)
    if frame and (not frame.shadow) then
        frame:CreateShadow()
        if (not config) then
            config = E.db[addonName].shadows
        end
        frame.shadow.config = config
        Shadows:RegisterShadow(frame.shadow)
        Shadows:UpdateShadow(frame.shadow)
    end
end

function Shadows:UpdateShadows()
    if UnitAffectingCombat("player") then
        Shadows:ScheduleTimer("UpdateShadows", 1)
        return
    end

    -- Action Bars    
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
                button.shadow.isHidden = not E.db[addonName].shadows.shadowPerButton
            end
        end

        if ccb.ShamanBar then
            ccb.ShamanBar.shadow.isHidden = E.db[addonName].shadows.shadowPerButton
            for i, button in ipairs(ccb.ShamanBar.buttons) do
                button.shadow.isHidden = not E.db[addonName].shadows.shadowPerButton
            end
        end
    end

    Shadows:CreateShadows()
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
        shadow:SetFrameLevel(1)
        shadow:SetFrameStrata(frame:GetFrameStrata())
        shadow:SetOutside(frame, shadow.config.size or 3, shadow.config.size or 3)
        shadow:SetBackdrop({
            edgeFile = LSM:Fetch("border", "ElvUI GlowBorder"),
            edgeSize = E:Scale(2 + (shadow.config.size or 3))
        })
        shadow:SetBackdropColor(shadow.config.color[1], shadow.config.color[2], shadow.config.color[3], 0)
        shadow:SetBackdropBorderColor(unpack(shadow.config.color))
    end
end

function Shadows:GROUP_ROSTER_UPDATE()
    Shadows:UpdateShadows()
end

function Shadows:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Shadows:ScheduleTimer("LoadAuctionFrame", 0.01)
    elseif addonName == "Blizzard_BindingUI" then
        Shadows:ScheduleTimer("LoadBindingsFrame", 0.01)
    elseif addonName == "Blizzard_Communities" then
        Shadows:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    elseif addonName == "Blizzard_CraftUI" then
        Shadows:ScheduleTimer("LoadCraftFrame", 0.01)
    elseif addonName == "Blizzard_GMChatUI" then
        Shadows:ScheduleTimer("LoadGMChatFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Shadows:ScheduleTimer("LoadInspectFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Shadows:ScheduleTimer("LoadMacroFrame", 0.01)
    elseif addonName == "Blizzard_RaidUI" then
        Shadows:ScheduleTimer("LoadRaidFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Shadows:ScheduleTimer("LoadTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Shadows:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Shadows:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end

function Shadows:LoadAuctionFrame()
    if _G.AuctionFrame then
        Shadows:CreateShadow(_G.AuctionFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadAuctionFrame", 0.01)
    end
end

function Shadows:LoadBindingsFrame()
    if _G.KeyBindingFrame then
        Shadows:CreateShadow(_G.KeyBindingFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadBindingsFrame", 0.01)
    end
end

function Shadows:LoadCommunitiesFrame()
    if _G.CommunitiesFrame then
        Shadows:CreateShadow(_G.CommunitiesFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    end
end

function Shadows:LoadCraftFrame()
    if _G.CraftFrame then
        Shadows:CreateShadow(_G.CraftFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadCraftFrame", 0.01)
    end
end

function Shadows:LoadGMChatFrame()
    if _G.GMChatFrame then
        Shadows:CreateShadow(_G.GMChatFrame)
    else
        Shadows:ScheduleTimer("LoadGMChatFrame", 0.01)
    end
end

function Shadows:LoadInspectFrame()
    if _G.InspectFrame then
        Shadows:CreateShadow(_G.InspectFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadInspectFrame", 0.01)
    end
end

function Shadows:LoadMacroFrame()
    if _G.MacroFrame then
        Shadows:CreateShadow(_G.MacroFrame.backdrop)
        Shadows:CreateShadow(_G.MacroPopupFrame)
    else
        Shadows:ScheduleTimer("LoadMacroFrame", 0.01)
    end
end

function Shadows:LoadRaidFrame()
    if _G["RaidPullout1"] then
        local rp
        for i = 1, _G.NUM_RAID_PULLOUT_FRAMES do
            rp = _G["RaidPullout" .. i]
            Shadows:CreateShadow(rp.backdrop)
        end
    else
        Shadows:ScheduleTimer("LoadRaidFrame", 0.01)
    end
end

function Shadows:LoadTalentFrame()
    if _G.TalentFrame then
        Shadows:CreateShadow(_G.TalentFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadTalentFrame", 0.01)
    end
end

function Shadows:LoadTradeSkillFrame()
    if _G.TradeSkillFrame then
        Shadows:CreateShadow(_G.TradeSkillFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    end
end

function Shadows:LoadTrainerFrame()
    if _G.ClassTrainerFrame then
        Shadows:CreateShadow(_G.ClassTrainerFrame.backdrop)
    else
        Shadows:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end
