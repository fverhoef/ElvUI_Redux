local addonName, addonTable = ...
local Addon = addonTable[1]

if not Addon.isTbc then
    return
end

local Styling = Addon:NewModule(addonName .. "Styling.TBC", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Styling.TBC = Styling
local E, L, V, P, G = unpack(ElvUI)

function Styling:Initialize()
    Styling:SkinWorldMap()
    Styling:RegisterEvent("ADDON_LOADED", Styling.ADDON_LOADED)
end

function Styling:ADDON_LOADED(addonName)
    if addonName == "Blizzard_InspectUI" then
        Styling:ScheduleTimer("SkinInspectFrame", 0.01)
    elseif addonName == "Blizzard_TalentUI" then
        Styling:ScheduleTimer("SkinTalentFrame", 0.01)
    end
end

function Styling:SkinInspectFrame()
    -- NOTE: ElvUI (mistakenly?) has a double backdrop for inspect talent frame
    if _G.InspectTalentFrame.backdrop then
        _G.InspectTalentFrame.backdrop:Hide()
    end

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
end

function Styling:SkinTalentFrame()
    _G.PlayerTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.PlayerTalentFrameScrollFrame:Size(301, 332)
    _G.PlayerTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)
end

function Styling:SkinWorldMap()
    _G.WorldMapFrame:CreateBackdrop("Transparent")
    Addon.Styling:HandleFrame(_G.WorldMapFrame)
    _G.WorldMapFrame.BorderFrame.backdrop:Hide()
    _G.WorldMapFrame.ScrollContainer:CreateBackdrop("Transparent")
    Addon.Styling:HandleFrame(_G.WorldMapFrame.ScrollContainer)
end