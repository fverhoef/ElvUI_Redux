local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinFrame(frame, useThinBorder)
    if not frame or Artwork:IsFrameRegistered(frame) then
        return
    end

    frame.useThinBorder = useThinBorder

    local frameBackground = Artwork:GetFrameBackground()
    local thinBorderAtlas = Artwork:GetThinFrameBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()
    local borderAtlas = frame.useThinBorder and thinBorderAtlas or frameBorderAtlas

    frame.ArtworkBackground = Artwork:CreateBackground(frame, frameBackground)
    frame.ArtworkBorder = Artwork:CreateBorder(frame, borderAtlas)
    Artwork:SkinCloseButton(Artwork:GetCloseButton(frame), closeButtonAtlas)

    Artwork:UpdateFrame(frame)
    Artwork:RegisterFrame(frame)
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local frameBackground = Artwork:GetFrameBackground()
    local thinBorderAtlas = Artwork:GetThinFrameBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()
    local borderAtlas = frame.useThinBorder and thinBorderAtlas or frameBorderAtlas
    local borderColor = frame.useThinBorder and E.db[addonName].artwork.thinFrameBorderColor or E.db[addonName].artwork.frameBorderColor or {
        1,
        1,
        1
    }

    Artwork:UpdateBackground(frame.ArtworkBackground, frameBackground)
    Artwork:UpdateBorder(frame.ArtworkBorder, borderAtlas)

    Artwork:UpdateBorderColor(frame.ArtworkBorder, borderColor)
    Artwork:UpdateCloseButton(Artwork:GetCloseButton(frame), closeButtonAtlas)
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