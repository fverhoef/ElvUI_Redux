local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

Styling:SecureHook(UF, "Configure_HealthBar", function(self, unitFrame)
    Styling:HandleUnitFrame(unitFrame)
end)

Styling:SecureHook(UF, "Configure_Castbar", function(self, unitFrame)
    Styling:HandleUnitFrame(unitFrame)
end)

Styling:SecureHook(UF, "Configure_Power", function(self, unitFrame)
    Styling:HandleUnitFrame(unitFrame)
end)

local function HandleUnitFrameAura(unitFrame, unit, button)
    Styling:HandleAura(button)
end

function Styling:HandleUnitFrame(unitFrame)
    if not unitFrame then
        return
    end

    if unitFrame.Health then
        Styling:ApplyStyle(unitFrame.Health, Addon.STYLE_CONFIG_KEYS.UNITFRAME)

        local shadow = unitFrame.Health:GetShadow()
        local border = unitFrame.Health:GetBorder()
        local inlay = unitFrame.Health:GetInlay()

        if shadow and border then
            if unitFrame.USE_MINI_POWERBAR or unitFrame.USE_POWERBAR_OFFSET or unitFrame.USE_INSET_POWERBAR then
                shadow.anchor = nil
                border.anchor = nil
                inlay.anchor = nil
                border.frameLevel = nil
            else
                shadow.anchor = unitFrame
                border.anchor = unitFrame
                inlay.anchor = unitFrame
                border.frameLevel = math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 2
            end

            shadow:Update()
            border:Update()
            inlay:Update()
            border:SetDrawLayer("OVERLAY")
            inlay:SetDrawLayer("OVERLAY")
        end
    end

    if unitFrame.Power then
        Styling:ApplyStyle(unitFrame.Power, Addon.STYLE_CONFIG_KEYS.UNITFRAME_POWER)

        local shadow = unitFrame.Power:GetShadow()
        local border = unitFrame.Power:GetBorder()
        local inlay = unitFrame.Power:GetInlay()

        if shadow and border then
            if unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR or unitFrame.USE_POWERBAR_OFFSET or unitFrame.USE_INSET_POWERBAR then
                shadow.isHidden = false
                inlay.isHidden = false
                border.frameLevel = unitFrame.Power:GetFrameLevel() + 2

                border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
                border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
                border.TopLeft:Show()
                border.TopRight:Show()
                border.BottomLeft:Show()
                border.BottomRight:Show()
                border.Bottom:Show()
                border.Left:Show()
                border.Right:Show()
            else
                shadow.isHidden = true
                inlay.isHidden = true
                border.frameLevel = nil

                border.Top:SetPoint("TOPLEFT", border, "TOPRIGHT")
                border.Top:SetPoint("TOPRIGHT", border, "TOPLEFT")
                border.TopLeft:Hide()
                border.TopRight:Hide()
                border.BottomLeft:Hide()
                border.BottomRight:Hide()
                border.Bottom:Hide()
                border.Left:Hide()
                border.Right:Hide()
            end

            shadow:Update()
            border:Update()
            inlay:Update()
            border:SetDrawLayer("OVERLAY")
            inlay:SetDrawLayer("OVERLAY")
        end
    end
    
    if unitFrame.Portrait then
        local shadow = unitFrame.Portrait:GetShadow()
        if shadow then
            shadow.isHidden = true
            shadow:Update()
        end
    end

    if unitFrame.Castbar then
        Styling:ApplyStyle(unitFrame.Castbar, Addon.STYLE_CONFIG_KEYS.UNITFRAME_CASTBAR)
        
        local border = unitFrame.Castbar:GetBorder()
        border.frameLevel = unitFrame.Castbar:GetFrameLevel() + 2
        border:SetDrawLayer("OVERLAY")
        border:Update()

        local inlay = unitFrame.Castbar:GetInlay()
        inlay:SetDrawLayer("OVERLAY")
        inlay:Update()

        Styling:ApplyStyle(unitFrame.Castbar.ButtonIcon.bg, Addon.STYLE_CONFIG_KEYS.UNITFRAME_CASTBAR)
    end

    if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
        Styling:ApplyStyle(unitFrame.ClassBarHolder, Addon.STYLE_CONFIG_KEYS.UNITFRAME_CLASSBAR)
    end

    if unitFrame.Auras and not Styling:IsHooked(unitFrame.Auras, "PostUpdateIcon") then
        Styling:SecureHook(unitFrame.Auras, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Buffs and not Styling:IsHooked(unitFrame.Buffs, "PostUpdateIcon") then
        Styling:SecureHook(unitFrame.Buffs, "PostUpdateIcon", HandleUnitFrameAura)
    end
    if unitFrame.Debuffs and not Styling:IsHooked(unitFrame.Debuffs, "PostUpdateIcon") then
        Styling:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", HandleUnitFrameAura)
    end

    if unitFrame.Update and not Styling:IsHooked(unitFrame, "Update") then
        Styling:SecureHook(unitFrame, "Update", function(self)
            Styling:HandleUnitFrame(self)
        end)
    end
end

function Styling:HandleUnitFrameGroup(header)
    if not header then
        return
    end

    if header.groups then
        for i, group in next, header.groups do
            for j, obj in next, group do
                if type(obj) == "table" and obj.unit then
                    Styling:HandleUnitFrame(obj)
                end
            end
        end
    else
        -- tank, assist
        -- TODO: targets
        for i, obj in next, header do
            if type(obj) == "table" then
                if obj.unit then
                    Styling:HandleUnitFrame(obj)
                end
            end
        end
    end
end
