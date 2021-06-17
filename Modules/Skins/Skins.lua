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
    Skins:SkinActionBars()
    Skins:SkinBags()
    Skins:SkinBlizzardOptions()
    Skins:SkinChat()
    Skins:SkinMerchantFrame()
    Skins:SkinPopups()
    Skins:SkinUnitFrames()

    Skins:HandleFrame(_G.GameMenuFrame)
    Skins:HandleFrame(_G.ScriptErrorsFrame)
    Skins:HandleFrame(_G.HelpFrame)
    Skins:HandleFrame(_G.StackSplitFrame)
    Skins:HandleFrame(_G.ElvLootFrame)
    Skins:HandleFrame(_G.LootFrame)
    Skins:HandleFrame(_G.LootHistoryFrame)
    Skins:HandleFrame(_G.MasterLooterFrame)
    Skins:HandleFrame(_G.ReadyCheckFrame)
    Skins:HandleFrame(_G.WorldMapFrame.BorderFrame)
    Skins:HandleFrame(_G.MMHolder)
    Skins:HandleFrame(_G.ColorPickerFrame)
    Skins:HandleFrame(_G.CopyChatFrame)
    Skins:HandleFrame(_G.ReputationDetailFrame)
    Skins:HandleFrame(_G.AddFriendFrame)
    Skins:HandleFrame(_G.GuildInfoFrame)
    Skins:HandleFrame(_G.GuildControlPopupFrame)
    Skins:HandleFrame(_G.GuildMemberDetailFrame)
    Skins:HandleFrame(_G.RaidInfoFrame)
    Skins:HandleFrame(_G.ItemSocketingFrame)

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

    -- skin character resistance icons
    for i = 1, 5 do
        Skins:HandleButton(_G["MagicResFrame" .. i])
    end

    -- skin arena teams
    for i = 1, _G.MAX_ARENA_TEAMS do
        Skins:HandleButton(_G["PVPTeam" .. i])
    end

    -- skin quest log items
    local questLogItems = {["QuestLogItem"] = _G.MAX_NUM_ITEMS, ["QuestProgressItem"] = _G.MAX_REQUIRED_ITEMS}
    for frame, count in pairs(questLogItems) do
        for i = 1, count do
            Skins:HandleLargeItemButton(_G[frame .. i])
        end
    end

    -- Mail items
    for i = 1, _G.INBOXITEMS_TO_DISPLAY do
        local mail = _G["MailItem" .. i]
        local button = _G["MailItem" .. i .. "Button"]

        Skins:HandleButton(mail)
        Skins:HandleButton(mail.bg)
        Skins:HandleButton(button)
        button.shadow.isHidden = true
        button.shadow:Update()
    end

    -- Send mail
    Skins:HandleInsetFrame(_G.SendMailScrollFrame)
    Skins:SecureHook(nil, "SendMailFrame_Update", function()
        for i = 1, _G.ATTACHMENTS_MAX_SEND do
            Skins:HandleButton(_G["SendMailAttachment" .. i])
        end
    end)

    -- Open mail
    Skins:HandleInsetFrame(_G.OpenMailScrollFrame)
    for i = 1, _G.ATTACHMENTS_MAX_SEND do
        Skins:HandleButton(_G["OpenMailAttachmentButton" .. i])
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

    -- Battle.Net status edit
    Skins:HandleEditBox(_G.FriendsFrameBroadcastInput)
    Skins:HandleEditBox(_G.GuildInfoTextBackground)
    Skins:HandleEditBox(_G.GuildMemberNoteBackground)
    Skins:HandleEditBox(_G.GuildMemberOfficerNoteBackground)
    Skins:HandleEditBox(_G.GuildMOTDEditButton)

    -- Help
    if Addon.isClassic then
        Skins:HandleFrame(_G.HelpFrameHeader)
    end

    -- ElvUI panels
    Skins:HandleDecorativePanel(LO.BottomPanel, "BOTTOM")
    Skins:HandleDecorativePanel(LO.TopPanel, "TOP")
    Skins:HandleDecorativePanel(AFK.AFKMode.bottom, "BOTTOM")

    -- plugins: ElvUI_MerathilisUI
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Skins:HandleDecorativePanel(_G[merathilis[1].Title .. "TopPanel"], "TOP")
        Skins:HandleDecorativePanel(_G[merathilis[1].Title .. "BottomPanel"], "BOTTOM")
    end

    Skins:RegisterEvent("ADDON_LOADED", Skins.ADDON_LOADED)
    Skins:RegisterEvent("GROUP_ROSTER_UPDATE", Skins.GROUP_ROSTER_UPDATE)

    Skins:ApplyCustomLayout()
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
        -- border:Update()
    end
