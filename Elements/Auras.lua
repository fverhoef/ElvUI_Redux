local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")

Addon:SecureHook(A, "UpdateAura", function(self, button)
    Addon:HandleAura(button)
end)

function Addon:HandleAura(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.AURA)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Addon:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Addon:HandleTempEnchant(button)
end)

function Addon:HandleTempEnchant(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.AURA)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end