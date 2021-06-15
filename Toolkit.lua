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

function Addon:OffsetFrame(frame, offsetX, offsetY)
    if frame then
        if not frame.originalPoint then
            frame.originalPoint = {frame:GetPoint()}
        end
        frame:SetPoint(frame.originalPoint[1], frame.originalPoint[2], frame.originalPoint[3], frame.originalPoint[4] + offsetX, frame.originalPoint[5] + offsetY)
    end
end

local function Offset(frame, offsetX, offsetY)
    if frame then
        local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
        if not frame.originalPoint then
            frame.originalPoint = {
                point = point,
                relativeTo = relativeTo,
                relativePoint = relativePoint,
                xOfs = xOfs,
                yOfs = yOfs
            }
        end
        frame:SetPoint(frame.originalPoint.point, frame.originalPoint.relativeTo, frame.originalPoint.relativePoint,
                       frame.originalPoint.xOfs + offsetX, frame.originalPoint.yOfs + offsetY)
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
