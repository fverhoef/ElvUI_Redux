local addonName, addonTable = ...
local Addon = addonTable[1]
local Layout = Addon:NewModule(addonName .. "Layout", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Layout = Layout
local E, L, V, P, G = unpack(ElvUI)

function Layout:Initialize()
    Layout:LayoutCharacterFrame()
    Layout:LayoutGuildMemberDetailFrame()
    Layout:LayoutQuestLogFrame()

    if E.db[addonName].layout.minimapButtonFrame.enabled then
        Layout:CreateMinimapButtonFrame()
    end

    Layout:HookTooltips()

    Layout:RegisterEvent("ADDON_LOADED", Layout.ADDON_LOADED)
end

function Layout:Update()
    if E.db[addonName].layout.minimapButtonFrame.enabled then
        Layout:CreateMinimapButtonFrame()
    end
end

function Layout:ADDON_LOADED(addonName)
    if addonName == "Blizzard_TradeSkillUI" then
        Layout:ScheduleTimer("LayoutTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Layout:ScheduleTimer("LayoutClassTrainerFrame", 0.01)
    end
end