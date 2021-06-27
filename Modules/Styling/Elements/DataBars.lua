local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local DB = E:GetModule("DataBars")

Styling:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Styling:HandleDataBar(_G[name], _G[name .. "Holder"])
end)

Styling:SecureHook(DB, "UpdateAll", function(self)
    for _, bar in pairs(DB.StatusBars) do
        Styling:HandleDataBar(bar, _G[bar:GetName() .. "Holder"])
    end
end)

function Styling:HandleDataBar(bar, holder)
    if not bar then
        return
    end

    Addon:CreateShadow(holder)
    local border = Addon:CreateBorder(holder, Addon.BORDER_CONFIG_KEYS.DATA_BAR)
    border.frameLevel = bar:GetFrameLevel() + 1
    border:Update()
end
