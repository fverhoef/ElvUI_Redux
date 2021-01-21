local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:CreateBorder(frame, atlas, layer)
    layer = layer or "ARTWORK"

    local parent = frame.backdrop or frame
    local border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, layer)
    border.TopRight = border:CreateTexture(nil, layer)
    border.BottomLeft = border:CreateTexture(nil, layer)
    border.BottomRight = border:CreateTexture(nil, layer)
    border.Top = border:CreateTexture(nil, layer)
    border.Bottom = border:CreateTexture(nil, layer)
    border.Left = border:CreateTexture(nil, layer)
    border.Right = border:CreateTexture(nil, layer)

    border.TopLeft:SetPoint("TOPLEFT", border, "TOPLEFT")
    border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT")
    border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
    border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
    border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
    border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
    border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
    border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
    border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT")
    border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
    border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
    border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

    border:SetScript("OnShow", function(self)
        Artwork:UpdateBorderScale(self, atlas)
    end)

    Artwork:UpdateBorder(border, atlas)

    return border
end

function Artwork:UpdateBorder(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        border:Hide()
    else
        border:Show()

        if border.atlas ~= atlas then
            border.atlas = atlas

            local parent = border:GetParent()
            local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
            border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX, offsetY)
            border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX, -offsetY)

            border.TopLeft:SetSize(atlas.topLeft[2], atlas.topLeft[3])
            border.TopLeft:SetTexture(atlas.topLeft[1])
            border.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

            border.TopRight:SetSize(atlas.topRight[2], atlas.topRight[3])
            border.TopRight:SetTexture(atlas.topRight[1])
            border.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

            border.BottomLeft:SetSize(atlas.bottomLeft[2], atlas.bottomLeft[3])
            border.BottomLeft:SetTexture(atlas.bottomLeft[1])
            border.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

            border.BottomRight:SetSize(atlas.bottomRight[2], atlas.bottomRight[3])
            border.BottomRight:SetTexture(atlas.bottomRight[1])
            border.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

            border.Top:SetSize(atlas.top[2], atlas.top[3])
            border.Top:SetTexture(atlas.top[1], "MIRROR")
            border.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])
            border.Top:SetHorizTile(atlas.horizontalTiling)

            border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.horizontalTiling)

            border.Left:SetSize(atlas.left[2], atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.verticalTiling)

            border.Right:SetSize(atlas.right[2], atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.verticalTiling)
        end

        Artwork:UpdateBorderScale(border, atlas)
    end
end

function Artwork:UpdateBorderScale(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        return
    end

    local parent = border:GetParent()
    local scale = atlas.scale
    local minWidth = atlas.topLeft[2] + atlas.topRight[2]
    local minHeight = atlas.topLeft[3] + atlas.bottomLeft[3]

    local parentWidth, parentHeight = parent:GetSize()
    if parentWidth > 0 and parentWidth < (scale * minWidth) then
        scale = parentWidth / minWidth
    end
    if parentHeight > 0 and parentHeight < (scale * minHeight) then
        scale = parentHeight / minHeight
    end
    border:SetScale(scale)
end

function Artwork:UpdateBorderColor(border, color)
    if not border then
        return
    end

    local parts = {
        border.TopLeft,
        border.TopRight,
        border.BottomLeft,
        border.BottomRight,
        border.Top,
        border.Bottom,
        border.Left,
        border.Right
    }
    for _, part in ipairs(parts) do
        if part then
            part:SetVertexColor(unpack(color))
        end
    end
end

function Artwork:EnablePixelBorders(frame)
    E:TogglePixelBorders(frame, true)
    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    end

    if frame.backdrop then
        Artwork:EnablePixelBorders(frame.backdrop)
    end
end

function Artwork:DisablePixelBorders(frame)
    E:TogglePixelBorders(frame, false)
    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    end

    if frame.backdrop then
        Artwork:DisablePixelBorders(frame.backdrop)
    end
end