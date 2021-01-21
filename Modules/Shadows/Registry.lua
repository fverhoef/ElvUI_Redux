local addonName, addonTable = ...
local Addon = addonTable[1]
local Shadows = Addon.Shadows

Shadows.registeredShadows = {}

function Shadows:RegisterShadow(shadow)
    if not shadow or shadow.isRegistered then
        return
    end
    Shadows.registeredShadows[shadow] = true
    shadow.isRegistered = true
end

function Shadows:UnregisterShadow(shadow)
    if not shadow or not shadow.isRegistered then
        return
    end
    Shadows.registeredShadows[shadow] = false
    shadow.isRegistered = false
    shadow.isHidden = true
end
