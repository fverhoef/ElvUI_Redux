local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local AB = E:GetModule("ActionBars")
local AFK = E:GetModule("AFK")
local B = E:GetModule("Bags")
local LO = E:GetModule("Layout")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Addon:ApplySkins()
    Addon:SkinActionBars()
    Addon:SkinArenaRegistrarFrame()
    Addon:SkinBags()
    Addon:SkinBlizzardOptions()
    Addon:SkinCharacterFrame()
    Addon:SkinChat()
    Addon:SkinDecorativePanels()
    Addon:SkinFriendsFrame()
    Addon:SkinHelpFrame()
    Addon:SkinMailFrame()
    Addon:SkinMerchantFrame()
    Addon:SkinMinimap()
    Addon:SkinMirrorTimers()
    Addon:SkinPopups()
    Addon:SkinQuestLog()
    Addon:SkinRaidUtilityFrame()
    Addon:SkinSpellbook()
    Addon:SkinTradeFrame()
    Addon:SkinUnitFrames()
    Addon:SkinWorldMap()

    Addon:SkinElvUIInstallerFrames()

    Addon:HandleFrame(_G.GameMenuFrame)
    Addon:HandleFrame(_G.ScriptErrorsFrame)
    Addon:HandleFrame(_G.StackSplitFrame)
    Addon:HandleFrame(_G.StackSplitFrame.bg1)
    Addon:HandleFrame(_G.ReadyCheckFrame)
    Addon:HandleFrame(_G.ElvLootFrame)
    Addon:HandleFrame(_G.LootFrame)
    Addon:HandleFrame(_G.LootHistoryFrame)
    Addon:HandleFrame(_G.MasterLooterFrame)
    Addon:HandleFrame(_G.ColorPickerFrame)
    Addon:HandleFrame(_G.ItemSocketingFrame)
    Addon:HandleFrame(_G.StopwatchFrame)
    Addon:HandleFrame(_G.ArenaFrame)
    Addon:HandleFrame(_G.BattlefieldFrame)

    if _G.Minimap.ButtonFrame then
        Addon:CreateShadow(_G.Minimap.ButtonFrame.Container)
        Addon:CreateBorder(_G.Minimap.ButtonFrame.Container, Addon.BORDER_CONFIG_KEYS.MINIMAP)
    end

    Addon:RegisterEvent("ADDON_LOADED", Addon.ADDON_LOADED)
end

function Addon:UpdateSkins()
    if UnitAffectingCombat("player") then
        Addon:ScheduleTimer("UpdateSkins", 1)
        return
    end

    local config = E.db[addonName]

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

    for shadow, _ in pairs(Addon.registry.shadows) do
        shadow:Update()
    end

    for border, _ in pairs(Addon.registry.borders) do
        border:Update()
    end
end

