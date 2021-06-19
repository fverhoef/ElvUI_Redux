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
    border:SetFrameLevel(math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)

    if unitFrame.USE_MINI_POWERBAR then
        shadow.parent = unitFrame.Health.backdrop
        shadow:Update(true)
        border:ClearAllPoints()
        border:SetAllPoints(unitFrame.Health)
    else
        shadow.parent = unitFrame
        shadow:Update(true)
        border:ClearAllPoints()
        border:SetAllPoints(unitFrame)
    end

    if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
        Skins:CreateShadow(unitFrame.Power.Holder)
        Skins:CreateBorder(unitFrame.Power, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(unitFrame.Power))
    end

    if unitFrame.Castbar then
        Skins:CreateShadow(unitFrame.Castbar.Holder)
        Skins:CreateBorder(unitFrame.Castbar.Holder, Skins:GetUnitFrameBorderAtlas(),
                           Skins:GetBorderColor(unitFrame.Castbar.Holder))

        local iconBg = unitFrame.Castbar.ButtonIcon.bg
        Skins:CreateShadow(iconBg, unitFrame.db.castbar.iconAttached)
        local border = Skins:CreateBorder(iconBg, Skins:GetUnitFrameBorderAtlas(), Skins:GetBorderColor(iconBg))
        border:SetShown(not unitFrame.db.castbar.iconAttached)
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
end

function Skins:HandleUnitFrameGroup(group)
    local header = UF[group]
    if header then
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

Skins:SecureHook(UF, "Configure_Castbar", function(self, frame)
    local castbar = frame.Castbar
    if castbar.ButtonIcon and castbar.ButtonIcon.bg and castbar.ButtonIcon.bg.shadow then
        castbar.ButtonIcon.bg.shadow.isHidden = frame.db.castbar.iconAttached
        castbar.ButtonIcon.bg.shadow:Update()
    end
end)