end

function Skins:ApplyCustomLayout()
    -- add icons to guild member details frames    
    _G.GuildMemberDetailFrame.icon = _G.GuildMemberDetailFrame:CreateTexture("$parentIcon", "ARTWORK")
    _G.GuildMemberDetailFrame.icon:SetPoint("TOPLEFT", _G.GuildMemberDetailName, "TOPLEFT", -30, 0)
    _G.GuildMemberDetailFrame.icon:SetSize(25, 25)
    _G.GuildMemberDetailFrame.icon:SetTexture([[Interface\WorldStateFrame\Icons-Classes]])
    _G.GuildMemberDetailName:Offset(30, 0)
    _G.GuildMemberDetailZoneLabel:Offset(-30, 0)

    Skins:SecureHook("GuildStatus_Update", function()
        local selection = GetGuildRosterSelection()
        if selection then
            local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(selection)
            local classFileName = E:UnlocalizedClassName(class)
            local classTextColor = _G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[classFileName] or
                                       _G.RAID_CLASS_COLORS[classFileName]
            if classTextColor then
                local levelTextColor = GetQuestDifficultyColor(level)
                _G.GuildMemberDetailName:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
                _G.GuildMemberDetailLevel:SetTextColor(levelTextColor.r, levelTextColor.g, levelTextColor.b)
                if _G.GuildMemberDetailFrame.icon then
                    _G.GuildMemberDetailFrame.icon:SetTexCoord(unpack(_G.CLASS_ICON_TCOORDS[classFileName]))
                end
            end
        end
    end)
end

function Skins:GetBorderColor(frame)
    local color
    local parent = frame.backdrop or frame
    if parent.GetBackdropBorderColor then
        color = {parent:GetBackdropBorderColor()}
    end

    return color or E.media.bordercolor
end