function Addon:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Addon:ScheduleTimer("SkinAuctionFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Addon:ScheduleTimer("SkinInspectFrame", 0.01)
    elseif addonName == "Blizzard_ItemSocketingUI" then
        Addon:ScheduleTimer("SkinItemSocketingFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Addon:ScheduleTimer("SkinMacroFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Addon:ScheduleTimer("SkinTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Addon:ScheduleTimer("SkinTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Addon:ScheduleTimer("SkinTrainerFrame", 0.01)
    end
end

function Addon:SkinActionBars()
    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            Addon:HandleActionBar(bar)

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[j]
                Addon:HandleActionButton(button)
            end
        end
    end

    Addon:HandleFrame(_G.ElvUI_MicroBar)

    -- vehicle Leave
    Addon:HandleActionButton(_G.MainMenuBarVehicleLeaveButton)

    -- plugins: ElvUI_ClassicClassBars
    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            Addon:HandleActionBar(ccb.MageBar)

            for i, button in ipairs(ccb.MageBar.buttons) do
                Addon:HandleActionButton(button.CurrentAction or button)
            end
        end

        if ccb.ShamanBar then
            Addon:HandleActionBar(ccb.ShamanBar)

            for i, button in ipairs(ccb.ShamanBar.buttons) do
                Addon:HandleActionButton(button.CurrentAction or button)
            end
        end
    end
end

function Addon:SkinArenaRegistrarFrame()
    Addon:HandleFrame(_G.ArenaRegistrarFrame)
    Addon:HandleFrame(_G.PVPBannerFrame)
end

function Addon:SkinAuctionFrame()
    Addon:HandleItemButton(_G.AuctionsItemButton)

    for _, frame in pairs({_G.AuctionFrameBrowse, _G.AuctionFrameAuctions}) do
        Addon:HandleInsetFrame(frame.LeftBackground)
        Addon:HandleInsetFrame(frame.RightBackground)
    end

    for frame, numButtons in pairs({
        ["Browse"] = _G.NUM_BROWSE_TO_DISPLAY,
        ["Auctions"] = _G.NUM_AUCTIONS_TO_DISPLAY,
        ["Bid"] = _G.NUM_BIDS_TO_DISPLAY
    }) do
        for i = 1, numButtons do
            Addon:HandleItemButton(_G[frame .. "Button" .. i .. "Item"])
        end
    end
end

function Addon:SkinBags()
    B.BagFrame.title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.title:FontTemplate()
    B.BagFrame.title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.title:SetText(_G.INVENTORY_TOOLTIP)

    Addon:HandleFrame(B.BagFrame)
    Addon:HandleFrame(B.BagFrame.editBox)
    Addon:HandleButton(B.BagFrame.bagsButton)
    Addon:HandleButton(B.BagFrame.sortButton)
    Addon:HandleButton(B.BagFrame.vendorGraysButton)
    Addon:HandleButton(B.BagFrame.keyRingButton)
    Addon:HandleFrame(B.BagFrame.ContainerHolder)
    for i, bagID in next, B.BagFrame.BagIDs do
        Addon:HandleItemButton(B.BagFrame.ContainerHolder[i])
    end

    B.BankFrame.title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.title:FontTemplate()
    B.BankFrame.title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.title:SetText(_G.BANK)

    Addon:HandleFrame(B.BankFrame)
    Addon:HandleFrame(B.BankFrame.editBox)
    Addon:HandleButton(B.BankFrame.bagsButton)
    Addon:HandleButton(B.BankFrame.sortButton)
    Addon:HandleButton(B.BankFrame.purchaseBagButton)
    Addon:HandleFrame(B.BankFrame.ContainerHolder)
    for i, bagID in next, B.BankFrame.BagIDs do
        Addon:HandleItemButton(B.BankFrame.ContainerHolder[i])
    end

    Addon:HandleFrame(B.SellFrame)
end

function Addon:SkinBlizzardOptions()
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
        Addon:HandleFrame(frame)
    end

    for _, frame in pairs(backdrops) do
        Addon:HandleFrame(frame)
    end

    _G.InterfaceOptionsFrameTab1:CreateBackdrop()
    Addon:HandleTab(_G.InterfaceOptionsFrameTab1, nil, "UP")
    _G.InterfaceOptionsFrameTab2:CreateBackdrop()
    Addon:HandleTab(_G.InterfaceOptionsFrameTab2, nil, "UP")

    Addon:SecureHook(nil, "AudioOptionsVoicePanel_InitializeCommunicationModeUI", function(self)
        Addon:HandleButton(self.PushToTalkKeybindButton)
    end)

    Addon:SecureHook(nil, "GraphicsOptions_SelectBase", function(self)
        _G.GraphicsButton.shadow:SetFrameLevel(0)
        _G.GraphicsButton.border:SetFrameLevel(_G.GraphicsButton:GetFrameLevel() + 1)
        _G.RaidButton.shadow:SetFrameLevel(0)
        _G.RaidButton.border:SetFrameLevel(_G.RaidButton:GetFrameLevel() + 1)
    end)

    Addon:SecureHook(nil, "GraphicsOptions_SelectRaid", function(self)
        _G.GraphicsButton.shadow:SetFrameLevel(0)
        _G.GraphicsButton.border:SetFrameLevel(_G.GraphicsButton:GetFrameLevel() + 1)
        _G.RaidButton.shadow:SetFrameLevel(0)
        _G.RaidButton.border:SetFrameLevel(_G.RaidButton:GetFrameLevel() + 1)
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
        Addon:HandleFrame(frame)
    end
end

function Addon:SkinCharacterFrame()
    Addon:HandleFrame(_G.ReputationDetailFrame)

    -- equipment slots
    for _, slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Addon:HandleItemButton(slot)
        end
    end

    -- resistance icons
    for i = 1, 5 do
        Addon:HandleButton(_G["MagicResFrame" .. i])
    end

    -- skin arena teams
    if Addon.isTbc then
        for i = 1, _G.MAX_ARENA_TEAMS do
            Addon:HandleButton(_G["PVPTeam" .. i])
        end
    end

    -- custom layout
    Addon:LayoutCharacterFrame()
end

function Addon:SkinChat()
    Addon:HandleChatPanel(_G.LeftChatPanel)
    Addon:HandleButton(_G.LeftChatToggleButton)
    Addon:HandleChatPanel(_G.RightChatPanel)
    Addon:HandleButton(_G.RightChatToggleButton)
    Addon:HandleFrame(_G.ChatButtonHolder)
    Addon:HandleFrame(_G.CopyChatFrame)

    Addon:SecureHook(nil, "ChatEdit_UpdateHeader", function(editbox)
        Addon:HandleEditBox(editbox)
    end)
end

function Addon:SkinDecorativePanels()
    Addon:HandleDecorativePanel(LO.BottomPanel, "BOTTOM")
    Addon:HandleDecorativePanel(LO.TopPanel, "TOP")
    Addon:HandleDecorativePanel(AFK.AFKMode.bottom, "BOTTOM")

    -- plugins: ElvUI_MerathilisUI
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Addon:HandleDecorativePanel(_G[merathilis[1].Title .. "TopPanel"], "TOP")
        Addon:HandleDecorativePanel(_G[merathilis[1].Title .. "BottomPanel"], "BOTTOM")
    end
end

function Addon:SkinFriendsFrame()
    Addon:HandleFrame(_G.AddFriendFrame)
    Addon:HandleFrame(_G.GuildInfoFrame)
    Addon:HandleFrame(_G.GuildControlPopupFrame)
    Addon:HandleFrame(_G.GuildMemberDetailFrame)
    Addon:HandleFrame(_G.RaidInfoFrame)

    Addon:HandleEditBox(_G.FriendsFrameBroadcastInput)
    Addon:HandleEditBox(_G.GuildInfoTextBackground)
    Addon:HandleEditBox(_G.GuildMemberNoteBackground)
    Addon:HandleEditBox(_G.GuildMemberOfficerNoteBackground)
    Addon:HandleEditBox(_G.GuildMOTDEditButton)

    -- custom layout
    Addon:LayoutGuildMemberDetailFrame()
end

function Addon:SkinHelpFrame()
    Addon:HandleFrame(_G.HelpFrame)
    Addon:HandleFrame(_G.HelpFrameHeader)
end

function Addon:SkinInspectFrame()
    for _, slot in ipairs({_G.InspectPaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Addon:HandleItemButton(slot)
        end
    end

    -- NOTE: ElvUI (mistakenly?) has a double backdrop for inspect talent frame
    if _G.InspectTalentFrame.backdrop then
        _G.InspectTalentFrame.backdrop:Hide()
    end

    Addon:HandleFrame(_G.InspectTalentFrameScrollFrame)
    _G.InspectTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.InspectTalentFrameScrollFrame:Size(301, 332)
    _G.InspectTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)

    for i = 1, 3 do
        local tab = _G["InspectTalentFrameTab" .. i]
        tab:SetHeight(28)
        if i == 1 then
            tab:SetPoint("TOPLEFT", 70, -48)
        end
    end

    for i = 1, _G.MAX_NUM_TALENTS do
        Addon:HandleTalentButton(_G["InspectTalentFrameTalent" .. i])
    end

    for i = 1, _G.MAX_ARENA_TEAMS do
        Addon:HandleFrame(_G["InspectPVPTeam" .. i])
    end
end

function Addon:SkinItemSocketingFrame()
    Addon:HandleInsetFrame(_G.ItemSocketingScrollFrame)
    for i = 1, _G.MAX_NUM_SOCKETS do
        Addon:HandleButton(_G[("ItemSocketingSocket%d"):format(i)])
        -- TODO: icon is overlaying border, fix that
    end
end

function Addon:SkinMacroFrame()
    for i = 1, _G.MAX_ACCOUNT_MACROS do
        Addon:HandleIcon(_G["MacroButton" .. i])
    end

    Addon:HandleIcon(_G.MacroFrameSelectedMacroButton)
end

function Addon:SkinMailFrame()
    -- Mail items
    for i = 1, _G.INBOXITEMS_TO_DISPLAY do
        local mail = _G["MailItem" .. i]
        local button = _G["MailItem" .. i .. "Button"]

        Addon:HandleButton(mail)
        Addon:HandleButton(mail.bg)
        RaiseFrameLevelByTwo(mail.bg)
    end

    -- Send mail
    Addon:HandleInsetFrame(_G.SendMailScrollFrame)
    Addon:SecureHook(nil, "SendMailFrame_Update", function()
        for i = 1, _G.ATTACHMENTS_MAX_SEND do
            Addon:HandleButton(_G["SendMailAttachment" .. i])
        end
    end)

    -- Open mail
    Addon:HandleInsetFrame(_G.OpenMailScrollFrame)
    for i = 1, _G.ATTACHMENTS_MAX_SEND do
        Addon:HandleButton(_G["OpenMailAttachmentButton" .. i])
    end
end

function Addon:SkinMerchantFrame()
    for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
        Addon:HandleButton(_G["MerchantItem" .. i])
        Addon:HandleButton(_G["MerchantItem" .. i .. "ItemButton"])
    end
    Addon:HandleButton(_G.MerchantBuyBackItemItemButton)
end

function Addon:SkinMinimap()
    Addon:CreateShadow(_G.Minimap, _G.MMHolder)
    Addon:CreateBorder(_G.Minimap, Addon.BORDER_CONFIG_KEYS.MINIMAP, _G.MMHolder)
end

function Addon:SkinMirrorTimers()
    for i = 1, 3 do
        Addon:HandleStatusBar(_G["MirrorTimer" .. i .. "StatusBar"])
    end
end

function Addon:SkinPopups()
    for i = 1, 4 do
        Addon:HandleFrame(_G["StaticPopup" .. i])
        Addon:HandleFrame(_G["ElvUI_StaticPopup" .. i])

        for j = 1, 3 do
            Addon:HandleButton(_G["ElvUI_StaticPopup" .. i .. "Button" .. j])
        end
    end
end

function Addon:SkinQuestLog()
    local questLogItems = {["QuestLogItem"] = _G.MAX_NUM_ITEMS, ["QuestProgressItem"] = _G.MAX_REQUIRED_ITEMS}
    for frame, count in pairs(questLogItems) do
        for i = 1, count do
            Addon:HandleLargeItemButton(_G[frame .. i])
        end
    end

    Addon:LayoutQuestLogFrame()
end

function Addon:SkinRaidUtilityFrame()
    Addon:HandleFrame(_G.RaidUtilityPanel)

    local buttons = {
        "DisbandRaidButton",
        "ReadyCheckButton",
        "MainTankButton",
        "MainAssistButton",
        "RaidControlButton",
        "RaidUtility_ShowButton",
        "RaidUtility_CloseButton"
    }

    for _, button in pairs(buttons) do
        Addon:HandleRaidUtilityButton(_G[button])
    end
end

function Addon:SkinSpellbook()
    for i = 1, _G.MAX_SKILLLINE_TABS do
        Addon:HandleTab(_G["SpellBookSkillLineTab" .. i], false, "RIGHT")
    end
    for i = 1, _G.SPELLS_PER_PAGE do
        local button = _G["SpellButton" .. i]
        Addon:HandleItemButton(button)
        Addon:HandleButton(button.bg)
    end
end

function Addon:SkinTalentFrame()
    Addon:HandleFrame(_G.PlayerTalentFrameScrollFrame)
    _G.PlayerTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.PlayerTalentFrameScrollFrame:Size(301, 332)
    _G.PlayerTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)

    for i = 1, _G.MAX_NUM_TALENTS do
        Addon:HandleTalentButton(_G["PlayerTalentFrameTalent" .. i])
    end
end

function Addon:SkinTradeFrame()
    for _, inset in pairs({
        _G.TradePlayerItemsInset,
        _G.TradeRecipientItemsInset,
        _G.TradePlayerEnchantInset,
        _G.TradeRecipientEnchantInset,
        _G.TradeRecipientMoneyInset
    }) do
        Addon:HandleInsetFrame(inset)
    end

    Addon:SecureHook("TradeFrame_UpdatePlayerItem", function(id)
        Addon:HandleItemButton(_G["TradePlayerItem" .. id .. "ItemButton"])
    end)

    Addon:SecureHook("TradeFrame_UpdateTargetItem", function(id)
        Addon:HandleItemButton(_G["TradeRecipientItem" .. id .. "ItemButton"])
    end)
end

function Addon:SkinTradeSkillFrame()
    Addon:HandleIcon(_G.TradeSkillSkillIcon)
    Addon:HandleStatusBar(_G.TradeSkillRankFrame)

    Addon:LayoutTradeSkillFrame()
end

function Addon:SkinTrainerFrame()
    Addon:HandleButton(_G.ClassTrainerSkillIcon)
    Addon:SecureHook("ClassTrainer_SetSelection", function()
        Addon:HandleButton(_G.ClassTrainerSkillIcon)
    end)

    Addon:LayoutClassTrainerFrame()
end

function Addon:SkinUnitFrames()
    Addon:HandleUnitFrame(UF["player"])
    Addon:HandleUnitFrame(UF["pet"])
    Addon:HandleUnitFrame(UF["pettarget"])
    Addon:HandleUnitFrame(UF["target"])
    Addon:HandleUnitFrame(UF["targettarget"])
    Addon:HandleUnitFrame(UF["targettargettarget"])
    Addon:HandleUnitFrame(UF["focus"])
    Addon:HandleUnitFrame(UF["arena1"])
    Addon:HandleUnitFrame(UF["arena2"])
    Addon:HandleUnitFrame(UF["arena3"])
    Addon:HandleUnitFrame(UF["arena4"])
    Addon:HandleUnitFrame(UF["arena5"])

    Addon:HandleUnitFrameGroup(UF["assist"])
    Addon:HandleUnitFrameGroup(UF["boss"])
    Addon:HandleUnitFrameGroup(UF["party"])
    Addon:HandleUnitFrameGroup(UF["raid"])
    Addon:HandleUnitFrameGroup(UF["raid40"])
    Addon:HandleUnitFrameGroup(UF["raidpet"])
    Addon:HandleUnitFrameGroup(UF["tank"])
end

function Addon:SkinWorldMap()
    _G.WorldMapFrame:CreateBackdrop("Transparent")
    Addon:HandleFrame(_G.WorldMapFrame)
    _G.WorldMapFrame.BorderFrame.backdrop:Hide()
    _G.WorldMapFrame.ScrollContainer:CreateBackdrop("Transparent")
    Addon:HandleFrame(_G.WorldMapFrame.ScrollContainer)
end

function Addon:SkinElvUIInstallerFrames()
    Addon:HandleFrame(_G.PluginInstallFrame)
    Addon:HandleFrame(_G.PluginInstallFrame.pending)
    Addon:HandleFrame(_G.PluginInstallFrame.side)
    Addon:HandleStatusBar(_G.PluginInstallFrame.Status)
end
