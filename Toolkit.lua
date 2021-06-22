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
    local _, _, color, Ltype, itemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink,
                                                                                                                   "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

    return {itemId = itemId, color = color}
end

function Addon:GetItemIdFromLink(itemLink)
    return Addon:ParseItemLink(itemLink).itemId
end

local function Offset(frame, point, x, y)
    if frame then

        if not frame.originalPoints then
            frame.originalPoints = {}
            local numRegions = frame:GetNumPoints()
            for i = 1, numRegions do
                local anchor, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint(i)
                frame.originalPoints[anchor] = {anchor, relativeTo, relativePoint, xOfs, yOfs}
            end
        end
        local originalPoint = frame.originalPoints[point]
        if originalPoint then
            frame:SetPoint(originalPoint[1], originalPoint[2], originalPoint[3], originalPoint[4] + x, originalPoint[5] + y)
        end
    end
end

local function AddApi(object)
    local mt = getmetatable(object).__index
    if not object.Offset then
        mt.Offset = Offset
    end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
AddApi(object)
AddApi(object:CreateTexture())
AddApi(object:CreateFontString())
AddApi(object:CreateMaskTexture())

object = EnumerateFrames()
while object do
    if not object:IsForbidden() and not handled[object:GetObjectType()] then
        AddApi(object)
        handled[object:GetObjectType()] = true
    end

    object = EnumerateFrames(object)
end

AddApi(_G.GameFontNormal)
AddApi(CreateFrame("ScrollFrame"))
