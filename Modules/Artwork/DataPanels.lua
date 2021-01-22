local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinDataPanel(panel)
    if not panel or Artwork:IsDataPanelRegistered(panel) then
        return
    end

    local borderAtlas = Artwork:GetDataPanelBorderAtlas()
    panel.ArtworkBorder = Artwork:CreateBorder(panel, borderAtlas)
    
    Artwork:UpdateDataPanel(panel)
    Artwork:RegisterDataPanel(panel)
end

function Artwork:UpdateDataPanel(panel)
    if not panel then
        return
    end

    local borderAtlas = Artwork:GetDataPanelBorderAtlas()
    Artwork:UpdateBorder(panel.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(panel.ArtworkBorder, E.db[addonName].artwork.dataPanelBorderColor)
end