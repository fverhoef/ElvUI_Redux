local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")

Skins:SecureHook(A, "UpdateAura", function(self, button)
    Skins:HandleAura(button)
end)

function Skins:HandleAura(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetAuraBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Skins:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Skins:HandleTempEnchant(button)
end)

function Skins:HandleTempEnchant(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetTempEnchantBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end