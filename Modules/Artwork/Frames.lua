local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinFrame(frame, useThinBorder, noBackground, noTitle)
    if not frame or Addon:IsFrameRegistered(frame) then
        return
    end

    frame.useThinBorder = useThinBorder
    frame.noBackground = noBackground
    frame.noTitle = noTitle or true

    local borderAtlas = Addon:GetFrameBorderAtlas(frame)

    frame.ArtworkBorder = Artwork:CreateBorder(frame, borderAtlas)
    if not frame.noBackground then
        local backgroundAtlas = Addon:GetFrameBackgroundAtlas()
        frame.ArtworkBackground = Artwork:CreateBackground(frame, backgroundAtlas)
    end
    if not frame.noTitle then
        frame.ArtworkTitle = Artwork:CreateFrameTitle(frame)
    end

    Artwork:UpdateFrame(frame)
    Addon:RegisterFrame(frame)
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    Artwork:UpdateBorder(frame.ArtworkBorder, Addon:GetFrameBorderAtlas(frame))
    Artwork:UpdateBorderColor(frame.ArtworkBorder, Artwork:GetFrameBorderColor(frame))

    if not frame.noBackground then
        local backgroundAtlas = Addon:GetFrameBackgroundAtlas()
        Artwork:UpdateBackground(frame.ArtworkBackground, backgroundAtlas)
    end
    if not frame.noTitle then
        local titleAtlas = Addon:GetFrameTitleAtlas(frame)
        Artwork:UpdateFrameTitle(frame.ArtworkTitle, titleAtlas)
    end
end

function Artwork:SkinNestedFrame(frame)
    if not frame or Addon:IsFrameRegistered(frame) then
        return
    end

    Artwork:UpdateNestedFrame(frame)
    Addon:RegisterNestedFrame(frame)
end

function Artwork:UpdateNestedFrame(frame)
    if not frame then
        return
    end

    if not E.db[addonName].artwork.enabled then
        frame:EnablePixelBorders()
    else
        frame:DisablePixelBorders()
    end
end

function Artwork:CreateFrameTitle(frame, layer)
    if not frame then
        return
    end

    layer = layer or "BACKGROUND"

    local parent = frame.backdrop or frame
    local title = CreateFrame("Frame", nil, parent)
    title.parent = parent
    title.frame = frame

    title.Left = title:CreateTexture(nil, layer)
    title.Middle = title:CreateTexture(nil, layer)
    title.Right = title:CreateTexture(nil, layer)

    title.Left:SetPoint("TOPLEFT", parent, "TOPLEFT")
    title.Right:SetPoint("TOPRIGHT", parent, "TOPRIGHT")
    title.Middle:SetPoint("TOPRIGHT", title.Left, "TOPLEFT")
    title.Middle:SetPoint("TOPLEFT", title.Right, "TOPRIGHT")

    Artwork:UpdateFrameTitle(title)

    return title
end

function Artwork:UpdateFrameTitle(title, atlas)
    if not title then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        title:Hide()
    else
        title:Show()

        if title.atlas ~= atlas then
            title.atlas = atlas

            title.Left:SetSize(atlas.left[2], atlas.left[3])
            title.Left:SetTexture(atlas.left[1])
            title.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])

            title.Middle:SetSize(atlas.middle[2], atlas.middle[3])
            title.Middle:SetTexture(atlas.middle[1], "MIRROR")
            title.Middle:SetTexCoord(atlas.middle[4], atlas.middle[5], atlas.middle[6], atlas.middle[7])
            title.Middle:SetHorizTile(atlas.horizontalTiling)

            title.Right:SetSize(atlas.right[2], atlas.right[3])
            title.Right:SetTexture(atlas.right[1])
            title.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])

            title:SetScale(atlas.scale)
        end
    end
end

function Addon:GetFrameBorderAtlas(frame)
    local borderAtlas = (frame.useThinBorder or E.db[addonName].artwork.skins.useThinFrameEverywhere) and Addon:GetThinFrameBorderAtlas()
    if not borderAtlas then
        local frameAtlas = Addon:GetFrameAtlas()
        borderAtlas = frameAtlas and frameAtlas.border
    end

    return borderAtlas
end

function Artwork:GetFrameBorderColor(frame)
    return (frame.useThinBorder or E.db[addonName].artwork.skins.useThinFrameEverywhere) and E.db[addonName].artwork.skins.thinFrameBorderColor or
               E.db[addonName].artwork.skins.frameBorderColor or {1, 1, 1}
end

function Addon:GetFrameTitleAtlas(frame)
    if not frame or frame.useThinBorder or E.db[addonName].artwork.skins.useThinFrameEverywhere then
        return
    end

    local frameAtlas = Addon:GetFrameAtlas()
    return frameAtlas and frameAtlas.title
end
