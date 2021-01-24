local addonName, addonTable = ...
local Addon = addonTable[1]
local Shadows = Addon.Shadows
local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local NP = E:GetModule("NamePlates")
local UF = E:GetModule("UnitFrames")

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

Shadows:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Shadows:CreateShadow(_G[name .. "Holder"])
end)

Shadows:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Shadows:CreateShadow(panel)
end)

Shadows:SecureHook(NP, "StylePlate", function(self, nameplate)
    if not nameplate.Health.shadow then
        Shadows:CreateShadow(nameplate.Health)
        Shadows:CreateShadow(nameplate.Power)
        Shadows:CreateShadow(nameplate.Castbar)
        if nameplate.Auras and not Shadows:IsHooked(nameplate.Auras, "PostUpdateIcon") then
            Shadows:SecureHook(nameplate.Auras, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if nameplate.Buffs and not Shadows:IsHooked(nameplate.Buffs, "PostUpdateIcon") then
            Shadows:SecureHook(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if nameplate.Debuffs and not Shadows:IsHooked(nameplate.Debuffs, "PostUpdateIcon") then
            Shadows:SecureHook(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
    end
end)

Shadows:SecureHook(UF, "Configure_Castbar", function(self, frame)
    if not frame.shadow then
        return
    end
    if frame.Castbar.ButtonIcon and frame.Castbar.ButtonIcon.bg and frame.Castbar.ButtonIcon.bg.shadow then
        frame.Castbar.ButtonIcon.bg.shadow.isHidden = frame.db.castbar.iconAttached
        Shadows:UpdateShadow(frame.Castbar.ButtonIcon.bg.shadow)
    end
end)

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Shadows:CreateShadow(self)
    end)
end
