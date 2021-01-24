local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Artwork = Artwork
local AS = unpack(AddOnSkins)
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")
local UF = E:GetModule("UnitFrames")

-- Init/Update
function Artwork:Initialize()
    Artwork:RegisterEvent("ADDON_LOADED", Artwork.ADDON_LOADED)

    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    Artwork:SkinFrame(_G.GameMenuFrame)
    Artwork:SkinFrame(_G.InterfaceOptionsFrame)
    Artwork:SkinFrame(_G.VideoOptionsFrame)
    Artwork:SkinFrame(_G.ScriptErrorsFrame)
    Artwork:SkinFrame(_G.StackSplitFrame, true)
    Artwork:SkinFrame(_G.LootFrame, true)
    Artwork:SkinFrame(_G.LootHistoryFrame, true)
    Artwork:SkinFrame(_G.MasterLooterFrame, true)
    Artwork:SkinFrame(_G.ReadyCheckFrame, true)
    Artwork:SkinFrame(_G.WorldMapFrame)
    Artwork:SkinFrame(_G.ColorPickerFrame, true)
    Artwork:SkinFrame(_G.CopyChatFrame, true)
    Artwork:SkinFrame(_G.GuildMemberDetailFrame, true)

    -- skin chat panels
    Artwork:SkinChatPanel(_G.LeftChatPanel, true)
    Artwork:SkinButton(_G.LeftChatToggleButton)
    Artwork:SkinChatPanel(_G.RightChatPanel, true)
    Artwork:SkinButton(_G.RightChatToggleButton)

    -- skin popups
    for i = 1, 4 do
        Artwork:SkinFrame(_G["StaticPopup" .. i], true)
    end
    for i = 1, 4 do
        Artwork:SkinFrame(_G["ElvUI_StaticPopup" .. i], true)
    end

    -- skin any tab that isn't handled by overriding Skins.HandleTab
    for i = 1, _G.MAX_SKILLLINE_TABS do
        local tab = _G["SpellBookSkillLineTab" .. i]
        Artwork:SkinTab(tab, "RIGHT")
    end

    -- skins bags
    Artwork:SkinFrame(B.BagFrame)
    Artwork:SkinFrame(B.BankFrame)
    Artwork:SkinFrame(B.SellFrame, true)

    -- skin character equipment slot items
    for _, slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
        if slot:IsObjectType("Button") then
            Artwork:SkinItemButton(slot, true)
        end
    end

    -- skin quest log items
    local questLogItems = {["QuestLogItem"] = _G.MAX_NUM_ITEMS, ["QuestProgressItem"] = _G.MAX_REQUIRED_ITEMS}
    for frame, count in pairs(questLogItems) do
        for i = 1, count do
            Artwork:SkinItemButton(_G[frame .. i], true)
        end
    end

    -- vehicle leave button
    Artwork:SkinActionButton(_G.MainMenuBarVehicleLeaveButton, "OVERLAY")

    -- minimap
    Artwork:SkinMinimap()

    -- skin unit frames
    Artwork:SkinUnitFrame("player")
    Artwork:SkinUnitFrame("pet")
    Artwork:SkinUnitFrame("pettarget")
    Artwork:SkinUnitFrame("target")
    Artwork:SkinUnitFrame("targettarget")
    Artwork:SkinUnitFrame("targettargettarget")
    Artwork:SkinUnitFrame("focus")
    Artwork:SkinUnitFrame("focustarget")

    -- skin group frames
    Artwork:SkinUnitFrameGroup("arena")
    Artwork:SkinUnitFrameGroup("assist")
    Artwork:SkinUnitFrameGroup("boss")
    Artwork:SkinUnitFrameGroup("party")
    Artwork:SkinUnitFrameGroup("raid")
    Artwork:SkinUnitFrameGroup("raid40")
    Artwork:SkinUnitFrameGroup("raidpet")
    Artwork:SkinUnitFrameGroup("tank")

    Artwork:ApplyCustomLayout()
end

