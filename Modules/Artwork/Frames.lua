local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinFrame(frame, useThinBorder)
    if not frame or Artwork:IsFrameRegistered(frame) then
        return
    end

    frame.useThinBorder = useThinBorder

    local borderAtlas = Artwork:GetFrameBorderAtlas(frame)
    local backgroundAtlas = Artwork:GetFrameBackgroundAtlas()

    frame.ArtworkBorder = Artwork:CreateBorder(frame, borderAtlas)
    frame.ArtworkBackground = Artwork:CreateBackground(frame, backgroundAtlas)

    Artwork:UpdateFrame(frame)
    Artwork:RegisterFrame(frame)
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local borderAtlas = Artwork:GetFrameBorderAtlas(frame)
    local borderColor = Artwork:GetFrameBorderColor(frame)
    local backgroundAtlas = Artwork:GetFrameBackgroundAtlas()

    Artwork:UpdateBorder(frame.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(frame.ArtworkBorder, borderColor)
    Artwork:UpdateBackground(frame.ArtworkBackground, backgroundAtlas)
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
