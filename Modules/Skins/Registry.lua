local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins

Skins.registry = {
    borders = {},
    shadows = {},
    tabs = {}
}

function Skins:RegisterShadow(shadow)
    if not shadow or shadow.isRegistered then
        return
    end
    Skins.registry.shadows[shadow] = true
    shadow.isRegistered = true
end

function Skins:RegisterBorder(border)
    if not border or border.isRegistered then
        return
    end
    Skins.registry.borders[border] = true
    border.isRegistered = true
end

function Skins:RegisterTab(tab)
    if not tab or tab.isRegistered then
        return
    end
    Skins.registry.tabs[border] = true
    tab.isRegistered = true
end