local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon:NewModule(addonName .. "Layout.TBC", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Layout.TBC = Layout
local E, L, V, P, G = unpack(ElvUI)

function Layout:Initialize()
    Layout:LayoutCharacterFrame()
    Layout:LayoutGuildMemberDetailFrame()
    Layout:LayoutQuestLogFrame()
    Layout:RegisterEvent("ADDON_LOADED", Layout.ADDON_LOADED)
end

function Layout:ADDON_LOADED(addonName)
    if addonName == "Blizzard_InspectUI" then
        Layout:ScheduleTimer("LayoutInspectFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Layout:ScheduleTimer("LayoutTalentFrame", 0.01)
    elseif addonName == "Blizzard_TradeSkillUI" then
        Layout:ScheduleTimer("LayoutTradeSkillFrame", 0.01)
    elseif addonName == "Blizzard_TrainerUI" then
        Layout:ScheduleTimer("LayoutClassTrainerFrame", 0.01)
    end
end