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
end

function Styling:SkinWorldMap()
    _G.WorldMapFrame:CreateBackdrop("Transparent")
    Addon.Styling:HandleFrame(_G.WorldMapFrame)
    _G.WorldMapFrame.BorderFrame.backdrop:Hide()
    _G.WorldMapFrame.ScrollContainer:CreateBackdrop("Transparent")
    Addon.Styling:HandleFrame(_G.WorldMapFrame.ScrollContainer)
end