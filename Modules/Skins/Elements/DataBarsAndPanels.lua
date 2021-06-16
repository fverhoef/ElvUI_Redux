local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")

Skins:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Skins:HandleDataBar(_G[name], _G[name .. "Holder"])
end)

Skins:SecureHook(DB, "UpdateAll", function(self)
    for _, bar in pairs(DB.StatusBars) do
        Skins:HandleDataBar(bar, _G[bar:GetName() .. "Holder"])
    end
end)

function Skins:HandleDataBar(bar, holder)
    if not bar then
        return
    end

    Skins:CreateShadow(holder)
    local border = Skins:CreateBorder(holder, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(holder))    

    if border and border:IsShown() then
        local borderColor = {border:GetBorderColor()}
        border:HideOriginalBackdrop(true)
        border:SetBorderColor(unpack(borderColor))

        border:SetFrameLevel(bar:GetFrameLevel() + 1)
    end
end

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
    local border = Skins:CreateBorder(panel, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(panel))

    if border and border:IsShown() then
        local borderColor = {border:GetBorderColor()}
        border:HideOriginalBackdrop(true)
        border:SetBorderColor(unpack(borderColor))
    end
end
