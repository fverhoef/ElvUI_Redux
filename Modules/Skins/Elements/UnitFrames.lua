local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

local function HandleUnitFrameAura(unitFrame)
    Skins:HandleAuraButton(button)
end

function Skins:HandleUnitFrame(unit)
    local unitFrame = UF[unit]
    if unitFrame then
        if unitFrame.USE_MINI_POWERBAR then
            Skins:CreateShadow(unitFrame.Health)
            Skins:CreateBorder(unitFrame.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Health))
            unitFrame.Health._border:SetFrameLevel(unitFrame.Health:GetFrameLevel() + 1)
        else
            Skins:CreateShadow(unitFrame)
            Skins:CreateBorder(unitFrame, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame))
            unitFrame._border:SetFrameLevel(math.max(unitFrame.Health:GetFrameLevel(),
                                                     unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)
        end

        if unitFrame.Castbar then
            Skins:CreateShadow(unitFrame.Castbar.Holder)
            Skins:CreateBorder(unitFrame.Castbar.Holder, Skins:GetUnitFrameBorderAtlas(),
                               Skins:GetBorderColor(unitFrame.Castbar.Holder))
            Skins:CreateShadow(unitFrame.Castbar.ButtonIcon.bg, unitFrame.db.castbar.iconAttached)
            unitFrame.Castbar.Holder._border:SetFrameLevel(unitFrame.Castbar.Holder:GetFrameLevel() + 1)
        end
        if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
            Skins:CreateShadow(unitFrame.Power.Holder)
            Skins:CreateBorder(unitFrame.Power.Holder, Skins:GetUnitFrameBorderAtlas(),
                               Skins:GetBorderColor(unitFrame.Power.Holder))
            unitFrame.Power.Holder._border:SetFrameLevel(unitFrame.Power.Holder:GetFrameLevel() + 1)
        end
        if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
            Skins:CreateShadow(unitFrame.ClassBarHolder)
            Skins:CreateBorder(unitFrame.ClassBarHolder, Skins:GetUnitFrameBorderAtlas(),
                               Skins:GetBorderColor(unitFrame.ClassBarHolder))
            unitFrame.ClassBarHolder._border:SetFrameLevel(unitFrame.ClassBarHolder:GetFrameLevel() + 1)
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
    end
end

function Skins:HandleUnitFrameGroup(group)
    local header = UF[group]
    if header then
        if header.groups then
            for i, group in next, header.groups do
                for j, obj in next, group do
                    if type(obj) == "table" then
                        if obj.unit then
                            if obj.USE_MINI_POWERBAR then
                                Skins:CreateShadow(obj.Health)
                                Skins:CreateBorder(obj.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj.Health))
                                obj.Health._border:SetFrameLevel(obj.Health:GetFrameLevel() + 1)

                                Skins:CreateShadow(obj.Power)
                                Skins:CreateBorder(obj.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj.Power))
                                obj.Power._border:SetFrameLevel(obj.Power:GetFrameLevel() + 1)
                            else
                                Skins:CreateShadow(obj)
                                Skins:CreateBorder(obj, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj))
                                obj._border:SetFrameLevel(math.max(obj.Health:GetFrameLevel(),
                                                                   obj.Power and obj.Power:GetFrameLevel() or 0) + 1)
                            end
                            if obj.Castbar then
                                Skins:CreateShadow(obj.Castbar.Holder)
                                Skins:CreateBorder(obj.Castbar.Holder, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj))
                                obj.Castbar.Holder._border:SetFrameLevel(obj.Castbar.Holder:GetFrameLevel() + 1)
                            end
                        end
                    end
                end
            end
        else
            -- tank, assist
            -- TODO: targets
            for i, obj in next, header do
                if type(obj) == "table" then
                    if obj.unit then
                        if obj.USE_MINI_POWERBAR then
                            Skins:CreateShadow(obj.Health)
                            Skins:CreateBorder(obj.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj.Health))
                            obj.Health._border:SetFrameLevel(obj.Health:GetFrameLevel() + 1)

                            Skins:CreateShadow(obj.Power)
                            Skins:CreateBorder(obj.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj.Power))
                            obj.Power._border:SetFrameLevel(obj.Power:GetFrameLevel() + 1)
                        else
                            Skins:CreateShadow(obj)
                            Skins:CreateBorder(obj, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj))
                            obj._border:SetFrameLevel(math.max(obj.Health:GetFrameLevel(),
                                                               obj.Power and obj.Power:GetFrameLevel() or 0) + 1)
                        end
                        if obj.Castbar then
                            Skins:CreateShadow(obj.Castbar.Holder)
                            Skins:CreateBorder(obj.Castbar.Holder, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(obj))
                            obj.Castbar.Holder._border:SetFrameLevel(obj.Castbar.Holder:GetFrameLevel() + 1)
                        end
                    end
                end
            end
        end
    end
end

local function HandleNamePlateAura(self, unit, button)
    Skins:HandleAuraButton(button)
end

function Skins:HandleNamePlate(nameplate)
    if not nameplate then
        return
    end

    if not nameplate.Health.shadow then
        Skins:CreateShadow(nameplate.Health)
        Skins:CreateBorder(nameplate.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Health))
        nameplate.Health._border:SetFrameLevel(nameplate.Health:GetFrameLevel() + 1)

        Skins:CreateShadow(nameplate.Power)
        Skins:CreateBorder(nameplate.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Power))
        nameplate.Power._border:SetFrameLevel(nameplate.Power:GetFrameLevel() + 1)

        Skins:CreateShadow(nameplate.Castbar)
        Skins:CreateBorder(nameplate.Castbar, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Castbar))
        nameplate.Castbar._border:SetFrameLevel(nameplate.Castbar:GetFrameLevel() + 1)

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
end
