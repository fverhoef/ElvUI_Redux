local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

Addon:SecureHook(DT, "UpdatePanelInfo", function(self, panelName, panel, ...)
    if not panel then
        panel = DT.RegisteredPanels[panelName]
    end
    Addon:HandleDataPanel(panel)
end)

function Addon:HandleDataPanel(panel)
    if not panel or panel == _G.MinimapPanel then
        return
    end

    local isBackdropHidden = panel.template == "NoBackdrop"
    local shadow = Addon:CreateShadow(panel)
    shadow.isHidden = isBackdropHidden
    shadow:Update()
    local border = Addon:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.DATA_PANEL)
    border.isHidden = isBackdropHidden
    border:Update()
end
