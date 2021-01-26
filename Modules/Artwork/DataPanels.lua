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
    Artwork:UpdateBorderColor(panel.ArtworkBorder, E.db[addonName].artwork.dataBarsAndPanels.dataPanelBorderColor)
end

function Artwork:SkinChatPanel(panel)
    if not panel or Artwork:IsChatPanelRegistered(panel) then
        return
    end

    local borderAtlas = Artwork:GetDataPanelBorderAtlas()
    panel.ArtworkBorder = Artwork:CreateBorder(panel, borderAtlas)

    Artwork:UpdateDataPanel(panel)
    Artwork:UpdateChatPanel(panel)
end

function Artwork:UpdateChatPanel(panel)
    if not panel then
        return
    end
end

function Artwork:SkinDataBar(bar)
    if not bar or Artwork:IsDataPanelRegistered(bar) then
        return
    end

    local borderAtlas = Artwork:GetDataBarBorderAtlas()
    bar.ArtworkBorder = Artwork:CreateBorder(bar.holder, borderAtlas, "ARTWORK")

    Artwork:UpdateDataBar(bar)
    Artwork:RegisterDataBar(bar)
end

function Artwork:UpdateDataBar(bar)
    if not bar then
        return
    end

    local borderAtlas = Artwork:GetDataBarBorderAtlas()
    Artwork:UpdateBorder(bar.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(bar.ArtworkBorder, E.db[addonName].artwork.dataBarsAndPanels.dataBarBorderColor)

    if bar.holder then
        if not E.db[addonName].artwork.enabled or not borderAtlas then
            Artwork:EnablePixelBorders(bar)
            Artwork:EnablePixelBorders(bar.holder)
        else
            Artwork:DisablePixelBorders(bar)
            Artwork:DisablePixelBorders(bar.holder)
        end
    end
end
