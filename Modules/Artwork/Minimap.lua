local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinMinimap()
    local borderAtlas = Addon:GetMinimapBorderAtlas()
    _G.Minimap.ArtworkBorder = Artwork:CreateBorder(_G.MMHolder, borderAtlas)

    if _G.Minimap.ButtonFrame then
        _G.Minimap.ButtonFrame.ArtworkBorder = Artwork:CreateBorder(_G.Minimap.ButtonFrame.Container, borderAtlas)
    end

    Artwork:UpdateMinimap()
end

function Artwork:UpdateMinimap()
    local borderAtlas = Addon:GetMinimapBorderAtlas()
    local borderColor = E.db[addonName].artwork.minimap.borderColor
    Artwork:UpdateBorder(_G.Minimap.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(_G.Minimap.ArtworkBorder, borderColor)

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        _G.Minimap:EnablePixelBorders()
        _G.MinimapPanel:Point("TOPLEFT", _G.Minimap, "BOTTOMLEFT", E.PixelMode and -1 or -2, 0)
        _G.MinimapPanel:Point("BOTTOMRIGHT", _G.Minimap, "BOTTOMRIGHT", E.PixelMode and 1 or 2, -22)
    else
        _G.Minimap:DisablePixelBorders()
        _G.MinimapPanel:Point("TOPLEFT", _G.Minimap, "BOTTOMLEFT", 2, 0)
        _G.MinimapPanel:Point("BOTTOMRIGHT", _G.Minimap, "BOTTOMRIGHT", 2, -22)
    end

    if _G.Minimap.ButtonFrame then
        Artwork:UpdateBorder(_G.Minimap.ButtonFrame.ArtworkBorder, borderAtlas)
        Artwork:UpdateBorderColor(_G.Minimap.ButtonFrame.ArtworkBorder, borderColor)
    end
end