function Skins:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Skins:ScheduleTimer("SkinAuctionFrame", 0.01)
    elseif addonName == "Blizzard_CraftUI" then
        Skins:ScheduleTimer("SkinCraftFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Skins:ScheduleTimer("SkinInspectFrame", 0.01)
    elseif addonName == "Blizzard_ItemSocketingUI" then
        Skins:ScheduleTimer("SkinItemSocketingFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Skins:ScheduleTimer("SkinMacroFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Skins:ScheduleTimer("SkinTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Skins:ScheduleTimer("SkinTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Skins:ScheduleTimer("SkinTrainerFrame", 0.01)
    end
end

function Skins:SkinActionBars()
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
end

function Skins:SkinAuctionFrame()
    Skins:HandleItemButton(_G.AuctionsItemButton)

    for _, frame in pairs({_G.AuctionFrameBrowse, _G.AuctionFrameAuctions}) do
        Skins:HandleInsetFrame(frame.LeftBackground)
        Skins:HandleInsetFrame(frame.RightBackground)
    end

    for frame, numButtons in pairs({
        ["Browse"] = _G.NUM_BROWSE_TO_DISPLAY,
        ["Auctions"] = _G.NUM_AUCTIONS_TO_DISPLAY,
        ["Bid"] = _G.NUM_BIDS_TO_DISPLAY
    }) do
        for i = 1, numButtons do
            Skins:HandleItemButton(_G[frame .. "Button" .. i .. "Item"])
        end
    end
end

function Skins:SkinBags()
    B.BagFrame.title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.title:FontTemplate()
    B.BagFrame.title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.title:SetText(_G.INVENTORY_TOOLTIP)

    Skins:HandleFrame(B.BagFrame)
    Skins:HandleFrame(B.BagFrame.editBox)
    Skins:HandleButton(B.BagFrame.bagsButton)
    Skins:HandleButton(B.BagFrame.sortButton)
    Skins:HandleButton(B.BagFrame.vendorGraysButton)
    Skins:HandleButton(B.BagFrame.keyRingButton)
    Skins:HandleFrame(B.BagFrame.ContainerHolder)
    for i, bagID in next, B.BagFrame.BagIDs do
        Skins:HandleItemButton(B.BagFrame.ContainerHolder[i])
    end

    B.BankFrame.title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.title:FontTemplate()
    B.BankFrame.title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.title:SetText(_G.BANK)

    Skins:HandleFrame(B.BankFrame)
    Skins:HandleFrame(B.BankFrame.editBox)
    Skins:HandleButton(B.BankFrame.bagsButton)
    Skins:HandleButton(B.BankFrame.sortButton)
    Skins:HandleButton(B.BankFrame.purchaseBagButton)
    Skins:HandleFrame(B.BankFrame.ContainerHolder)
    for i, bagID in next, B.BankFrame.BagIDs do
        Skins:HandleItemButton(B.BankFrame.ContainerHolder[i])
    end

    Skins:HandleFrame(B.SellFrame)
end

function Skins:SkinBlizzardOptions()
    local frames = {
        _G.InterfaceOptionsFrame,
        _G.InterfaceOptionsFrameCategories,
        _G.InterfaceOptionsFramePanelContainer,
        _G.InterfaceOptionsFrameAddOns,
        _G.VideoOptionsFrame,
        _G.VideoOptionsFrameCategoryFrame,
        _G.VideoOptionsFramePanelContainer,
        _G.Display_,
        _G.Graphics_,
        _G.RaidGraphics_
    }
    local backdrops = {
        _G.AudioOptionsSoundPanelHardware,
        _G.AudioOptionsSoundPanelVolume,
        _G.AudioOptionsSoundPanelPlayback,
        _G.AudioOptionsVoicePanelTalking,
        _G.AudioOptionsVoicePanelListening,
        _G.AudioOptionsVoicePanelBinding
    }

    for _, frame in pairs(frames) do
        Skins:HandleFrame(frame)
    end

    for _, frame in pairs(backdrops) do
        Skins:HandleFrame(frame)
    end

    Skins:SecureHook(nil, "AudioOptionsVoicePanel_InitializeCommunicationModeUI", function(self)
        Skins:HandleButton(self.PushToTalkKeybindButton)
    end)

    Skins:SecureHook(nil, "GraphicsOptions_SelectBase", function(self)
        _G.GraphicsButton._border:SetFrameLevel(_G.GraphicsButton:GetFrameLevel() + 1)
        _G.RaidButton._border:SetFrameLevel(_G.RaidButton:GetFrameLevel() + 1)
    end)

    Skins:SecureHook(nil, "GraphicsOptions_SelectRaid", function(self)
        _G.GraphicsButton._border:SetFrameLevel(_G.GraphicsButton:GetFrameLevel() + 1)
        _G.RaidButton._border:SetFrameLevel(_G.RaidButton:GetFrameLevel() + 1)
    end)

    local chatFrames = {
        _G.ChatConfigFrame,
        _G.ChatConfigCategoryFrame,
        _G.ChatConfigBackgroundFrame,
        _G.ChatConfigCombatSettingsFilters,
        _G.ChatConfigCombatSettingsFiltersScrollFrame,
        _G.CombatConfigColorsHighlighting,
        _G.CombatConfigColorsColorizeUnitName,
        _G.CombatConfigColorsColorizeSpellNames,
        _G.CombatConfigColorsColorizeDamageNumber,
        _G.CombatConfigColorsColorizeDamageSchool,
        _G.CombatConfigColorsColorizeEntireLine,
        _G.ChatConfigChatSettingsLeft,
        _G.ChatConfigOtherSettingsCombat,
        _G.ChatConfigOtherSettingsPVP,
        _G.ChatConfigOtherSettingsSystem,
        _G.ChatConfigOtherSettingsCreature,
        _G.ChatConfigChannelSettingsLeft,
        _G.CombatConfigMessageSourcesDoneBy,
        _G.CombatConfigColorsUnitColors,
        _G.CombatConfigMessageSourcesDoneTo
    }

    for _, frame in pairs(chatFrames) do
        Skins:HandleFrame(frame)
    end
end

function Skins:SkinChat()
    Skins:HandleChatPanel(_G.LeftChatPanel)
    Skins:HandleButton(_G.LeftChatToggleButton)
    Skins:HandleChatPanel(_G.RightChatPanel)
    Skins:HandleButton(_G.RightChatToggleButton)
    Skins:HandleFrame(_G.ChatButtonHolder)

    Skins:SecureHook(nil, "ChatEdit_UpdateHeader", function(editbox)
        Skins:HandleEditBox(editbox)
    end)
end

function Skins:SkinCraftFrame()
end

function Skins:SkinInspectFrame()
    for _, slot in ipairs({_G.InspectPaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Skins:HandleItemButton(slot)
        end
    end
    for i = 1, _G.MAX_NUM_TALENTS do
        Skins:HandleTalentButton(_G["InspectTalentFrameTalent" .. i])
    end
end

function Skins:SkinItemSocketingFrame()
    Skins:HandleInsetFrame(_G.ItemSocketingScrollFrame)
    for i = 1, _G.MAX_NUM_SOCKETS do
        Skins:HandleButton(_G[("ItemSocketingSocket%d"):format(i)])
        -- TODO: icon is overlaying border, fix that
    end
end

function Skins:SkinMacroFrame()
    for i = 1, _G.MAX_ACCOUNT_MACROS do
        Skins:HandleIcon(_G["MacroButton" .. i])
    end

    Skins:HandleIcon(_G.MacroFrameSelectedMacroButton)
end

function Skins:SkinMerchantFrame()
    for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
        Skins:HandleButton(_G["MerchantItem" .. i])
        Skins:HandleButton(_G["MerchantItem" .. i .. "ItemButton"])
    end
    Skins:HandleButton(_G.MerchantBuyBackItemItemButton)
end

function Skins:SkinPopups()
    for i = 1, 4 do
        Skins:HandleFrame(_G["StaticPopup" .. i])
        Skins:HandleFrame(_G["ElvUI_StaticPopup" .. i])
    end
end

function Skins:SkinTalentFrame()
    Skins:HandleFrame(_G.PlayerTalentFrameScrollFrame)
    _G.PlayerTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.PlayerTalentFrameScrollFrame:Size(301, 332)

    for i = 1, _G.MAX_NUM_TALENTS do
        Skins:HandleTalentButton(_G["PlayerTalentFrameTalent" .. i])
    end
end

function Skins:SkinTradeSkillFrame()
    Skins:HandleIcon(_G.TradeSkillSkillIcon)
    Skins:HandleStatusBar(_G.TradeSkillRankFrame)
end

function Skins:SkinTrainerFrame()
    Skins:HandleButton(_G.ClassTrainerSkillIcon)
    Skins:SecureHook("ClassTrainer_SetSelection", function()
        Skins:HandleButton(_G.ClassTrainerSkillIcon)
    end)
end

function Skins:SkinUnitFrames()
    Skins:HandleUnitFrame("player")
    Skins:HandleUnitFrame("pet")
    Skins:HandleUnitFrame("pettarget")
    Skins:HandleUnitFrame("target")
    Skins:HandleUnitFrame("targettarget")
    Skins:HandleUnitFrame("targettargettarget")
    Skins:HandleUnitFrame("focus")
    Skins:HandleUnitFrame("arena1")
    Skins:HandleUnitFrame("arena2")
    Skins:HandleUnitFrame("arena3")
    Skins:HandleUnitFrame("arena4")
    Skins:HandleUnitFrame("arena5")

    Skins:HandleUnitFrameGroup("assist")
    Skins:HandleUnitFrameGroup("boss")
    Skins:HandleUnitFrameGroup("party")
    Skins:HandleUnitFrameGroup("raid")
    Skins:HandleUnitFrameGroup("raid40")
    Skins:HandleUnitFrameGroup("raidpet")
    Skins:HandleUnitFrameGroup("tank")
end

function Skins:GROUP_ROSTER_UPDATE()
    Skins:Update()
end
