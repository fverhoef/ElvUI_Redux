local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:GetCloseButton(frame)
    return frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"]
end

function Artwork:SkinCloseButton(button, backgroundAtlas)
    if button and not button.Background then
        if not backgroundAtlas then
            backgroundAtlas = Artwork:GetCloseButtonBackgroundAtlas()
        end

        button.Background = button:CreateTexture(nil, "ARTWORK")
        button.Background:SetAllPoints(button)
        Artwork:UpdateCloseButton(button, backgroundAtlas)
    end
end

function Artwork:UpdateCloseButton(button, backgroundAtlas)
    local background = button and button.Background
    if background then
        if not E.db[addonName].artwork.enabled or not backgroundAtlas then
            background:Hide()
        else
            background:Show()

            local texture = backgroundAtlas and backgroundAtlas[1]
            background:SetTexture(texture)
            if texture then
                background:SetTexCoord(backgroundAtlas[4], backgroundAtlas[5], backgroundAtlas[6], backgroundAtlas[7])
            end
        end
    end
end