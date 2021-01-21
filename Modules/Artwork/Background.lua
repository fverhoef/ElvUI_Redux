local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:CreateBackground(frame, texture)
    if not frame then
        return
    end

    local parent = frame.backdrop or frame
    local background = CreateFrame("Frame", nil, parent)
    background:SetFrameLevel(math.max(0, parent:GetFrameLevel() - 1))
    background:SetAllPoints(parent)
    background.Texture = background:CreateTexture(nil, "BACKGROUND")
    background.Texture:SetHorizTile(true)
    background.Texture:SetVertTile(true)
    background.Texture:SetAllPoints(background)

    Artwork:UpdateBackground(background, texture)

    return background
end

function Artwork:UpdateBackground(background, texture)
    if not background then
        return
    end

    if not E.db[addonName].artwork.enabled or not texture then
        background:Hide()
    else
        background:Show()
        background.Texture:SetTexture(texture, "MIRROR", "MIRROR")

        local color = E.db[addonName].artwork.frameBackgroundColor or {0, 0, 0, 1}
        background.Texture:SetVertexColor(unpack(color))
    end
end