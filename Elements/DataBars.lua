local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local DB = E:GetModule("DataBars")

Addon:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Addon:HandleDataBar(_G[name], _G[name .. "Holder"])
end)

Addon:SecureHook(DB, "UpdateAll", function(self)
    for _, bar in pairs(DB.StatusBars) do
        Addon:HandleDataBar(bar, _G[bar:GetName() .. "Holder"])
    end
end)

function Addon:HandleDataBar(bar, holder)
    if not bar then
        return
    end

    Addon:CreateShadow(holder)
    local border = Addon:CreateBorder(holder, Addon.BORDER_CONFIG_KEYS.DATA_BAR)
    border.frameLevel = bar:GetFrameLevel() + 1
    border:Update()
end
