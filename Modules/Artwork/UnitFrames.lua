local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule("UnitFrames")

function Artwork:SkinUnitFrame(unit, group)
    local unitFrame = (type(unit) == "table" and unit) or UF[unit]
    if not unitFrame or Artwork:IsUnitFrameRegistered(unitFrame) then
        return
    end

    unit = unitFrame.unit or unit
    unitFrame.artworkKey = group or unit

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
        unitFrame.Castbar.ArtworkBorder = Artwork:CreateBorder(unitFrame.Castbar, castBarBorderAtlas)
        unitFrame.Castbar.ArtworkBorder:SetFrameLevel(unitFrame.Castbar:GetFrameLevel() + 1)
        -- Shadows:CreateShadow(unitFrame.Castbar.Holder)
    end

    unitFrame:HookScript("OnShow", function(self)
        Artwork:UpdateUnitFrame(self)
    end)

    if unitFrame.USE_MINI_POWERBAR then
        -- Shadows:CreateShadow(unitFrame.Health)
    else
        -- Shadows:CreateShadow(unitFrame)
    end
    if unitFrame.Castbar then
        -- Shadows:CreateShadow(unitFrame.Castbar.Holder)
    end
    if unitFrame.Power and (unitFrame.POWERBAR_DETACHED or unitFrame.USE_MINI_POWERBAR) then
        -- Shadows:CreateShadow(unitFrame.Power.Holder)
    end
    if unitFrame.ClassBar and unitFrame[unitFrame.ClassBar] and unitFrame[unitFrame.ClassBar]:IsShown() then
        -- Shadows:CreateShadow(unitFrame.ClassBarHolder)
    end
    Artwork:SecureHook(unitFrame.Buffs, "PostUpdateIcon", function(self, unit, button)
        -- Shadows:CreateShadow(button)
    end)
    Artwork:SecureHook(unitFrame.Debuffs, "PostUpdateIcon", function(self, unit, button)
        -- Shadows:CreateShadow(button)
    end)

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

    local powerBorderAtlas = Artwork:GetUnitFramePowerBorderAtlas(unitFrame.artworkKey)
    local powerBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].powerBorderColor

    if unitFrame.Power then
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

    local castBarBorderAtlas = Artwork:GetUnitFrameCastBarBorderAtlas(unitFrame.artworkKey)
    local castBarBorderColor = E.db[addonName].artwork.unitFrames[unitFrame.artworkKey].castBarBorderColor

    if unitFrame.Castbar then
        Artwork:UpdateBorder(unitFrame.Castbar.ArtworkBorder, castBarBorderAtlas)
        Artwork:UpdateBorderColor(unitFrame.Castbar.ArtworkBorder, castBarBorderColor)
    end
end

function Artwork:SkinUnitFrameGroup(groupName)
    local header = UF[groupName]
    if not header or Artwork:IsGroupHeaderRegistered(header) then
        return
    end

    if header.groups then
        for i, group in next, header.groups do
            for j, obj in next, group do
                if type(obj) == "table" then
                    if obj.unit then
                        Artwork:SkinUnitFrame(obj, groupName)
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
                    Artwork:SkinUnitFrame(obj, groupName)
                end
            end
        end
    end

    Artwork:UpdateUnitFrameGroupHeader(header)
    Artwork:RegisterGroupHeader(header)
end

function Artwork:UpdateUnitFrameGroupHeader(header)
    if not header then
        return
    end
end