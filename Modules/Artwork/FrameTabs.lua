local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

-- Frame Tabs
function Artwork:SkinTab(tab, orientation)
    if not tab or Addon:IsTabRegistered(tab) then
        return
    end

    tab.orientation = orientation
    tab.originalPoint = {tab:GetPoint()}

    local parent = tab.backdrop or tab
    local border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, "ARTWORK")
    border.TopRight = border:CreateTexture(nil, "ARTWORK")
    border.BottomLeft = border:CreateTexture(nil, "ARTWORK")
    border.BottomRight = border:CreateTexture(nil, "ARTWORK")
    border.Top = border:CreateTexture(nil, "ARTWORK")
    border.Bottom = border:CreateTexture(nil, "ARTWORK")
    border.Left = border:CreateTexture(nil, "ARTWORK")
    border.Right = border:CreateTexture(nil, "ARTWORK")

    if orientation == "DOWN" then
        border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Left:SetPoint("TOPLEFT", border, "TOPLEFT")
        border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
        border.Right:SetPoint("TOPRIGHT", border, "TOPRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()
    elseif orientation == "RIGHT" then
        border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT")
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
        border.Top:SetPoint("TOPLEFT", border, "TOPLEFT")
        border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
        border.Bottom:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

        border.Left:Hide()
        border.TopLeft:Hide()
        border.BottomLeft:Hide()
    end

    tab.ArtworkBorder = border

    -- AuctionFrame tabs have their SetPoint method nulled after skinning, so store the original function
    tab.__SetPoint = tab.SetPoint

    if tab.SetPoint == E.noop then
        print("SetPoint has been nulled.")
    end

    Artwork:UpdateTab(tab)
    Addon:RegisterTab(tab)
end

function Artwork:UpdateTab(tab)
    if not tab or not tab.ArtworkBorder then
        return
    end

    local atlas = Addon:GetFrameTabBorderAtlas()

    Artwork:UpdateBorderColor(tab.ArtworkBorder, E.db[addonName].artwork.skins.frameTabBorderColor or {1, 1, 1})

    if not E.db[addonName].artwork.enabled or not atlas then
        tab:EnablePixelBorders()
        tab.ArtworkBorder:Hide()
    else
        tab:DisablePixelBorders()
        tab.ArtworkBorder:Show()

        local parent = tab.backdrop or tab
        local border = tab.ArtworkBorder

        if tab.atlas ~= atlas then
            tab.atlas = atlas

            local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
            border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX + (tab.orientation == "RIGHT" and 4 or 0), offsetY - (tab.orientation == "DOWN" and 2 or -4))
            border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX + (tab.orientation == "RIGHT" and 4 or 0), -offsetY - (tab.orientation == "DOWN" and 2 or 4))

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

        tab.ArtworkBorder:SetScale(atlas.scale)

        tab:SetFrameLevel(math.max(0, parent:GetFrameLevel() - 10))
        if tab.backdrop then
            tab.backdrop:SetFrameLevel(math.max(0, tab:GetFrameLevel() - 1))
        end
    end
end
