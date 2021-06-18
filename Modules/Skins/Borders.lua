local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)

local function UpdateBorder(border, atlas, color)
    if not border then
        return
    end

    if not E.db[addonName].skins.borders.enabled or not atlas then
        border:Hide()
        border:RestoreOriginalBackdrop()
    else
        border:Show()
        border:HideOriginalBackdrop()

        if border.atlas ~= atlas then
            border.atlas = atlas

            local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
            border:SetPoint("TOPLEFT", border.parent, "TOPLEFT", offsetX, offsetY)
            border:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT", -offsetX, -offsetY)

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

        border:SetBorderScale(atlas)
        border:SetBorderColor(unpack(color))
    end
end

local function SetBorderScale(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].skins.enabled or not atlas then
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

    if scale ~= border:GetScale() then
        border:SetScale(scale)
    end
end

local function GetBorderColor(border)
    if not border then
        return
    end

    return border.TopLeft:GetVertexColor()
end

local function SetBorderColor(border, r, g, b, a)
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
            part:SetVertexColor(r, g, b, a)
        end
    end
end

local function HideOriginalBackdrop(border, force, backdropColor, backdropBorderColor)
    local frame = border.frame
    if frame.originalBackdrop and not force then
        return
    end

    if border.parent and border.parent.GetBackdrop then
        frame.originalBackdrop = frame.originalBackdrop or border.parent:GetBackdrop()

        backdropColor = backdropColor or {border.parent:GetBackdropColor()}
        backdropBorderColor = backdropBorderColor or {border.parent:GetBackdropBorderColor()}

        border.parent:SetBackdrop({
            bgFile = frame.originalBackdrop and frame.originalBackdrop.bgFile,
            insets = {left = 2, right = 2, top = 2, bottom = 2}
        })
        border.parent._SetBackdropBorderColor = border.parent.SetBackdropBorderColor
        border.parent.SetBackdropBorderColor = function(self, r, g, b, a)
            border:SetBorderColor(r, g, b, a)
        end
        border.parent:SetBackdropColor(unpack(backdropColor))
        border.parent:SetBackdropBorderColor(unpack(backdropBorderColor))
    end
end

local function RestoreOriginalBackdrop(border)
    local frame = border.frame
    if frame.originalBackdrop then
        local backdropColor = {border.parent:GetBackdropColor()}
        local backdropBorderColor = {border.parent:GetBackdropBorderColor()}

        border.parent:SetBackdrop(frame.originalBackdrop)
        border.parent.SetBackdropBorderColor = border.parent._SetBackdropBorderColor
        border.parent._SetBackdropBorderColor = nil
        border.parent:SetBackdropColor(unpack(backdropColor))
        border.parent:SetBackdropBorderColor(unpack(backdropBorderColor))

        frame.originalBackdrop = nil
    end
end

local function SetDrawLayer(border, layer, sublayer)
    border.TopLeft:SetDrawLayer(layer, sublayer)
    border.TopRight:SetDrawLayer(layer, sublayer)
    border.BottomLeft:SetDrawLayer(layer, sublayer)
    border.BottomRight:SetDrawLayer(layer, sublayer)
    border.Top:SetDrawLayer(layer, sublayer)
    border.Bottom:SetDrawLayer(layer, sublayer)
    border.Left:SetDrawLayer(layer, sublayer)
    border.Right:SetDrawLayer(layer, sublayer)
end

function Skins:CreateBorder(frame, atlas, color, layer)
    if not frame then
        return
    end
    if frame.border then
        frame.border:HideOriginalBackdrop(true, nil, {frame.border:GetBorderColor()})
        return frame.border
    end

    layer = layer or "BORDER"

    local parent = frame.backdrop or frame
    local border = CreateFrame("Frame", nil, parent)
    border.frame = frame
    border.parent = parent

    border.TopLeft = border:CreateTexture(nil, layer, nil, 2)
    border.TopRight = border:CreateTexture(nil, layer, nil, 2)
    border.BottomLeft = border:CreateTexture(nil, layer, nil, 2)
    border.BottomRight = border:CreateTexture(nil, layer, nil, 2)
    border.Top = border:CreateTexture(nil, layer, nil, 2)
    border.Bottom = border:CreateTexture(nil, layer, nil, 2)
    border.Left = border:CreateTexture(nil, layer, nil, 2)
    border.Right = border:CreateTexture(nil, layer, nil, 2)

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

    border:SetFrameLevel(frame:GetFrameLevel() + 1)
    border:SetScript("OnShow", function(self)
        self:SetBorderScale(atlas)
    end)

    border.Update = UpdateBorder
    border.SetBorderScale = SetBorderScale
    border.GetBorderColor = GetBorderColor
    border.SetBorderColor = SetBorderColor
    border.RestoreOriginalBackdrop = RestoreOriginalBackdrop
    border.HideOriginalBackdrop = HideOriginalBackdrop
    border.SetDrawLayer = SetDrawLayer
    border:Update(atlas, color)

    frame.border = border
    Skins:RegisterBorder(border)

    return border
end
