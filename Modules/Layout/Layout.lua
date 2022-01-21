local addonName, addonTable = ...
local Addon = addonTable[1]
local Layout = Addon:NewModule(addonName .. "Layout", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Layout = Layout
local E, L, V, P, G = unpack(ElvUI)

function Layout:Initialize()
    if E.db[addonName].layout.minimapButtonFrame.enabled then
        Layout:CreateMinimapButtonFrame()
    end

    Layout:HookTooltips()

    if Addon.Layout.TBC then
        Addon.Layout.TBC:Initialize()
    end
end

function Layout:Update()
    if E.db[addonName].layout.minimapButtonFrame.enabled then
        Layout:CreateMinimapButtonFrame()
    end
end