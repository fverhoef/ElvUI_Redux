local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local NP = E:GetModule("NamePlates")
local UF = E:GetModule("UnitFrames")

local function HandleUnitFrameAura(unitFrame, unit, button)
    Skins:HandleAura(button)
end

function Skins:HandleUnitFrame(unit)
    local unitFrame = UF[unit]
    if unitFrame then
        local border

        if unitFrame.USE_MINI_POWERBAR then
            Skins:CreateShadow(unitFrame.Health)
            border = Skins:CreateBorder(unitFrame.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Health))
            border:SetFrameLevel(unitFrame.Health:GetFrameLevel() + 1)
        else
            Skins:CreateShadow(unitFrame)
            border = Skins:CreateBorder(unitFrame, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame))
            border:SetFrameLevel(math.max(unitFrame.Health:GetFrameLevel(),
                                          unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)
        end

        if unitFrame.Castbar then
            Skins:CreateShadow(unitFrame.Castbar.Holder)
            border = Skins:CreateBorder(unitFrame.Castbar.Holder, Skins:GetUnitFrameBorderAtlas(),
                                        Skins:GetBorderColor(unitFrame.Castbar.Holder))
            border:SetFrameLevel(unitFrame.Castbar.Holder:GetFrameLevel() + 1)

            local iconBg = unitFrame.Castbar.ButtonIcon.bg
            Skins:CreateShadow(iconBg, unitFrame.db.castbar.iconAttached)
            border = Skins:CreateBorder(iconBg, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(iconBg))
            border:SetShown(not unitFrame.db.castbar.iconAttached)
        end
        if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
            Skins:CreateShadow(unitFrame.Power.Holder)
            border = Skins:CreateBorder(unitFrame.Power.Holder, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Power))
            border:SetFrameLevel(unitFrame.Power.Holder:GetFrameLevel() + 1)
        end
        if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
            Skins:CreateShadow(unitFrame.ClassBarHolder)
            border = Skins:CreateBorder(unitFrame.ClassBarHolder, Skins:GetUnitFrameBorderAtlas(),
                                        Skins:GetBorderColor(unitFrame.ClassBarHolder))
            border:SetFrameLevel(unitFrame.ClassBarHolder:GetFrameLevel() + 1)
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

Skins:SecureHook(NP, "StylePlate", function(self, nameplate)
    Skins:HandleNamePlate(nameplate)
end)

local function HandleNamePlateAura(self, unit, button)
    Skins:HandleAura(button)
end

function Skins:HandleNamePlate(nameplate)
    if not nameplate then
        return
    end

    if not nameplate.Health.shadow then
        local border

        Skins:CreateShadow(nameplate.Health)
        border = Skins:CreateBorder(nameplate.Health, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Health))
        border:SetFrameLevel(nameplate.Health:GetFrameLevel() + 1)

        Skins:CreateShadow(nameplate.Power)
        border = Skins:CreateBorder(nameplate.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Power))
        border:SetFrameLevel(nameplate.Power:GetFrameLevel() + 1)

        Skins:CreateShadow(nameplate.Castbar)
        border = Skins:CreateBorder(nameplate.Castbar, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(nameplate.Castbar))
        border:SetFrameLevel(nameplate.Castbar:GetFrameLevel() + 1)

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

Skins:SecureHook(UF, "Configure_Castbar", function(self, frame)
    local castbar = frame.Castbar
    if castbar.ButtonIcon and castbar.ButtonIcon.bg and castbar.ButtonIcon.bg.shadow then
        castbar.ButtonIcon.bg.shadow.isHidden = frame.db.castbar.iconAttached
        castbar.ButtonIcon.bg.shadow:Update()
    end
end)
