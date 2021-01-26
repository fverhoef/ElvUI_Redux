local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:GetCloseButton(frame)
    return frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"]
end

function Artwork:SkinCloseButton(button)
    if not button or Artwork:IsCloseButtonRegistered(button) then
        return
    end

    button.Background = button:CreateTexture(nil, "ARTWORK")
    button.Background:SetAllPoints(button)
    Artwork:UpdateCloseButton(button)

    Artwork:RegisterCloseButton(button)
end

function Artwork:UpdateCloseButton(button)
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()

    if not E.db[addonName].artwork.enabled or not closeButtonAtlas then
        button.Background:Hide()
    else
        button.Background:Show()

        if button.Background.atlas ~= closeButtonAtlas then
            button.Background.atlas = closeButtonAtlas
            button.Background:SetTexture(closeButtonAtlas[1])
            button.Background:SetTexCoord(closeButtonAtlas[4], closeButtonAtlas[5], closeButtonAtlas[6], closeButtonAtlas[7])
        end
    end
end
