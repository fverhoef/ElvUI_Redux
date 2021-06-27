local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Misc")

Styling:SecureHook(M, "START_LOOT_ROLL", function(self, _, rollID, time)
    for _, bar in ipairs(M.RollBars) do
        Styling:HandleLootRollBar(bar)
    end
end)

function Styling:HandleLootRollBar(bar)
    if not bar then
        return
    end

    Addon:CreateShadow(bar)
    Addon:CreateShadow(bar.button)
    local border = Addon:CreateBorder(bar, Addon.BORDER_CONFIG_KEYS.LOOT_ROLL_BAR)
    border:SetBorderColor(E.media.bordercolor)
    border = Addon:CreateBorder(bar.button, Addon.BORDER_CONFIG_KEYS.LOOT_ROLL_BAR)
    border:SetBorderColor(E.media.bordercolor)
end
