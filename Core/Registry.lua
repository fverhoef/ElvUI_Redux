local addonName, addonTable = ...
local Addon = addonTable[1]

Addon.registry = {
    borders = {},
    shadows = {}
}

function Addon:RegisterShadow(shadow)
    if not shadow or shadow.isRegistered then
        return
    end
    Addon.registry.shadows[shadow] = true
    shadow.isRegistered = true
end

function Addon:RegisterBorder(border)
    if not border or border.isRegistered then
        return
    end
    Addon.registry.borders[border] = true
    border.isRegistered = true
end