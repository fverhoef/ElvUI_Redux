local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

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

    local isBackdropHidden = panel.template == "NoBackdrop"
    local shadow = Skins:CreateShadow(panel)
    shadow.isHidden = isBackdropHidden
    shadow:Update()
    local border = Skins:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.DATA_PANEL)
    border.isHidden = isBackdropHidden
    border:Update()
end
