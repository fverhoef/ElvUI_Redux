local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

Addon:SecureHook(UF, "Configure_HealthBar", function(self, unitFrame)
    Addon:HandleUnitFrame(unitFrame)
end)

Addon:SecureHook(UF, "Configure_Castbar", function(self, unitFrame)
    Addon:HandleUnitFrame(unitFrame)
end)

Addon:SecureHook(UF, "Configure_Power", function(self, unitFrame)
    Addon:HandleUnitFrame(unitFrame)
end)

local function HandleUnitFrameAura(unitFrame, unit, button)
    Addon:HandleAura(button)
end

function Addon:HandleUnitFrame(unitFrame)
    if not unitFrame then
        return
    end

    local shadow = Addon:CreateShadow(unitFrame.Health)
    local border = Addon:CreateBorder(unitFrame.Health, Addon.BORDER_CONFIG_KEYS.UNITFRAME_HEALTH)

    if unitFrame.USE_MINI_POWERBAR then
        shadow.anchor = unitFrame.Health
        shadow:Update(true)
        border.anchor = unitFrame.Health        
        border.frameLevel = nil
        border:Update(true)
    else
        shadow.anchor = unitFrame
        shadow:Update(true)
        border.anchor = unitFrame
        border.frameLevel = math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1
        border:Update(true)
    end

    if unitFrame.Power then
        local shadow = Addon:CreateShadow(unitFrame.Power)
        local border = Addon:CreateBorder(unitFrame.Power, Addon.BORDER_CONFIG_KEYS.UNITFRAME_POWER)

        if unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR then
            shadow.isHidden = false
            border.isHidden = false
        else
            shadow.isHidden = true
            border.isHidden = true
        end

        shadow:Update()
        border:Update()
    end

    if unitFrame.Castbar then
        Addon:CreateShadow(unitFrame.Castbar, unitFrame.Castbar.Holder)
        Addon:CreateBorder(unitFrame.Castbar, Addon.BORDER_CONFIG_KEYS.UNITFRAME_CASTBAR, unitFrame.Castbar.Holder)

        local iconBg = unitFrame.Castbar.ButtonIcon.bg
        Addon:CreateShadow(iconBg, nil, unitFrame.db.castbar.iconAttached)
        local iconBorder = Addon:CreateBorder(iconBg, Addon.BORDER_CONFIG_KEYS.UNITFRAME_CASTBAR)
        iconBorder:SetShown(not unitFrame.db.castbar.iconAttached)
    end

    if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
        Addon:CreateShadow(unitFrame.ClassBarHolder)
        Addon:CreateBorder(unitFrame.ClassBarHolder, Addon.BORDER_CONFIG_KEYS.UNITFRAME_CLASSBAR)
    end

    if unitFrame.Auras and not Addon:IsHooked(unitFrame.Auras, "PostUpdateIcon") then
        Addon:SecureHook(unitFrame.Auras, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Buffs and not Addon:IsHooked(unitFrame.Buffs, "PostUpdateIcon") then
        Addon:SecureHook(unitFrame.Buffs, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Debuffs and not Addon:IsHooked(unitFrame.Debuffs, "PostUpdateIcon") then
        Addon:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", HandleUnitFrameAura)
    end

    if unitFrame.Update and not Addon:IsHooked(unitFrame, "Update") then
        Addon:SecureHook(unitFrame, "Update", function(self)
            Addon:HandleUnitFrame(self)
        end)
    end
end

function Addon:HandleUnitFrameGroup(header)
    if not header then
        return
    end

    if header.groups then
        for i, group in next, header.groups do
            for j, obj in next, group do
                if type(obj) == "table" and obj.unit then
                    Addon:HandleUnitFrame(obj)
                end
            end
        end
    else
        -- tank, assist
        -- TODO: targets
        for i, obj in next, header do
            if type(obj) == "table" then
                if obj.unit then
                    Addon:HandleUnitFrame(obj)
                end
            end
        end
    end
end
