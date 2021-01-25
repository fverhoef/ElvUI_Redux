local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinFrame(frame, useThinBorder, noBackground)
    if not frame or Artwork:IsFrameRegistered(frame) then
        return
    end

    frame.useThinBorder = useThinBorder
    frame.noBackground = noBackground

    local borderAtlas = Artwork:GetFrameBorderAtlas(frame)

    frame.ArtworkBorder = Artwork:CreateBorder(frame, borderAtlas)
    if not frame.noBackground then
        local backgroundAtlas = Artwork:GetFrameBackgroundAtlas()
        frame.ArtworkBackground = Artwork:CreateBackground(frame, backgroundAtlas)
    end

    Artwork:UpdateFrame(frame)
    Artwork:RegisterFrame(frame)
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local borderAtlas = Artwork:GetFrameBorderAtlas(frame)
    local borderColor = Artwork:GetFrameBorderColor(frame)

    Artwork:UpdateBorder(frame.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(frame.ArtworkBorder, borderColor)

    if not frame.noBackground then
        local backgroundAtlas = Artwork:GetFrameBackgroundAtlas()
        Artwork:UpdateBackground(frame.ArtworkBackground, backgroundAtlas)
    end
end

function Artwork:SkinNestedFrame(frame)
    if not frame or Artwork:IsFrameRegistered(frame) then
        return
    end

    Artwork:RegisterNestedFrame(frame)
end

function Artwork:UpdateNestedFrame(frame)
    if not frame then
        return
    end
end

function Artwork:GetFrameBorderAtlas(frame)
    local borderAtlas = (frame.useThinBorder or E.db[addonName].artwork.skins.useThinFrameEverywhere) and Artwork:GetThinFrameBorderAtlas()
    if not borderAtlas then
        local frameAtlas = Artwork:GetFrameAtlas()
        borderAtlas = frameAtlas and frameAtlas.border
    end

    return borderAtlas
end

function Artwork:GetFrameBorderColor(frame)
    return (frame.useThinBorder or E.db[addonName].artwork.skins.useThinFrameEverywhere) and E.db[addonName].artwork.skins.thinFrameBorderColor or
               E.db[addonName].artwork.skins.frameBorderColor or {1, 1, 1}
end
