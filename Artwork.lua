local addonName, addonTable = ...
local Module = addonTable[1]
local Artwork = Module:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.Artwork = Artwork
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

Artwork.atlas = {
    ["Alliance"] = {
        size = {84, 84},
        offset = {-4, 4},
        topLeft = {Module.media.textures.frames.alliance, 0.000976562, 0.163086, 0.579102, 0.741211},
        topRight = {Module.media.textures.frames.alliance, 0.163086, 0.000976562, 0.579102, 0.741211},
        bottomLeft = {Module.media.textures.frames.alliance, 0.000976562, 0.163086, 0.741211, 0.579102},
        bottomRight = {Module.media.textures.frames.alliance, 0.163086, 0.000976562, 0.741211, 0.579102},
        top = {Module.media.textures.frames.alliance, 0, 0.25, 0.0322266, 0.0615234, nil, 15},
        bottom = {Module.media.textures.frames.alliance, 0, 0.25, 0.000976562, 0.0302734, nil, 15},
        left = {Module.media.textures.frames.allianceVertical, 0.015625, 0.484375, 0, 1, 15},
        right = {Module.media.textures.frames.allianceVertical, 0.515625, 0.984375, 0, 1, 15},
        closeButtonBackground = {Module.media.textures.frames.alliance, 0.165039, 0.197266, 0.579102, 0.610352, 33, 32}
    },
    ["Horde"] = {
        size = {84, 84},
        offset = {-4, 4},
        topLeft = {Module.media.textures.frames.horde, 0.000976562, 0.163086, 0.783203, 0.945312},
        topRight = {Module.media.textures.frames.horde, 0.163086, 0.000976562, 0.783203, 0.945312},
        bottomLeft = {Module.media.textures.frames.horde, 0.000976562, 0.163086, 0.945312, 0.783203},
        bottomRight = {Module.media.textures.frames.horde, 0.163086, 0.000976562, 0.945312, 0.783203},
        top = {Module.media.textures.frames.horde, 0, 0.25, 0.117188, 0.146484, nil, 15},
        bottom = {Module.media.textures.frames.horde, 0, 0.25, 0.0859375, 0.115234, nil, 15},
        left = {Module.media.textures.frames.hordeVertical, 0.015625, 0.484375, 0, 1, 15},
        right = {Module.media.textures.frames.hordeVertical, 0.515625, 0.984375, 0, 1, 15},
        closeButtonBackground = {Module.media.textures.frames.horde, 0.833984, 0.866211, 0.148438, 0.179688, 33, 32}
    },
    ["Metal"] = {
        size = {84, 84},
        offset = {-4, 4},
        topLeft = {Module.media.textures.frames.metal, 0.00390625, 0.652344, 0.253906, 0.902344},
        topRight = {Module.media.textures.frames.metal, 0.652344, 0.00390625, 0.253906, 0.902344},
        bottomLeft = {Module.media.textures.frames.metal, 0.00390625, 0.652344, 0.902344, 0.253906},
        bottomRight = {Module.media.textures.frames.metal, 0.652344, 0.00390625, 0.902344, 0.253906},
        top = {Module.media.textures.frames.metal, 0, 1, 0.128906, 0.246094, nil, 15},
        bottom = {Module.media.textures.frames.metal, 0, 1, 0.00390625, 0.121094, nil, 15},
        left = {Module.media.textures.frames.metalVertical, 0.015625, 0.484375, 0, 1, 15},
        right = {Module.media.textures.frames.metalVertical, 0.515625, 0.984375, 0, 1, 15},
        closeButtonBackground = {Module.media.textures.frames.metal, 0.660156, 0.789062, 0.253906, 0.378906, 33, 32}
    },
    ["DiamondMetal"] = {
        size = {48, 48},
        offset = {-8, 8},
        topLeft = {Module.media.textures.frames.diamondMetal, 0.00195312, 0.501953, 0.504395, 0.629395},
        topRight = {Module.media.textures.frames.diamondMetal, 0.00195312, 0.501953, 0.630371, 0.755371},
        bottomLeft = {Module.media.textures.frames.diamondMetal, 0.00195312, 0.501953, 0.252441, 0.377441},
        bottomRight = {Module.media.textures.frames.diamondMetal, 0.00195312, 0.501953, 0.378418, 0.503418},
        top = {Module.media.textures.frames.diamondMetal, 0, 0.5, 0.126465, 0.251465},
        bottom = {Module.media.textures.frames.diamondMetal, 0, 0.5, 0.000488281, 0.125488},
        left = {Module.media.textures.frames.diamondMetalVertical, 0.000976562, 0.250977, 0, 1},
        right = {Module.media.textures.frames.diamondMetalVertical, 0.25293, 0.50293, 0, 1},
        closeButtonBackground = {Module.media.textures.frames.metal, 0.660156, 0.789062, 0.253906, 0.378906, 33, 32}
    }
}

Artwork.registry = {
    frames = {},
    nestedFrames = {}
}

function Artwork:IsFrameRegistered(frame)
    return Artwork.registry.frames[frame] or Artwork.registry.nestedFrames[frame] or false
end

function Artwork:IsParentFrameRegistered(frame)
    local parent = frame:GetParent()
    while parent do
        if Artwork.registry.frames[parent] then
            return true
        end

        parent = parent:GetParent()
    end

    return false
end

function Artwork:Initialize()
    Artwork:ScheduleTimer("UpdateArtwork", 1)
end

