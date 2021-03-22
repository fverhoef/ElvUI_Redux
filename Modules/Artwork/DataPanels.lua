local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinDataPanel(panel)
    if not panel or Addon:IsDataPanelRegistered(panel) then
        return
    end

    local borderAtlas = Addon:GetDataPanelBorderAtlas()
    panel.ArtworkBorder = Artwork:CreateBorder(panel, borderAtlas)

    Artwork:UpdateDataPanel(panel)
    Addon:RegisterDataPanel(panel)
end

function Artwork:UpdateDataPanel(panel)
    if not panel then
        return
    end

    local borderAtlas = Addon:GetDataPanelBorderAtlas()
    Artwork:UpdateBorder(panel.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(panel.ArtworkBorder, E.db[addonName].artwork.dataBarsAndPanels.dataPanelBorderColor)
end

function Artwork:SkinChatPanel(panel)
    if not panel or Addon:IsChatPanelRegistered(panel) then
        return
    end

    local borderAtlas = Addon:GetDataPanelBorderAtlas()
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
    if not bar or Addon:IsDataPanelRegistered(bar) then
        return
    end

    local borderAtlas = Addon:GetDataBarBorderAtlas()
    bar.ArtworkBorder = Artwork:CreateBorder(bar.holder, borderAtlas, "ARTWORK")

    Artwork:UpdateDataBar(bar)
    Addon:RegisterDataBar(bar)
end

function Artwork:UpdateDataBar(bar)
    if not bar then
        return
    end

    local borderAtlas = Addon:GetDataBarBorderAtlas()
    Artwork:UpdateBorder(bar.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(bar.ArtworkBorder, E.db[addonName].artwork.dataBarsAndPanels.dataBarBorderColor)

    if bar.holder then
        if not E.db[addonName].artwork.enabled or not borderAtlas then
            bar:EnablePixelBorders()
            bar.holder:EnablePixelBorders()
        else
            bar:DisablePixelBorders(bar)
            bar.holder:DisablePixelBorders()
        end
    end
end
