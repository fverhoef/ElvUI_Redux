local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

Skins:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Skins:HandleDataPanel(panel)
end)

Skins:SecureHook(DT, "UpdatePanelInfo", function(self, panelName, panel, ...)
    if not panel then
        panel = DT.RegisteredPanels[panelName]
    end
    Skins:HandleDataPanel(panel)
end)

function Skins:HandleDataPanel(panel)
    if not panel or panel == _G.MinimapPanel then
        return
    end

    Skins:CreateShadow(panel)
    Skins:CreateBorder(panel, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(panel))
end
