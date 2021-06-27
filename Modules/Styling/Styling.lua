local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon:NewModule(addonName .. "Styling", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Styling = Styling
local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")
local AFK = E:GetModule("AFK")
local B = E:GetModule("Bags")
local LO = E:GetModule("Layout")
local S = E:GetModule("Skins")
local UF = E:GetModule("UnitFrames")

function Styling:Initialize()
    Styling:SkinActionBars()
    Styling:SkinArenaRegistrarFrame()
    Styling:SkinBags()
    Styling:SkinBlizzardOptions()
    Styling:SkinCharacterFrame()
    Styling:SkinChat()
    Styling:SkinDecorativePanels()
    Styling:SkinFriendsFrame()
    Styling:SkinHelpFrame()
    Styling:SkinMailFrame()
    Styling:SkinMerchantFrame()
    Styling:SkinMinimap()
    Styling:SkinMirrorTimers()
    Styling:SkinPopups()
    Styling:SkinQuestLog()
    Styling:SkinRaidUtilityFrame()
    Styling:SkinSpellbook()
    Styling:SkinTradeFrame()
    Styling:SkinUnitFrames()
    Styling:SkinWorldMap()

    Styling:SkinElvUIInstallerFrames()

    Styling:HandleFrame(_G.GameMenuFrame)
    Styling:HandleFrame(_G.ScriptErrorsFrame)
    Styling:HandleFrame(_G.StackSplitFrame)
    Styling:HandleFrame(_G.StackSplitFrame.bg1)
    Styling:HandleFrame(_G.ReadyCheckFrame)
    Styling:HandleFrame(_G.ElvLootFrame)
    Styling:HandleFrame(_G.LootFrame)
    Styling:HandleFrame(_G.LootHistoryFrame)
    Styling:HandleFrame(_G.MasterLooterFrame)
    Styling:HandleFrame(_G.ColorPickerFrame)
    Styling:HandleFrame(_G.ItemSocketingFrame)
    Styling:HandleFrame(_G.StopwatchFrame)
    Styling:HandleFrame(_G.ArenaFrame)
    Styling:HandleFrame(_G.BattlefieldFrame)

    if _G.Minimap.ButtonFrame then
        Addon:CreateShadow(_G.Minimap.ButtonFrame.Container)
        Addon:CreateBorder(_G.Minimap.ButtonFrame.Container, Addon.BORDER_CONFIG_KEYS.MINIMAP)
    end

    Styling:RegisterEvent("ADDON_LOADED", Styling.ADDON_LOADED)
end

function Styling:Update()
    if UnitAffectingCombat("player") then
        Styling:ScheduleTimer("Update", 1)
        return
    end

    local config = E.db[addonName].styling

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

function Styling:GetBorderColor(frame)
    local color
    local parent = frame.backdrop or frame
    if parent.GetBackdropBorderColor then
        color = {parent:GetBackdropBorderColor()}
    end

    return color or E.media.bordercolor
end

function Styling:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Styling:ScheduleTimer("SkinAuctionFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Styling:ScheduleTimer("SkinInspectFrame", 0.01)
    elseif addonName == "Blizzard_ItemSocketingUI" then
        Styling:ScheduleTimer("SkinItemSocketingFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Styling:ScheduleTimer("SkinMacroFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Styling:ScheduleTimer("SkinTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Styling:ScheduleTimer("SkinTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Styling:ScheduleTimer("SkinTrainerFrame", 0.01)
    end
end

function Styling:SkinActionBars()
    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            Styling:HandleActionBar(bar)

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                local button = bar.buttons[j]
                Styling:HandleActionButton(button)
            end
        end
    end

    Styling:HandleFrame(_G.ElvUI_MicroBar)

    -- vehicle Leave
    Styling:HandleActionButton(_G.MainMenuBarVehicleLeaveButton)

    -- plugins: ElvUI_ClassicClassBars
    local ccb = _G["ElvUI_ClassicClassBars"]
    if ccb then
        if ccb.MageBar then
            Styling:HandleActionBar(ccb.MageBar)

            for i, button in ipairs(ccb.MageBar.buttons) do
                Styling:HandleActionButton(button.CurrentAction or button)
            end
        end

        if ccb.ShamanBar then
            Styling:HandleActionBar(ccb.ShamanBar)

            for i, button in ipairs(ccb.ShamanBar.buttons) do
                Styling:HandleActionButton(button.CurrentAction or button)
            end
        end
    end
end

function Styling:SkinArenaRegistrarFrame()
    Styling:HandleFrame(_G.ArenaRegistrarFrame)
    Styling:HandleFrame(_G.PVPBannerFrame)
end

function Styling:SkinAuctionFrame()
    Styling:HandleItemButton(_G.AuctionsItemButton)

    for _, frame in pairs({_G.AuctionFrameBrowse, _G.AuctionFrameAuctions}) do
        Styling:HandleInsetFrame(frame.LeftBackground)
        Styling:HandleInsetFrame(frame.RightBackground)
    end

    for frame, numButtons in pairs({
        ["Browse"] = _G.NUM_BROWSE_TO_DISPLAY,
        ["Auctions"] = _G.NUM_AUCTIONS_TO_DISPLAY,
        ["Bid"] = _G.NUM_BIDS_TO_DISPLAY
    }) do
        for i = 1, numButtons do
            Styling:HandleItemButton(_G[frame .. "Button" .. i .. "Item"])
        end
    end
end

function Styling:SkinBags()
    B.BagFrame.title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.title:FontTemplate()
    B.BagFrame.title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.title:SetText(_G.INVENTORY_TOOLTIP)

    Styling:HandleFrame(B.BagFrame)
    Styling:HandleFrame(B.BagFrame.editBox)
    Styling:HandleButton(B.BagFrame.bagsButton)
    Styling:HandleButton(B.BagFrame.sortButton)
    Styling:HandleButton(B.BagFrame.vendorGraysButton)
    Styling:HandleButton(B.BagFrame.keyRingButton)
    Styling:HandleFrame(B.BagFrame.ContainerHolder)
    for i, bagID in next, B.BagFrame.BagIDs do
        Styling:HandleItemButton(B.BagFrame.ContainerHolder[i])
    end

    B.BankFrame.title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.title:FontTemplate()
    B.BankFrame.title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.title:SetText(_G.BANK)

    Styling:HandleFrame(B.BankFrame)
    Styling:HandleFrame(B.BankFrame.editBox)
    Styling:HandleButton(B.BankFrame.bagsButton)
    Styling:HandleButton(B.BankFrame.sortButton)
    Styling:HandleButton(B.BankFrame.purchaseBagButton)
    Styling:HandleFrame(B.BankFrame.ContainerHolder)
    for i, bagID in next, B.BankFrame.BagIDs do
        Styling:HandleItemButton(B.BankFrame.ContainerHolder[i])
    end

    Styling:HandleFrame(B.SellFrame)
end

function Styling:SkinBlizzardOptions()
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
        Styling:HandleFrame(frame)
    end

    for _, frame in pairs(backdrops) do
        Styling:HandleFrame(frame)
    end

    _G.InterfaceOptionsFrameTab1:CreateBackdrop()
    Styling:HandleTab(_G.InterfaceOptionsFrameTab1, nil, "UP")
    _G.InterfaceOptionsFrameTab2:CreateBackdrop()
    Styling:HandleTab(_G.InterfaceOptionsFrameTab2, nil, "UP")

    Styling:SecureHook(nil, "AudioOptionsVoicePanel_InitializeCommunicationModeUI", function(self)
        Styling:HandleButton(self.PushToTalkKeybindButton)
    end)

    Styling:SecureHook(nil, "GraphicsOptions_SelectBase", function(self)
        _G.GraphicsButton.shadow:SetFrameLevel(0)
        _G.GraphicsButton.border:SetFrameLevel(_G.GraphicsButton:GetFrameLevel() + 1)
        _G.RaidButton.shadow:SetFrameLevel(0)
        _G.RaidButton.border:SetFrameLevel(_G.RaidButton:GetFrameLevel() + 1)
    end)

    Styling:SecureHook(nil, "GraphicsOptions_SelectRaid", function(self)
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
        Styling:HandleFrame(frame)
    end
end

function Styling:SkinCharacterFrame()
    Styling:HandleFrame(_G.ReputationDetailFrame)

    -- equipment slots
    for _, slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Styling:HandleItemButton(slot)
        end
    end

    -- resistance icons
    for i = 1, 5 do
        Styling:HandleButton(_G["MagicResFrame" .. i])
    end

    -- skin arena teams
    if Addon.isTbc then
        for i = 1, _G.MAX_ARENA_TEAMS do
            Styling:HandleButton(_G["PVPTeam" .. i])
        end
    end
end

function Styling:SkinChat()
    Styling:HandleChatPanel(_G.LeftChatPanel)
    Styling:HandleButton(_G.LeftChatToggleButton)
    Styling:HandleChatPanel(_G.RightChatPanel)
    Styling:HandleButton(_G.RightChatToggleButton)
    Styling:HandleFrame(_G.ChatButtonHolder)
    Styling:HandleFrame(_G.CopyChatFrame)

    Styling:SecureHook(nil, "ChatEdit_UpdateHeader", function(editbox)
        Styling:HandleEditBox(editbox)
    end)
end

function Styling:SkinDecorativePanels()
    Styling:HandleDecorativePanel(LO.BottomPanel, "BOTTOM")
    Styling:HandleDecorativePanel(LO.TopPanel, "TOP")
    Styling:HandleDecorativePanel(AFK.AFKMode.bottom, "BOTTOM")

    -- plugins: ElvUI_MerathilisUI
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Styling:HandleDecorativePanel(_G[merathilis[1].Title .. "TopPanel"], "TOP")
        Styling:HandleDecorativePanel(_G[merathilis[1].Title .. "BottomPanel"], "BOTTOM")
    end
end

function Styling:SkinFriendsFrame()
    Styling:HandleFrame(_G.AddFriendFrame)
    Styling:HandleFrame(_G.GuildInfoFrame)
    Styling:HandleFrame(_G.GuildControlPopupFrame)
    Styling:HandleFrame(_G.GuildMemberDetailFrame)
    Styling:HandleFrame(_G.RaidInfoFrame)

    Styling:HandleEditBox(_G.FriendsFrameBroadcastInput)
    Styling:HandleEditBox(_G.GuildInfoTextBackground)
    Styling:HandleEditBox(_G.GuildMemberNoteBackground)
    Styling:HandleEditBox(_G.GuildMemberOfficerNoteBackground)
    Styling:HandleEditBox(_G.GuildMOTDEditButton)
end

function Styling:SkinHelpFrame()
    Styling:HandleFrame(_G.HelpFrame)
    Styling:HandleFrame(_G.HelpFrameHeader)
end

function Styling:SkinInspectFrame()
    for _, slot in ipairs({_G.InspectPaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Styling:HandleItemButton(slot)
        end
    end

    -- NOTE: ElvUI (mistakenly?) has a double backdrop for inspect talent frame
    if _G.InspectTalentFrame.backdrop then
        _G.InspectTalentFrame.backdrop:Hide()
    end

    Styling:HandleFrame(_G.InspectTalentFrameScrollFrame)
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
        Styling:HandleTalentButton(_G["InspectTalentFrameTalent" .. i])
    end

    for i = 1, _G.MAX_ARENA_TEAMS do
        Styling:HandleFrame(_G["InspectPVPTeam" .. i])
    end
end

function Styling:SkinItemSocketingFrame()
    Styling:HandleInsetFrame(_G.ItemSocketingScrollFrame)
    for i = 1, _G.MAX_NUM_SOCKETS do
        Styling:HandleButton(_G[("ItemSocketingSocket%d"):format(i)])
        -- TODO: icon is overlaying border, fix that
    end
end

function Styling:SkinMacroFrame()
    for i = 1, _G.MAX_ACCOUNT_MACROS do
        Styling:HandleIcon(_G["MacroButton" .. i])
    end

    Styling:HandleIcon(_G.MacroFrameSelectedMacroButton)
end

function Styling:SkinMailFrame()
    -- Mail items
    for i = 1, _G.INBOXITEMS_TO_DISPLAY do
        local mail = _G["MailItem" .. i]
        local button = _G["MailItem" .. i .. "Button"]

        Styling:HandleButton(mail)
        Styling:HandleButton(mail.bg)
        RaiseFrameLevelByTwo(mail.bg)
    end

    -- Send mail
    Styling:HandleInsetFrame(_G.SendMailScrollFrame)
    Styling:SecureHook(nil, "SendMailFrame_Update", function()
        for i = 1, _G.ATTACHMENTS_MAX_SEND do
            Styling:HandleButton(_G["SendMailAttachment" .. i])
        end
    end)

    -- Open mail
    Styling:HandleInsetFrame(_G.OpenMailScrollFrame)
    for i = 1, _G.ATTACHMENTS_MAX_SEND do
        Styling:HandleButton(_G["OpenMailAttachmentButton" .. i])
    end
end

function Styling:SkinMerchantFrame()
    for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
        Styling:HandleButton(_G["MerchantItem" .. i])
        Styling:HandleButton(_G["MerchantItem" .. i .. "ItemButton"])
    end
    Styling:HandleButton(_G.MerchantBuyBackItemItemButton)
end

function Styling:SkinMinimap()
    Addon:CreateShadow(_G.Minimap, _G.MMHolder)
    Addon:CreateBorder(_G.Minimap, Addon.BORDER_CONFIG_KEYS.MINIMAP, _G.MMHolder)
end

function Styling:SkinMirrorTimers()
    for i = 1, 3 do
        Styling:HandleStatusBar(_G["MirrorTimer" .. i .. "StatusBar"])
    end
end

function Styling:SkinPopups()
    for i = 1, 4 do
        Styling:HandleFrame(_G["StaticPopup" .. i])
        Styling:HandleFrame(_G["ElvUI_StaticPopup" .. i])

        for j = 1, 3 do
            Styling:HandleButton(_G["ElvUI_StaticPopup" .. i .. "Button" .. j])
        end
    end
end

function Styling:SkinQuestLog()
    local questLogItems = {["QuestLogItem"] = _G.MAX_NUM_ITEMS, ["QuestProgressItem"] = _G.MAX_REQUIRED_ITEMS}
    for frame, count in pairs(questLogItems) do
        for i = 1, count do
            Styling:HandleLargeItemButton(_G[frame .. i])
        end
    end
end

function Styling:SkinRaidUtilityFrame()
    Styling:HandleFrame(_G.RaidUtilityPanel)

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
        Styling:HandleRaidUtilityButton(_G[button])
    end
end

function Styling:SkinSpellbook()
    for i = 1, _G.MAX_SKILLLINE_TABS do
        Styling:HandleTab(_G["SpellBookSkillLineTab" .. i], false, "RIGHT")
    end
    for i = 1, _G.SPELLS_PER_PAGE do
        local button = _G["SpellButton" .. i]
        Styling:HandleItemButton(button)
        Styling:HandleButton(button.bg)
    end
end

function Styling:SkinTalentFrame()
    Styling:HandleFrame(_G.PlayerTalentFrameScrollFrame)
    _G.PlayerTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.PlayerTalentFrameScrollFrame:Size(301, 332)
    _G.PlayerTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)

    for i = 1, _G.MAX_NUM_TALENTS do
        Styling:HandleTalentButton(_G["PlayerTalentFrameTalent" .. i])
    end
end

function Styling:SkinTradeFrame()
    for _, inset in pairs({
        _G.TradePlayerItemsInset,
        _G.TradeRecipientItemsInset,
        _G.TradePlayerEnchantInset,
        _G.TradeRecipientEnchantInset,
        _G.TradeRecipientMoneyInset
    }) do
        Styling:HandleInsetFrame(inset)
    end

    Styling:SecureHook("TradeFrame_UpdatePlayerItem", function(id)
        Styling:HandleItemButton(_G["TradePlayerItem" .. id .. "ItemButton"])
    end)

    Styling:SecureHook("TradeFrame_UpdateTargetItem", function(id)
        Styling:HandleItemButton(_G["TradeRecipientItem" .. id .. "ItemButton"])
    end)
end

function Styling:SkinTradeSkillFrame()
    Styling:HandleIcon(_G.TradeSkillSkillIcon)
    Styling:HandleStatusBar(_G.TradeSkillRankFrame)
end

function Styling:SkinTrainerFrame()
    Styling:HandleButton(_G.ClassTrainerSkillIcon)
    Styling:SecureHook("ClassTrainer_SetSelection", function()
        Styling:HandleButton(_G.ClassTrainerSkillIcon)
    end)
end

function Styling:SkinUnitFrames()
    Styling:HandleUnitFrame(UF["player"])
    Styling:HandleUnitFrame(UF["pet"])
    Styling:HandleUnitFrame(UF["pettarget"])
    Styling:HandleUnitFrame(UF["target"])
    Styling:HandleUnitFrame(UF["targettarget"])
    Styling:HandleUnitFrame(UF["targettargettarget"])
    Styling:HandleUnitFrame(UF["focus"])
    Styling:HandleUnitFrame(UF["arena1"])
    Styling:HandleUnitFrame(UF["arena2"])
    Styling:HandleUnitFrame(UF["arena3"])
    Styling:HandleUnitFrame(UF["arena4"])
    Styling:HandleUnitFrame(UF["arena5"])

    Styling:HandleUnitFrameGroup(UF["assist"])
    Styling:HandleUnitFrameGroup(UF["boss"])
    Styling:HandleUnitFrameGroup(UF["party"])
    Styling:HandleUnitFrameGroup(UF["raid"])
    Styling:HandleUnitFrameGroup(UF["raid40"])
    Styling:HandleUnitFrameGroup(UF["raidpet"])
    Styling:HandleUnitFrameGroup(UF["tank"])
end

function Styling:SkinWorldMap()
    _G.WorldMapFrame:CreateBackdrop("Transparent")
    Styling:HandleFrame(_G.WorldMapFrame)
    _G.WorldMapFrame.BorderFrame.backdrop:Hide()
    _G.WorldMapFrame.ScrollContainer:CreateBackdrop("Transparent")
    Styling:HandleFrame(_G.WorldMapFrame.ScrollContainer)
end

function Styling:SkinElvUIInstallerFrames()
    Styling:HandleFrame(_G.PluginInstallFrame)
    Styling:HandleFrame(_G.PluginInstallFrame.pending)
    Styling:HandleFrame(_G.PluginInstallFrame.side)
    Styling:HandleStatusBar(_G.PluginInstallFrame.Status)
end
