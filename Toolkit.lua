local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

local DEFAULT_SHADOW_ALPHA = 0.7

E.PixelBorders = {"TOPLEFT", "TOP", "TOPRIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT", "LEFT", "RIGHT"}
function E:SetBackdrop(frame, giveBorder, bgFile, edgeSize, insetLeft, insetRight, insetTop, insetBottom)
    if not frame.pixelBorders then
        return
    end

    for _, v in pairs(E.PixelBorders) do
        if not frame.pixelBorders[v] then
            frame.pixelBorders[v] = frame:CreateTexture("$parentPixelBorder" .. v, "BORDER", nil, 1)
            frame.pixelBorders[v]:SetTexture(E.media.blankTex)
        end
    end

    local shownBorders = frame.pixelBorders.TOP:IsShown()
    if shownBorders and not giveBorder then
        E:TogglePixelBorders(frame)
    elseif not shownBorders then
        E:TogglePixelBorders(frame, true)
    end

    frame.pixelBorders.CENTER:SetTexture(bgFile)

    if not (giveBorder or bgFile) then
        return
    end

    if insetLeft or insetRight or insetTop or insetBottom then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", -insetLeft or 0, insetTop or 0)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", insetRight or 0, -insetBottom or 0)
    else
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame)
    end

    frame.pixelBorders.TOP:SetHeight(edgeSize)
    frame.pixelBorders.BOTTOM:SetHeight(edgeSize)
    frame.pixelBorders.LEFT:SetWidth(edgeSize)
    frame.pixelBorders.RIGHT:SetWidth(edgeSize)

    frame.pixelBorders.TOPLEFT:SetSize(edgeSize, edgeSize)
    frame.pixelBorders.TOPRIGHT:SetSize(edgeSize, edgeSize)
    frame.pixelBorders.BOTTOMLEFT:SetSize(edgeSize, edgeSize)
    frame.pixelBorders.BOTTOMRIGHT:SetSize(edgeSize, edgeSize)
end

function E:SetBackdropBorderColor(frame, r, g, b, a)
    if frame.pixelBorders then
        for _, v in pairs(E.PixelBorders) do
            if not frame.pixelBorders[v] then
                frame.pixelBorders[v] = frame:CreateTexture("$parentPixelBorder" .. v, "BORDER", nil, 1)
                frame.pixelBorders[v]:SetTexture(E.media.blankTex)
            end

            frame.pixelBorders[v]:SetVertexColor(r or 0, g or 0, b or 0, a)
        end
    end
end

function E:SetBackdropBorderAtlas(frame, atlas)
    local borders = (frame.backdrop and frame.backdrop.pixelBorders) or frame.pixelBorders
    if borders then
        for _, v in pairs(E.PixelBorders) do
            if not borders[v] then
                borders[v] = frame:CreateTexture("$parentPixelBorder" .. v, "BORDER", nil, 1)
            end
            borders[v]:ClearAllPoints()
        end

        borders.TOPLEFT:SetTexCoord(0, 8 / 64, 0, 8 / 64)
        borders.TOPRIGHT:SetTexCoord(56 / 64, 1, 0, 8 / 64)
        borders.BOTTOMLEFT:SetTexCoord(0, 8 / 64, 56 / 64, 1)
        borders.BOTTOMRIGHT:SetTexCoord(56 / 64, 1, 56 / 64, 1)
        borders.TOP:SetTexCoord(8 / 64, 56 / 64, 0, 8 / 64)
        borders.BOTTOM:SetTexCoord(8 / 64, 56 / 64, 56 / 64, 1)
        borders.LEFT:SetTexCoord(0, 8 / 64, 8 / 64, 56 / 64)
        borders.RIGHT:SetTexCoord(56 / 64, 1, 8 / 64, 56 / 64)

        borders.TOPLEFT:Point("TOPLEFT", borders.CENTER, "TOPLEFT", -size, size)
        borders.TOPRIGHT:Point("TOPRIGHT", borders.CENTER, "TOPRIGHT", size, size)
        borders.BOTTOMLEFT:Point("BOTTOMLEFT", borders.CENTER, "BOTTOMLEFT", -size, -size)
        borders.BOTTOMRIGHT:Point("BOTTOMRIGHT", borders.CENTER, "BOTTOMRIGHT", size, -size)
        borders.TOP:Point("TOPLEFT", borders.TOPLEFT, "TOPRIGHT")
        borders.TOP:Point("TOPRIGHT", borders.TOPRIGHT, "TOPLEFT")
        borders.BOTTOM:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "BOTTOMRIGHT")
        borders.BOTTOM:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "BOTTOMLEFT")
        borders.LEFT:Point("TOPLEFT", borders.TOPLEFT, "BOTTOMLEFT")
        borders.LEFT:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "TOPLEFT")
        borders.RIGHT:Point("TOPRIGHT", borders.TOPRIGHT, "BOTTOMRIGHT")
        borders.RIGHT:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "TOPRIGHT")
    end
