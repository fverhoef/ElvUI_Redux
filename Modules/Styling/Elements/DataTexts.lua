local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")

Styling:SecureHook(DT, "UpdatePanelInfo", function(self, panelName, panel, ...)
    if not panel then
        panel = DT.RegisteredPanels[panelName]
    end
    Styling:HandleDataPanel(panel)
end)

function Styling:HandleDataPanel(panel)
    if not panel or panel == _G.MinimapPanel then
        return
    end

    Styling:ApplyStyle(panel, Addon.STYLE_CONFIG_KEYS.DATA_PANEL)

    local isBackdropHidden = panel.template == "NoBackdrop"

    local shadow = panel:GetShadow()
    if shadow then
        shadow.isHidden = isBackdropHidden
        shadow:Update()
    end

    local border = panel:GetBorder()
    if border then
        border.isHidden = isBackdropHidden
        border:Update()
    end
end
