local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local DB = E:GetModule("DataBars")

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
    local border = Skins:CreateBorder(holder, Addon.BORDER_CONFIG_KEYS.DATA_BAR)
    border.frameLevel = bar:GetFrameLevel() + 1
    border:Update()
end