end

function E:TogglePixelBorders(frame, show)
    if frame.pixelBorders then
        for _, v in pairs(E.PixelBorders) do
            if not frame.pixelBorders[v] then
                frame.pixelBorders[v] = frame:CreateTexture("$parentPixelBorder" .. v, "BORDER", nil, 1)
                frame.pixelBorders[v]:SetTexture(E.media.blankTex)
            end

            if show then
                frame.pixelBorders[v]:Show()
            else
                frame.pixelBorders[v]:Hide()
            end
        end
    end
end

function E:BuildPixelBorders(frame, noSecureHook)
    if frame and not frame.pixelBorders then
        local borders = {}

        for _, v in pairs(E.PixelBorders) do
            borders[v] = frame:CreateTexture("$parentPixelBorder" .. v, "BORDER", nil, 1)
            borders[v]:SetTexture(E.media.blankTex)
        end

        borders.CENTER = frame:CreateTexture("$parentPixelBorderCENTER", "BACKGROUND", nil, -1)

        borders.TOPLEFT:Point("TOPLEFT", borders.CENTER, "TOPLEFT", 1, -1)
        borders.TOPLEFT:SetTexCoord(0, 8 / 64, 0, 8 / 64)

        borders.TOPRIGHT:Point("TOPRIGHT", borders.CENTER, "TOPRIGHT", -1, -1)
        borders.TOPRIGHT:SetTexCoord(56 / 64, 1, 0, 8 / 64)

        borders.BOTTOMLEFT:Point("BOTTOMLEFT", borders.CENTER, "BOTTOMLEFT", 1, 1)
        borders.BOTTOMLEFT:SetTexCoord(0, 8 / 64, 56 / 64, 1)

        borders.BOTTOMRIGHT:Point("BOTTOMRIGHT", borders.CENTER, "BOTTOMRIGHT", -1, 1)
        borders.BOTTOMRIGHT:SetTexCoord(56 / 64, 1, 56 / 64, 1)

        borders.TOP:Point("TOPLEFT", borders.TOPLEFT, "TOPRIGHT")
        borders.TOP:Point("TOPRIGHT", borders.TOPRIGHT, "TOPLEFT")
        borders.TOP:SetTexCoord(8 / 64, 56 / 64, 0, 8 / 64)

        borders.BOTTOM:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "BOTTOMRIGHT")
        borders.BOTTOM:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "BOTTOMLEFT")
        borders.BOTTOM:SetTexCoord(8 / 64, 56 / 64, 56 / 64, 1)

        borders.LEFT:Point("TOPLEFT", borders.TOPLEFT, "BOTTOMLEFT")
        borders.LEFT:Point("BOTTOMLEFT", borders.BOTTOMLEFT, "TOPLEFT")
        borders.LEFT:SetTexCoord(0, 8 / 64, 8 / 64, 56 / 64)

        borders.RIGHT:Point("TOPRIGHT", borders.TOPRIGHT, "BOTTOMRIGHT")
        borders.RIGHT:Point("BOTTOMRIGHT", borders.BOTTOMRIGHT, "TOPRIGHT")
        borders.RIGHT:SetTexCoord(56 / 64, 1, 8 / 64, 56 / 64)

        if not noSecureHook then
            hooksecurefunc(frame, "SetBackdropColor", E.HookedSetBackdropColor)
            hooksecurefunc(frame, "SetBackdropBorderColor", E.HookedSetBackdropBorderColor)
        end

        frame.pixelBorders = borders
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

local function EnablePixelBorders(frame)
    E:TogglePixelBorders(frame, true)

    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    end

    if frame.backdrop then
        frame.backdrop:EnablePixelBorders()
    end
end

local function DisablePixelBorders(frame)
    E:TogglePixelBorders(frame, false)

    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    end

    if frame.backdrop then
        frame.backdrop:DisablePixelBorders()
    end
end

local function AddApi(object)
    local mt = getmetatable(object).__index
    if not object.Offset then
        mt.Offset = Offset
    end
    if not object.SetBackdropBorderAtlas then
        mt.SetBackdropBorderAtlas = E.SetBackdropBorderAtlas
    end
    if not object.EnablePixelBorders then
        mt.EnablePixelBorders = EnablePixelBorders
    end
    if not object.DisablePixelBorders then
        mt.DisablePixelBorders = DisablePixelBorders
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
