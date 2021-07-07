local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")

Styling:SecureHook(A, "UpdateAura", function(self, button)
    Styling:HandleAura(button)
end)

function Styling:HandleAura(button)
    if not button then
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.AURA)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Styling:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Styling:HandleTempEnchant(button)
end)

function Styling:HandleTempEnchant(button)
    if not button then
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.AURA)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end