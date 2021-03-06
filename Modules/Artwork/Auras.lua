local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinAura(button)
    if not button or Artwork:IsAuraRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetAuraBorderAtlas()

    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateAura(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, Artwork:GetAuraBorderColor(button))

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = Artwork:GetAuraBorderColor(self)
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)

    Artwork:RegisterAura(button)
end

function Artwork:UpdateAura(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetAuraBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local name = button:GetName()
    local icon = _G[name .. "Icon"]

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetInside()
        end
        if button.hover then
            button.hover:SetInside()
        end
    else
        if icon then
            icon:SetInside(nil, 4, 4)
        end
        if button.hover then
            button.hover:SetInside(nil, 2, 2)
        end
    end
end

function Artwork:GetAuraBorderColor(button)
    if button.debuffType ~= "none" then
        local debuffColor = button.filter == "HARMFUL" and _G.DebuffTypeColor[button.debuffType]
        if debuffColor then
            return {debuffColor.r, debuffColor.g, debuffColor.b, debuffColor.a or 1}
        end
    end

    return E.db[addonName].artwork.auras.auraBorderColor
end

function Artwork:SkinTempEnchant(button)
    if not button or Artwork:IsTempEnchantRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetTempEnchantBorderAtlas()

    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateTempEnchant(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.auras.tempEnchantBorderColor)

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.auras.tempEnchantBorderColor
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)

    Artwork:RegisterTempEnchant(button)
end

function Artwork:UpdateTempEnchant(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetTempEnchantBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local name = button:GetName()
    local icon = _G[name .. "Icon"]

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetInside()
        end
        if button.hover then
            button.hover:SetInside()
        end
    else
        if icon then
            icon:SetInside(nil, 4, 4)
        end
        if button.hover then
            button.hover:SetInside(nil, 2, 2)
        end
    end
end
