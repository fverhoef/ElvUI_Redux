local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinNamePlate(nameplate)
    if not nameplate or Artwork:IsNamePlateRegistered(nameplate) then
        return
    end

    local healthBorderAtlas = Artwork:GetNamePlateHealthBorderAtlas()
    nameplate.Health.ArtworkBorder = Artwork:CreateBorder(nameplate.Health, borderAtlas)

    local powerBorderAtlas = Artwork:GetNamePlatePowerBorderAtlas()
    nameplate.Power.ArtworkBorder = Artwork:CreateBorder(nameplate.Power, powerBorderAtlas)

    local castBarBorderAtlas = Artwork:GetNamePlateCastBarBorderAtlas()
    nameplate.Castbar.ArtworkBorder = Artwork:CreateBorder(nameplate.Castbar, castBarBorderAtlas)

    if nameplate.Auras then
        Artwork:SecureHook(nameplate.Auras, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if nameplate.Buffs then
        Artwork:SecureHook(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end
    if nameplate.Debuffs then
        Artwork:SecureHook(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
            Artwork:SkinAura(button)
        end)
    end

    Artwork:UpdateNamePlate(nameplate)
    Artwork:RegisterNamePlate(nameplate)
end

function Artwork:UpdateNamePlate(nameplate)
    local healthBorderAtlas = Artwork:GetNamePlateHealthBorderAtlas()
    Artwork:UpdateBorder(nameplate.Health.ArtworkBorder, healthBorderAtlas)
    Artwork:UpdateBorderColor(nameplate.Health.ArtworkBorder, E.db[addonName].artwork.namePlates.healthBorderColor)

    local powerBorderAtlas = Artwork:GetNamePlatePowerBorderAtlas()
    Artwork:UpdateBorder(nameplate.Power.ArtworkBorder, powerBorderAtlas)
    Artwork:UpdateBorderColor(nameplate.Power.ArtworkBorder, E.db[addonName].artwork.namePlates.powerBorderColor)

    local castBarBorderAtlas = Artwork:GetNamePlateCastBarBorderAtlas()
    Artwork:UpdateBorder(nameplate.Castbar.ArtworkBorder, castBarBorderAtlas)
    Artwork:UpdateBorderColor(nameplate.Castbar.ArtworkBorder, E.db[addonName].artwork.namePlates.castBarBorderColor)
end
