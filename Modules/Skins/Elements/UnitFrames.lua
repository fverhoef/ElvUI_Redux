local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local NP = E:GetModule("NamePlates")
local UF = E:GetModule("UnitFrames")

local function HandleUnitFrameAura(unitFrame, unit, button)
    Skins:HandleAura(button)
end

function Skins:HandleUnitFrame(unitFrame)
    if not unitFrame then
        return
    end

    local shadow = Skins:CreateShadow(unitFrame.Health)
    local border = Skins:CreateBorder(unitFrame.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Health))

    if unitFrame.USE_MINI_POWERBAR then
        shadow.parent = unitFrame.Health.backdrop
        shadow:Update(true)
        border:ClearAllPoints()
        border:SetAllPoints(unitFrame.Health)
        border:SetFrameLevel(unitFrame.Health:GetFrameLevel() + 1)
    else
        shadow.parent = unitFrame
        shadow:Update(true)
        border:ClearAllPoints()
        border:SetAllPoints(unitFrame)
        border:SetFrameLevel(
            math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)
    end

    if unitFrame.Power then
        local shadow = Skins:CreateShadow(unitFrame.Power)
        local border = Skins:CreateBorder(unitFrame.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Power))

        if unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR then
            shadow:Show()
            border:Show()
            border:HideOriginalBackdrop()
        else
            shadow:Hide()
            border:Hide()
            border:RestoreOriginalBackdrop()
        end
    end

    if unitFrame.Castbar then
        Skins:CreateShadow(unitFrame.Castbar.Holder)
        local border = Skins:CreateBorder(unitFrame.Castbar, Skins:GetUnitFrameBorderAtlas(),
                                          Skins:GetBorderColor(unitFrame.Castbar))
        border:ClearAllPoints()
        border:SetAllPoints(unitFrame.Castbar.Holder)
        border:SetFrameLevel(unitFrame.Castbar.Holder:GetFrameLevel() + 1)

        local iconBg = unitFrame.Castbar.ButtonIcon.bg
        Skins:CreateShadow(iconBg, unitFrame.db.castbar.iconAttached)
        local iconBorder = Skins:CreateBorder(iconBg, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(iconBg))
        iconBorder:SetShown(not unitFrame.db.castbar.iconAttached)
    end

    if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
        Skins:CreateShadow(unitFrame.ClassBarHolder)
        Skins:CreateBorder(unitFrame.ClassBarHolder, Skins:GetUnitFrameBorderAtlas(),
                           Skins:GetBorderColor(unitFrame.ClassBarHolder))
    end

    if unitFrame.Auras and not Skins:IsHooked(unitFrame.Auras, "PostUpdateIcon") then
        Skins:SecureHook(unitFrame.Auras, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Buffs and not Skins:IsHooked(unitFrame.Buffs, "PostUpdateIcon") then
        Skins:SecureHook(unitFrame.Buffs, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Debuffs and not Skins:IsHooked(unitFrame.Debuffs, "PostUpdateIcon") then
        Skins:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", HandleUnitFrameAura)
    end

    if unitFrame.Update and not Skins:IsHooked(unitFrame, "Update") then
        Skins:SecureHook(unitFrame, "Update", function(self)
            Skins:HandleUnitFrame(self)
        end)
    end
end

Skins:SecureHook(UF, "Configure_HealthBar", function(self, unitFrame)
    Skins:HandleUnitFrame(unitFrame)
end)

Skins:SecureHook(UF, "Configure_Castbar", function(self, unitFrame)
    Skins:HandleUnitFrame(unitFrame)
end)

Skins:SecureHook(UF, "Configure_Power", function(self, unitFrame)
    Skins:HandleUnitFrame(unitFrame)
end)

function Skins:HandleUnitFrameGroup(header)
    if not header then
        return
    end

    if header.groups then
        for i, group in next, header.groups do
            for j, obj in next, group do
                if type(obj) == "table" and obj.unit then
                    Skins:HandleUnitFrame(obj)
                end
            end
        end
    else
        -- tank, assist
        -- TODO: targets
        for i, obj in next, header do
            if type(obj) == "table" then
                if obj.unit then
                    Skins:HandleUnitFrame(obj)
                end
            end
        end
    end
end

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
    Skins:CreateBorder(nameplate.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Health))

    Skins:CreateShadow(nameplate.Power)
    Skins:CreateBorder(nameplate.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Power))

    Skins:CreateShadow(nameplate.Castbar)
    Skins:CreateBorder(nameplate.Castbar, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Castbar))

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