function Artwork:UpdateArtwork()
    local theme = E.db[addonName].artwork.borderTheme
    local atlas = Artwork.atlas[theme]

    for frame, _ in pairs(Artwork.registry.frames) do
        Artwork:UpdateFrame(frame, atlas)
    end

    for frame, _ in pairs(Artwork.registry.nestedFrames) do
        Artwork:UpdateNestedFrame(frame, atlas)
    end
end

local originalHandleFrame = S.HandleFrame
S.HandleFrame = function(...)
    originalHandleFrame(...)

    local frame = select(2, ...)
    local theme = E.db[addonName].artwork.borderTheme
    local atlas = Artwork.atlas[theme]
    
    if Artwork:IsParentFrameRegistered(frame) then
        Artwork:SkinNestedFrame(frame, atlas)
    else
        Artwork:SkinFrame(frame, atlas)
    end
end

function Artwork:SkinFrame(frame, atlas)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    Artwork:CreateBorder(frame, atlas)
    Artwork:SkinCloseButton(frame.CloseButton or _G[frame:GetName() .. "CloseButton"], atlas)

    Artwork.registry.frames[frame] = true
end

function Artwork:UpdateFrame(frame, atlas)
    if not frame then
        return
    end

    Artwork:UpdateBorder(frame.Border, atlas)
    Artwork:UpdateCloseButton(frame.CloseButton or _G[frame:GetName() .. "CloseButton"], atlas)
end

function Artwork:SkinNestedFrame(frame, atlas)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    Artwork.registry.nestedFrames[frame] = true
end

function Artwork:UpdateNestedFrame(frame, atlas)
    if not frame then
        return
    end
end

function Artwork:CreateBorder(frame, atlas)
    if frame.Border then
        return
    end

    -- TODO: handle situation where size is outside frame size
    local parent = frame.backdrop or frame
    frame.Border = CreateFrame("Frame", nil, parent)
    frame.Border:SetAllPoints(parent)

    frame.Border.TopLeft = Artwork:CreateBorderPart(frame.Border, atlas.topLeft)
    frame.Border.TopRight = Artwork:CreateBorderPart(frame.Border, atlas.topRight)
    frame.Border.BottomLeft = Artwork:CreateBorderPart(frame.Border, atlas.bottomLeft)
    frame.Border.BottomRight = Artwork:CreateBorderPart(frame.Border, atlas.bottomRight)
    frame.Border.Top = Artwork:CreateBorderPart(frame.Border, atlas.top)
    frame.Border.Bottom = Artwork:CreateBorderPart(frame.Border, atlas.bottom)
    frame.Border.Left = Artwork:CreateBorderPart(frame.Border, atlas.left)
    frame.Border.Right = Artwork:CreateBorderPart(frame.Border, atlas.right)

    Artwork:UpdateBorder(frame.Border, atlas)
end

function Artwork:UpdateBorder(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled then
        border:Hide()
    else
        border:Show()
        local width, height = unpack(atlas.size)
        local offsetX, offsetY = unpack(atlas.offset)

        Artwork:UpdateBorderPart(border.TopLeft, atlas.topLeft)
        border.TopLeft:SetPoint("TOPLEFT", border, offsetX, offsetY)
        border.TopLeft:SetSize(width, height)

        Artwork:UpdateBorderPart(border.TopRight, atlas.topRight)
        border.TopRight:SetPoint("TOPRIGHT", border, -1 * offsetX, offsetY)
        border.TopRight:SetSize(width, height)

        Artwork:UpdateBorderPart(border.BottomLeft, atlas.bottomLeft)
        border.BottomLeft:SetPoint("BOTTOMLEFT", border, offsetX, -1 * offsetY)
        border.BottomLeft:SetSize(width, height)

        Artwork:UpdateBorderPart(border.BottomRight, atlas.bottomRight)
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, -1 * offsetX, -1 * offsetY)
        border.BottomRight:SetSize(width, height)

        Artwork:UpdateBorderPart(border.Top, atlas.top)
        border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
        border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
        border.Top:SetHeight(atlas.top[7] or height)

        Artwork:UpdateBorderPart(border.Bottom, atlas.bottom)
        border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Bottom:SetHeight(atlas.bottom[7] or height)

        Artwork:UpdateBorderPart(border.Left, atlas.left)
        border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT")
        border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
        border.Left:SetWidth(atlas.left[6] or width)

        Artwork:UpdateBorderPart(border.Right, atlas.right)
        border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")
        border.Right:SetWidth(atlas.right[6] or width)
    end
end

function Artwork:CreateBorderPart(border, atlas)
    local part = border:CreateTexture(nil, "ARTWORK")
    part:SetParent(border)
    Artwork:UpdateBorderPart(part, atlas)

    return part
end

function Artwork:UpdateBorderPart(part, atlas)
    part:SetTexture(atlas[1])
    part:SetTexCoord(atlas[2], atlas[3], atlas[4], atlas[5])
end

function Artwork:SkinCloseButton(closeButton, atlas)
    if closeButton then
        closeButton.Background = closeButton:CreateTexture(nil, "ARTWORK")
        closeButton.Background:SetAllPoints(closeButton)
        Artwork:UpdateCloseButton(closeButton, atlas)
    end
end

function Artwork:UpdateCloseButton(closeButton, atlas)
    local background = closeButton and closeButton.Background
    if background then
        if not E.db[addonName].artwork.enabled then
            background:Hide()
        else
            background:Show()

            local texture = atlas.closeButtonBackground and atlas.closeButtonBackground[1]
            background:SetTexture(texture)
            if texture then
                background:SetTexCoord(atlas.closeButtonBackground[2], atlas.closeButtonBackground[3], atlas.closeButtonBackground[4], atlas.closeButtonBackground[5])
            end
        end
    end
end
