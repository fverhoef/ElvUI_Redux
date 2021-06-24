local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Misc")

Skins:SecureHook(M, "START_LOOT_ROLL", function(self, _, rollID, time)
    for _, bar in ipairs(M.RollBars) do
        Skins:HandleLootRollBar(bar)
    end
end)

function Skins:HandleLootRollBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
    Skins:CreateShadow(bar.button)
    local border = Skins:CreateBorder(bar, Addon.BORDER_CONFIG_KEYS.LOOT_ROLL_BAR)
    border:SetBorderColor(E.media.bordercolor)
    border = Skins:CreateBorder(bar.button, Addon.BORDER_CONFIG_KEYS.LOOT_ROLL_BAR)
    border:SetBorderColor(E.media.bordercolor)
end
