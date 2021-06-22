local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins

Skins.registry = {
    borders = {},
    shadows = {}
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