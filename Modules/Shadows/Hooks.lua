local addonName, addonTable = ...
local Addon = addonTable[1]
local Shadows = Addon.Shadows
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")
local NP = E:GetModule("NamePlates")

Shadows:SecureHook(E, "Config_WindowOpened", function(self)
    local optionsFrame = E:Config_GetWindow()
    if optionsFrame then
        Shadows:CreateShadow(optionsFrame)
    end
end)

Shadows:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Shadows:CreateShadow(frame)
end)

Shadows:SecureHook(A, "UpdateAura", function(self, button)
    Shadows:CreateShadow(button)
end)

Shadows:SecureHook(A, "UpdateStatusBar", function(self, button)
    Shadows:CreateShadow(button)
end)

Shadows:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Shadows:CreateShadow(button)
end)

Shadows:SecureHook(NP, "UpdatePlate", function(...)
    local _, nameplate = ...
    if not nameplate.Health.shadow then
        Shadows:CreateShadow(nameplate.Health)
        Shadows:CreateShadow(nameplate.Power)
        Shadows:CreateShadow(nameplate.Castbar)
        hooksecurefunc(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
            Shadows:CreateShadow(button)
        end)
        hooksecurefunc(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Shadows:CreateShadow(button)
        end)
    end
end)

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Shadows:CreateShadow(self)
    end)
end
