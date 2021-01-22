local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

function Artwork:SkinUnitFrame(unit, group)
    local unitFrame = type(unit) == "table" and unit or UF[unit]
    if not unitFrame or Artwork:IsUnitFrameRegistered(unitFrame) then
        return
    end

    unitFrame.unit = unitFrame.unit or unit
    unitFrame.group = unitFrame.group or group
    unitFrame.artworkKey = unitFrame.group or unitFrame.unit

    local borderAtlas = Artwork:GetUnitFrameBorderAtlas(unitFrame.artworkKey)
    unitFrame.ArtworkBorder = Artwork:CreateBorder(unitFrame, borderAtlas)
    unitFrame.ArtworkBorder:SetFrameLevel(math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)

    if unitFrame.Health then
        local healthBorderAtlas = Artwork:GetUnitFrameHealthBorderAtlas(unitFrame.artworkKey)
        unitFrame.Health.ArtworkBorder = Artwork:CreateBorder(unitFrame.Health, healthBorderAtlas)
        unitFrame.Health.ArtworkBorder:SetFrameLevel(unitFrame.Health:GetFrameLevel() + 1)
    end

    if unitFrame.Power then
        local powerBorderAtlas = Artwork:GetUnitFramePowerBorderAtlas(unitFrame.artworkKey)
        unitFrame.Power.ArtworkBorder = Artwork:CreateBorder(unitFrame.Power, powerBorderAtlas)
        unitFrame.Power.ArtworkBorder:SetFrameLevel(unitFrame.Power:GetFrameLevel() + 1)
        unitFrame.Power.ArtworkSeparator = Artwork:CreateSeparator(unitFrame.Power, powerBorderAtlas or borderAtlas, "Horizontal")
        unitFrame.Power.ArtworkSeparator:SetFrameLevel(unitFrame.Power:GetFrameLevel() + 1)
        unitFrame.Power.ArtworkSeparator:Hide()
    end

    if unitFrame.Castbar then
        local castBarBorderAtlas = Artwork:GetUnitFrameCastBarBorderAtlas(unitFrame.artworkKey)
        unitFrame.Castbar.ArtworkBorder = Artwork:CreateBorder(unitFrame.Castbar.Holder, castBarBorderAtlas)
        unitFrame.Castbar.ArtworkBorder:SetFrameLevel(unitFrame.Castbar:GetFrameLevel() + 1)
    end

    local classBar = unitFrame.ClassBar and unitFrame[unitFrame.ClassBar]
    if classBar then
        local classBarBorderAtlas = Artwork:GetUnitFrameClassBarBorderAtlas(unitFrame.artworkKey)
        classBar.ArtworkBorder = Artwork:CreateBorder(unitFrame.ClassBarHolder, classBarBorderAtlas)
        classBar.ArtworkBorder:SetFrameLevel(classBar:GetFrameLevel() + 1)
    end

    unitFrame:HookScript("OnShow", function(self)
        Artwork:UpdateUnitFrame(self)
    end)
    if unitFrame.Auras then
        Artwork:SecureHook(unitFrame.Auras, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if unitFrame.Buffs then
        Artwork:SecureHook(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if unitFrame.Debuffs then
        Artwork:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end

    local name = E:StringTitle(unitFrame.unit)
    if UF["Update_" .. name .. "Frame"] then
        Artwork:SecureHook(UF, "Update_" .. name .. "Frame", function(self, frame, db)
            Artwork:UpdateUnitFrame(frame)
        end)
    end

    Artwork:UpdateUnitFrame(unitFrame)
    Artwork:RegisterUnitFrame(unitFrame)
end

function Artwork:UpdateUnitFrame(unitFrame)
    if not unitFrame then
        return
    end

    local borderAtlas = Artwork:GetUnitFrameBorderAtlas(unitFrame.artworkKey)
    local borderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].borderColor

    Artwork:UpdateBorder(unitFrame.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(unitFrame.ArtworkBorder, borderColor)

    local healthBorderAtlas = Artwork:GetUnitFrameHealthBorderAtlas(unitFrame.artworkKey)
    local healthBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].healthBorderColor

    if unitFrame.Health then
        if borderAtlas then
            healthBorderAtlas = nil
        end

        Artwork:UpdateBorder(unitFrame.Health.ArtworkBorder, healthBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Health.ArtworkBorder, healthBorderColor)

        if not E.db[addonName].artwork.enabled or not (borderAtlas or healthBorderAtlas) then
            Artwork:EnablePixelBorders(unitFrame.Health)
        else
            Artwork:DisablePixelBorders(unitFrame.Health)
        end
    end

    if unitFrame.Power then
        local powerBorderAtlas = Artwork:GetUnitFramePowerBorderAtlas(unitFrame.artworkKey)
        local powerBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].powerBorderColor

        Artwork:UpdateBorder(unitFrame.Power.ArtworkBorder, powerBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Power.ArtworkBorder, powerBorderColor)

        if not E.db[addonName].artwork.enabled or not (borderAtlas or powerBorderAtlas) then
            Artwork:EnablePixelBorders(unitFrame.Power)
            unitFrame.Power.ArtworkSeparator:Hide()
        else
            if powerBorderAtlas or borderAtlas then
                Artwork:DisablePixelBorders(unitFrame.Power)
                if not unitFrame.POWERBAR_DETACHED and not unitFrame.USE_MINI_POWERBAR then
                    Artwork:UpdateSeparator(unitFrame.Power.ArtworkSeparator, powerBorderAtlas or healthBorderAtlas or borderAtlas, 0.25, 0, 6)
                    Artwork:UpdateSeparatorColor(unitFrame.Power.ArtworkSeparator, powerBorderColor or (healthBorderAtlas and healthBorderColor) or borderColor)
                    unitFrame.Power.ArtworkSeparator:Show()
                end
            else
                Artwork:EnablePixelBorders(unitFrame.Power)
                unitFrame.Power.ArtworkSeparator:Hide()
            end
        end
    end

    if unitFrame.Castbar then
        local castBarBorderAtlas = Artwork:GetUnitFrameCastBarBorderAtlas(unitFrame.artworkKey)
        local castBarBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].castBarBorderColor

        Artwork:UpdateBorder(unitFrame.Castbar.ArtworkBorder, castBarBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Castbar.ArtworkBorder, castBarBorderColor)
    end

    local classBar = unitFrame.ClassBar and unitFrame[unitFrame.ClassBar]
    if classBar then
        local classBarBorderAtlas = Artwork:GetUnitFrameClassBarBorderAtlas(unitFrame.artworkKey)
        local classBarBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].classBarBorderColor or {
            1,
            1,
            1
        }

        Artwork:UpdateBorder(classBar.ArtworkBorder, classBarBorderAtlas)
        Artwork:UpdateBorderColor(classBar.ArtworkBorder, classBarBorderColor)

        if not classBar:IsShown() then
            classBar.ArtworkBorder:Hide()
        else
            classBar.ArtworkBorder:Show()
        end
    end
end

function Artwork:SkinUnitFrameGroup(group)
    local header = UF[group]
    if not header or Artwork:IsGroupHeaderRegistered(header) then
        return
    end

    local name = E:StringTitle(group)
    if UF["Update_" .. name .. "Frames"] then
        Artwork:SecureHook(UF, "Update_" .. name .. "Frames", function(self, frame, db)
            Artwork:SkinUnitFrame(frame, group)
        end)
    end

    Artwork:RegisterGroupHeader(header)
end
