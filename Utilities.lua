local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

function Addon:Print(value, ...)
    print(Addon.title .. ":", string.format(value, ...))
end

function Addon:PrintError(value, ...)
    print(Addon.title .. ": error ", string.format(value, ...))
end

function Addon:Hex(r, g, b)
    if (type(r) == "table") then
        if (r.r) then
            r, g, b = r.r, r.g, r.b
        else
            r, g, b = unpack(r)
        end
    end

    return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

function Addon:ParseItemLink(itemLink)
    if not itemLink then
        return {}
    end
    local _, _, color, Ltype, itemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name =
        string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

    return {itemId = itemId, color = color}
end

function Addon:GetItemIdFromLink(itemLink)
    return Addon:ParseItemLink(itemLink).itemId
end