function Artwork:UpdateArtwork()
    for frame, _ in pairs(Artwork.registry.frames) do
        Artwork:UpdateFrame(frame)
    end

    for frame, _ in pairs(Artwork.registry.nestedFrames) do
        Artwork:UpdateNestedFrame(frame)
    end

    for tab, _ in pairs(Artwork.registry.tabs) do
        Artwork:UpdateTab(tab)
    end

    for button, _ in pairs(Artwork.registry.buttons) do
        Artwork:UpdateButton(button)
    end

    for button, _ in pairs(Artwork.registry.actionButtons) do
        Artwork:UpdateActionButton(button)
    end

    for button, _ in pairs(Artwork.registry.bagButtons) do
        Artwork:UpdateBagButton(button)
    end

    for button, _ in pairs(Artwork.registry.itemButtons) do
        Artwork:UpdateItemButton(button)
    end

    for button, _ in pairs(Artwork.registry.craftItemButtons) do
        Artwork:UpdateCraftItemButton(button)
    end

    for aura, _ in pairs(Artwork.registry.auras) do
        Artwork:UpdateAura(aura)
    end

    for tempEnchant, _ in pairs(Artwork.registry.tempEnchants) do
        Artwork:UpdateTempEnchant(tempEnchant)
    end

    for unitFrame, _ in pairs(Artwork.registry.unitFrames) do
        Artwork:UpdateUnitFrame(unitFrame)
    end

    for panel, _ in pairs(Artwork.registry.chatPanels) do
        Artwork:UpdateChatPanel(panel)
    end

    for bar, _ in pairs(Artwork.registry.dataBars) do
        Artwork:UpdateDataBar(bar)
    end

    for panel, _ in pairs(Artwork.registry.dataPanels) do
        Artwork:UpdateDataPanel(panel)
    end

    for nameplate, _ in pairs(Artwork.registry.namePlates) do
        Artwork:UpdateNamePlate(nameplate)
    end

    Artwork:UpdateMinimap()
end

-- Custom layouts
function Artwork:ApplyCustomLayout()
    -- add titles to frames that don't have them
    B.BagFrame.Title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.Title:FontTemplate()
    B.BagFrame.Title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.Title:SetText(INVENTORY_TOOLTIP)

    B.BankFrame.Title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.Title:FontTemplate()
    B.BankFrame.Title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.Title:SetText(BANK)

    -- add icons to guild member details frames    
    _G.GuildMemberDetailFrame.icon = _G.GuildMemberDetailFrame:CreateTexture("$parentIcon", "ARTWORK")
    _G.GuildMemberDetailFrame.icon:SetPoint("TOPLEFT", _G.GuildMemberDetailName, "TOPLEFT", -30, 0)
    _G.GuildMemberDetailFrame.icon:SetSize(25, 25)
    _G.GuildMemberDetailFrame.icon:SetTexture([[Interface\WorldStateFrame\Icons-Classes]])
    Addon:OffsetFrame(_G.GuildMemberDetailName, 30, 0)
    Addon:OffsetFrame(_G.GuildMemberDetailZoneLabel, -30, 0)
    
    Artwork:SecureHook("GuildStatus_Update", function()
        local selection = GetGuildRosterSelection()
        if selection then
            local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(selection)
            local classFileName = E:UnlocalizedClassName(class)
            local classTextColor = _G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[classFileName] or _G.RAID_CLASS_COLORS[classFileName]
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

-- Blizzard Addons
function Artwork:ADDON_LOADED(addonName)
    if addonName == "Blizzard_AuctionUI" then
        Artwork:ScheduleTimer("LoadAuctionFrame", 0.01)
    elseif addonName == "Blizzard_BindingUI" then
        Artwork:ScheduleTimer("LoadBindingsFrame", 0.01)
    elseif addonName == "Blizzard_Communities" then
        Artwork:ScheduleTimer("LoadCommunitiesFrame", 0.01)
    elseif addonName == "Blizzard_CraftUI" then
        Artwork:ScheduleTimer("SkinCraftFrame", 0.01)
    elseif addonName == "Blizzard_GMChatUI" then
        Artwork:ScheduleTimer("LoadGMChatFrame", 0.01)
    elseif addonName == "Blizzard_InspectUI" then
        Artwork:ScheduleTimer("LoadInspectFrame", 0.01)
    elseif addonName == "Blizzard_MacroUI" then
        Artwork:ScheduleTimer("LoadMacroFrame", 0.01)
    elseif addonName == "Blizzard_RaidUI" then
        Artwork:ScheduleTimer("LoadRaidFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Artwork:ScheduleTimer("LoadTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Artwork:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Artwork:ScheduleTimer("LoadTrainerFrame", 0.01)
    end
end

function Artwork:LoadAuctionFrame()
end

function Artwork:LoadBindingsFrame()
end

function Artwork:LoadCommunitiesFrame()
end

function Artwork:LoadCraftFrame()
    if _G.CraftFrame then
        for i = 1, _G.MAX_CRAFT_REAGENTS do
            local button = _G["CraftReagent" .. i]
            Artwork:SkinCraftItemButton(button)
        end
    else
        Artwork:ScheduleTimer("LoadCraftFrame", 0.01)
    end
end

function Artwork:LoadGMChatFrame()
end

function Artwork:LoadInspectFrame()
end

function Artwork:LoadMacroFrame()
end

function Artwork:LoadRaidFrame()
end

function Artwork:LoadTalentFrame()
end

function Artwork:LoadTradeSkillFrame()
    if _G.TradeSkillFrame then
        for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
            local button = _G["TradeSkillReagent" .. i]
            Artwork:SkinCraftItemButton(button)
        end
        Artwork:SkinCraftItemButton(_G.TradeSkillSkillIcon)
    else
        Artwork:ScheduleTimer("LoadTradeSkillFrame", 0.01)
    end
end

function Artwork:LoadTrainerFrame()
end
