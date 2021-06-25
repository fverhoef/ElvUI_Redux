local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local NP = E:GetModule("NamePlates")

Skins:SecureHook(NP, "StylePlate", function(self, nameplate)
    Skins:HandleNamePlate(nameplate)
end)

Skins:SecureHook(NP, "UpdatePlate", function(self, nameplate)
    Skins:HandleNamePlate(nameplate)
end)

local function HandleNamePlateAura(self, unit, button)
    Skins:HandleAura(button)
end

function Skins:HandleNamePlate(nameplate)
    if not nameplate then
        return
    end

    Skins:CreateShadow(nameplate.Health)
    Skins:CreateBorder(nameplate.Health, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_HEALTH)

    Skins:CreateShadow(nameplate.Power)
    Skins:CreateBorder(nameplate.Power, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_POWER)

    Skins:CreateShadow(nameplate.Castbar)
    Skins:CreateBorder(nameplate.Castbar, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_CASTBAR)
    Skins:CreateShadow(nameplate.Castbar.Button)
    Skins:CreateBorder(nameplate.Castbar.Button, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_CASTBAR)

    if nameplate.Auras and not Addon:IsHooked(nameplate.Auras, "PostUpdateIcon") then
        Addon:SecureHook(nameplate.Auras, "PostUpdateIcon", HandleNamePlateAura)
    end
    if nameplate.Buffs and not Addon:IsHooked(nameplate.Buffs, "PostUpdateIcon") then
        Addon:SecureHook(nameplate.Buffs, "PostUpdateIcon", HandleNamePlateAura)
    end
    if nameplate.Debuffs and not Addon:IsHooked(nameplate.Debuffs, "PostUpdateIcon") then
        Addon:SecureHook(nameplate.Debuffs, "PostUpdateIcon", HandleNamePlateAura)
    end
end
