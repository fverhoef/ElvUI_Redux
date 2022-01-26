local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local NP = E:GetModule("NamePlates")

Styling:SecureHook(NP, "StylePlate", function(self, nameplate)
    Styling:HandleNamePlate(nameplate)
end)

Styling:SecureHook(NP, "UpdatePlate", function(self, nameplate)
    Styling:HandleNamePlate(nameplate)
end)

local function HandleNamePlateAura(self, unit, button)
    Styling:HandleAura(button)
end

function Styling:HandleNamePlate(nameplate)
    if not nameplate then
        return
    end

    if nameplate.Health then
        Styling:ApplyStyle(nameplate.Health, Addon.STYLE_CONFIG_KEYS.NAMEPLATE)

        local border = nameplate.Health:GetBorder()
        if border then
            border:Update()
            border:SetDrawLayer("OVERLAY")
        end
    end

    if nameplate.Power then
        Styling:ApplyStyle(nameplate.Power, Addon.STYLE_CONFIG_KEYS.NAMEPLATE_POWER)

        local border = nameplate.Power:GetBorder()
        if border then
            border:Update()
            border:SetDrawLayer("OVERLAY")
        end
    end

    if nameplate.Castbar then
        Styling:ApplyStyle(nameplate.Castbar, Addon.STYLE_CONFIG_KEYS.NAMEPLATE_CASTBAR)

        local border = nameplate.Castbar:GetBorder()
        if border then
            border:Update()
            border:SetDrawLayer("OVERLAY")
        end

        Styling:ApplyStyle(nameplate.Castbar.Button, Addon.STYLE_CONFIG_KEYS.NAMEPLATE_CASTBAR)
    end

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
