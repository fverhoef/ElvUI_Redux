local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

function Artwork:SkinUnitFrame(unit, group)
    local unitFrame = type(unit) == "table" and unit or UF[unit]
    if not unitFrame or Addon:IsUnitFrameRegistered(unitFrame) then
        return
    end

    unitFrame.unit = unitFrame.unit or unit
    unitFrame.group = unitFrame.group or group
    unitFrame.artworkKey = unitFrame.group or unitFrame.unit

    local borderAtlas = Addon:GetUnitFrameBorderAtlas(unitFrame.artworkKey)
    unitFrame.ArtworkBorder = Artwork:CreateBorder(unitFrame, borderAtlas)
    unitFrame.ArtworkBorder:SetFrameLevel(math.max(unitFrame.Health:GetFrameLevel(), unitFrame.Power and unitFrame.Power:GetFrameLevel() or 0) + 1)

    if unitFrame.Health then
        local healthBorderAtlas = Addon:GetUnitFrameHealthBorderAtlas(unitFrame.artworkKey)
        unitFrame.Health.ArtworkBorder = Artwork:CreateBorder(unitFrame.Health, healthBorderAtlas)
        unitFrame.Health.ArtworkBorder:SetFrameLevel(unitFrame.Health:GetFrameLevel() + 1)
    end

    if unitFrame.Power then
        local powerBorderAtlas = Addon:GetUnitFramePowerBorderAtlas(unitFrame.artworkKey)
        unitFrame.Power.ArtworkBorder = Artwork:CreateBorder(unitFrame.Power, powerBorderAtlas, "ARTWORK")
        unitFrame.Power.ArtworkBorder:SetFrameLevel(unitFrame.Power:GetFrameLevel() + 1)
    end

    if unitFrame.Castbar then
        local castBarBorderAtlas = Addon:GetUnitFrameCastBarBorderAtlas(unitFrame.artworkKey)
        unitFrame.Castbar.ArtworkBorder = Artwork:CreateBorder(unitFrame.Castbar.Holder, castBarBorderAtlas)
        unitFrame.Castbar.ArtworkBorder:SetFrameLevel(unitFrame.Castbar:GetFrameLevel() + 5)

        unitFrame.Castbar.ButtonIcon.ArtworkBorder = Artwork:CreateBorder(unitFrame.Castbar.ButtonIcon.bg, castBarBorderAtlas)
        unitFrame.Castbar.ButtonIcon.ArtworkBorder:SetFrameLevel(unitFrame.Castbar:GetFrameLevel() + 5)
    end

    local classBar = unitFrame.ClassBar and unitFrame[unitFrame.ClassBar]
    if classBar then
        local classBarBorderAtlas = Addon:GetUnitFrameClassBarBorderAtlas(unitFrame.artworkKey)
        classBar.ArtworkBorder = Artwork:CreateBorder(unitFrame.ClassBarHolder, classBarBorderAtlas, "ARTWORK")
        classBar.ArtworkBorder:SetFrameLevel(classBar:GetFrameLevel() + 1)
    end

    unitFrame:HookScript("OnShow", function(self)
        Artwork:UpdateUnitFrame(self)
    end)
    if unitFrame.Auras and not Artwork:IsHooked(unitFrame.Auras, "PostUpdateIcon") then
        Artwork:SecureHook(unitFrame.Auras, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if unitFrame.Buffs and not Artwork:IsHooked(unitFrame.Buffs, "PostUpdateIcon") then
        Artwork:SecureHook(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if unitFrame.Debuffs and not Artwork:IsHooked(unitFrame.Debuffs, "PostUpdateIcon") then
        Artwork:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end

    local name = E:StringTitle(unitFrame.unit)
    if UF["Update_" .. name .. "Frame"] and not Artwork:IsHooked(UF, "Update_" .. name .. "Frame") then
        Artwork:SecureHook(UF, "Update_" .. name .. "Frame", function(self, frame, db)
            Artwork:UpdateUnitFrame(frame)
        end)
    end

    Artwork:UpdateUnitFrame(unitFrame)
    Addon:RegisterUnitFrame(unitFrame)
end

function Artwork:UpdateUnitFrame(unitFrame)
    if not unitFrame then
        return
    end

    local borderAtlas = Addon:GetUnitFrameBorderAtlas(unitFrame.artworkKey)
    local borderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].borderColor

    Artwork:UpdateBorder(unitFrame.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(unitFrame.ArtworkBorder, borderColor)

    local healthBorderAtlas = Addon:GetUnitFrameHealthBorderAtlas(unitFrame.artworkKey)
    local healthBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].healthBorderColor

    if unitFrame.Health then
        if borderAtlas then
            healthBorderAtlas = nil
        end

        Artwork:UpdateBorder(unitFrame.Health.ArtworkBorder, healthBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Health.ArtworkBorder, healthBorderColor)

        if not E.db[addonName].artwork.enabled or not (borderAtlas or healthBorderAtlas) then
            unitFrame.Health:EnablePixelBorders()
        else
            unitFrame.Health:DisablePixelBorders()
        end

        --E:SetBackdropBorderTexture(unitFrame.Health, Addon.media.textures.borders.beautycase)
        --E:SetBackdropBorderSize(unitFrame.Health, 4)
    end

    if unitFrame.Power then
        local powerBorderAtlas = Addon:GetUnitFramePowerBorderAtlas(unitFrame.artworkKey)
        local powerBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].powerBorderColor

        Artwork:UpdateBorder(unitFrame.Power.ArtworkBorder, powerBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Power.ArtworkBorder, powerBorderColor)

        if not E.db[addonName].artwork.enabled or not (borderAtlas or powerBorderAtlas) or (not unitFrame.POWERBAR_DETACHED and not unitFrame.USE_MINI_POWERBAR) then
            unitFrame.Power:EnablePixelBorders()
        else
            unitFrame.Power:DisablePixelBorders()
        end

        --E:SetBackdropBorderTexture(unitFrame.Power, Addon.media.textures.borders.beautycase)
        --E:SetBackdropBorderSize(unitFrame.Power, 4)
    end

    if unitFrame.Castbar then
        local castBarBorderAtlas = Addon:GetUnitFrameCastBarBorderAtlas(unitFrame.artworkKey)
        local castBarBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].castBarBorderColor

        Artwork:UpdateBorder(unitFrame.Castbar.ArtworkBorder, castBarBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Castbar.ArtworkBorder, castBarBorderColor)

        Artwork:UpdateBorder(unitFrame.Castbar.ButtonIcon.ArtworkBorder, castBarBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Castbar.ButtonIcon.ArtworkBorder, castBarBorderColor)

        if unitFrame.db.castbar.iconAttached then
            unitFrame.Castbar.ButtonIcon.ArtworkBorder:Hide()
        else
            unitFrame.Castbar.ButtonIcon.ArtworkBorder:Show()
        end
    end

    local classBar = unitFrame.ClassBar and unitFrame[unitFrame.ClassBar]
    if classBar then
        local classBarBorderAtlas = Addon:GetUnitFrameClassBarBorderAtlas(unitFrame.artworkKey)
        local classBarBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].classBarBorderColor or {1, 1, 1}

        Artwork:UpdateBorder(classBar.ArtworkBorder, classBarBorderAtlas)
        Artwork:UpdateBorderColor(classBar.ArtworkBorder, classBarBorderColor)

        if not classBar:IsShown() then
            classBar.ArtworkBorder:Hide()
        else
            classBar.ArtworkBorder:Show()
        end
    end

    if not E.db[addonName].artwork.enabled or not (borderAtlas or healthBorderAtlas) then
        if unitFrame.glowResized then
            Artwork:ResizeFrameGlow(unitFrame.FrameGlow, 3)
            Artwork:ResizeFrameGlow(unitFrame.MouseGlow, 3)
            Artwork:ResizeFrameGlow(unitFrame.TargetGlow, 3)
            if unitFrame.ThreatIndicator then
                Artwork:ResizeFrameGlow(unitFrame.ThreatIndicator.MainGlow, 3)
                Artwork:ResizeFrameGlow(unitFrame.ThreatIndicator.PowerGlow, 3)
            end
            unitFrame.glowResized = false
        end
    else
        if not unitFrame.glowResized then
            Artwork:ResizeFrameGlow(unitFrame.FrameGlow, 5)
            Artwork:ResizeFrameGlow(unitFrame.MouseGlow, 5)
            Artwork:ResizeFrameGlow(unitFrame.TargetGlow, 5)
            if unitFrame.ThreatIndicator then
                Artwork:ResizeFrameGlow(unitFrame.ThreatIndicator.MainGlow, 5)
                Artwork:ResizeFrameGlow(unitFrame.ThreatIndicator.PowerGlow, 5)
            end
            unitFrame.glowResized = true
        end
    end
end

function Artwork:SkinUnitFrameGroup(group)
    local header = UF[group]
    if not header or Addon:IsGroupHeaderRegistered(header) then
        return
    end

    local name = E:StringTitle(group)
    if UF["Update_" .. name .. "Frames"] then
        Artwork:SecureHook(UF, "Update_" .. name .. "Frames", function(self, frame, db)
            if Addon:IsUnitFrameRegistered(frame) then
                Artwork:UpdateUnitFrame(frame)
            else
                Artwork:SkinUnitFrame(frame, group)
            end
        end)
    end

    Addon:RegisterGroupHeader(header)
end

function Artwork:ResizeFrameGlow(glow, size)
    if glow then
        glow:SetBackdrop({edgeFile = E.Libs.LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(size)})
        if glow.powerGlow then
            glow.powerGlow:SetBackdrop({edgeFile = E.Libs.LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(5)})
        end
    end
end
