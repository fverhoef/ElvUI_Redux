local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinTooltip(tip)
    if tip.ArtworkBorder then
        Artwork:UpdateTooltip(tip)
        return
    end

    local borderAtlas = Artwork:GetTooltipBorderAtlas()

    tip.ArtworkBorder = Artwork:CreateBorder(tip, borderAtlas)
    Artwork:UpdateTooltip(tip)
end

function Artwork:UpdateTooltip(tip)
    if not tip.ArtworkBorder then
        return
    end

    local borderAtlas = Artwork:GetTooltipBorderAtlas()

    Artwork:UpdateBorder(tip.ArtworkBorder, borderAtlas)

    local color = E.db[addonName].artwork.tooltipBorderColor
    if tip.GetItem then
        local _, link = tip:GetItem()
        if link then
            local _, _, quality = GetItemInfo(link)
            if quality and quality > 1 then
                color = {GetItemQualityColor(quality)}
            end
        end
    end

    Artwork:UpdateBorderColor(tip.ArtworkBorder, color)

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        Artwork:EnablePixelBorders(tip)
        tip.ArtworkBorder:Hide()
    else
        Artwork:DisablePixelBorders(tip)
        tip.ArtworkBorder:Show()
    end
end