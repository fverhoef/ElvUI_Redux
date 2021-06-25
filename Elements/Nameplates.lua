local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local NP = E:GetModule("NamePlates")

Addon:SecureHook(NP, "StylePlate", function(self, nameplate)
    Addon:HandleNamePlate(nameplate)
end)

Addon:SecureHook(NP, "UpdatePlate", function(self, nameplate)
    Addon:HandleNamePlate(nameplate)
end)

local function HandleNamePlateAura(self, unit, button)
    Addon:HandleAura(button)
end

function Addon:HandleNamePlate(nameplate)
    if not nameplate then
        return
    end

    Addon:CreateShadow(nameplate.Health)
    Addon:CreateBorder(nameplate.Health, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_HEALTH)

    Addon:CreateShadow(nameplate.Power)
    Addon:CreateBorder(nameplate.Power, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_POWER)

    Addon:CreateShadow(nameplate.Castbar)
    Addon:CreateBorder(nameplate.Castbar, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_CASTBAR)
    Addon:CreateShadow(nameplate.Castbar.Button)
    Addon:CreateBorder(nameplate.Castbar.Button, Addon.BORDER_CONFIG_KEYS.NAMEPLATE_CASTBAR)

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
