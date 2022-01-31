local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")

Addon.templatedFrames = {}

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

local function Offset(frame, point, x, y)
    if not frame then
        return
    end
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

local function GetTemplate(template, isUnitFrameElement)
    if template == "ClassColor" then
        return E:ClassColor(E.myclass), E.media.backdropcolor
    elseif template == "Transparent" then
        return (isUnitFrameElement and E.media.unitframeBorderColor or E.media.bordercolor), E.media.backdropfadecolor
    else
        return (isUnitFrameElement and E.media.unitframeBorderColor or E.media.bordercolor), E.media.backdropcolor
    end
end

local function SetTemplate(frame, template, glossTex, ignoreUpdates, forcePixelMode, isUnitFrameElement, isNamePlateElement, noScale)
    template = frame.overrideTemplate or template
    frame.template = template or "Default"
    frame.glossTex = glossTex
    frame.ignoreUpdates = ignoreUpdates
    frame.forcePixelMode = forcePixelMode
    frame.isUnitFrameElement = isUnitFrameElement
    frame.isNamePlateElement = isNamePlateElement
    frame.noScale = noScale

    if not frame.SetBackdrop then
        _G.Mixin(frame, _G.BackdropTemplateMixin)
        frame:HookScript("OnSizeChanged", frame.OnBackdropSizeChanged)
    end

    if template == "NoBackdrop" then
        frame:SetBackdrop()

        local border = frame:GetBorder()
        if border then
            border:Hide()
        end
        local shadow = frame:GetShadow()
        if shadow then
            shadow:Hide()
        end
        local inlay = frame:GetInlay()
        if inlay then
            inlay:Hide()
        end
    else
        frame:SetBackdrop({
            bgFile = glossTex and (type(glossTex) == "string" and glossTex or E.media.glossTex) or E.media.blankTex,
            insets = {left = 2, right = 2, top = 2, bottom = 2}
        })

        frame:CreateShadow(false, Addon.STYLE_CONFIG_KEYS.DEFAULT)
        frame:CreateBorder(Addon.STYLE_CONFIG_KEYS.DEFAULT)
        frame:CreateInlay(Addon.STYLE_CONFIG_KEYS.DEFAULT)

        local borderColor, backdropColor = GetTemplate(template, isUnitFrameElement)

        if frame.callbackBackdropColor then
            frame:callbackBackdropColor()
        else
            frame:SetBackdropColor(backdropColor[1], backdropColor[2], backdropColor[3],
                                   frame.customBackdropAlpha or backdropColor[4] or 1)
        end

        if frame.forcedBorderColors then
            borderColor = frame.forcedBorderColors
        end

        frame:SetBackdropBorderColor(unpack(borderColor))
    end

    if not frame.ignoreUpdates then
        if frame.isUnitFrameElement then
            E.unitFrameElements[frame] = true
        else
            E.frames[frame] = true
        end
    end

    Addon.templatedFrames[frame] = true
end

local function RefreshTemplate(frame)
    frame:SetTemplate(frame.template, frame.glossTex, frame.ignoreUpdates, frame.forcePixelMode, frame.isUnitFrameElement, frame.isNamePlateElement, frame.noScale)
end

local function UpdateBorder(border, styleConfigKey)
    if not border then
        return
    end

    border.styleConfigKey = styleConfigKey or border.styleConfigKey

    local atlas = Addon:GetBorderAtlas(border.styleConfigKey)
    local scale = Addon:GetBorderScale(border.styleConfigKey) or 1
    local offset = Addon:GetBorderOffset(border.styleConfigKey)
    local parent = border:GetParent()
    local anchor = border.anchor or parent

    if not Addon:GetBorderEnabled(border.styleConfigKey) or not atlas or border.isHidden then
        border:Hide()
    else
        border:Show()

        local minWidth = atlas.topLeft[2] + atlas.topRight[2]
        local minHeight = atlas.topLeft[3] + atlas.bottomLeft[3]

        local parentWidth, parentHeight = parent:GetSize()
        if parentWidth > 0 and parentWidth < (scale * minWidth) then
            scale = parentWidth / minWidth
        end
        if parentHeight > 0 and parentHeight < (scale * minHeight) then
            scale = parentHeight / minHeight
        end

        if border.atlas ~= atlas then
            border.atlas = atlas
            border.scale = scale

            border.TopLeft:SetSize(scale * atlas.topLeft[2], scale * atlas.topLeft[3])
            border.TopLeft:SetTexture(atlas.topLeft[1])
            border.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

            border.TopRight:SetSize(scale * atlas.topRight[2], scale * atlas.topRight[3])
            border.TopRight:SetTexture(atlas.topRight[1])
            border.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

            border.BottomLeft:SetSize(scale * atlas.bottomLeft[2], scale * atlas.bottomLeft[3])
            border.BottomLeft:SetTexture(atlas.bottomLeft[1])
            border.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

            border.BottomRight:SetSize(scale * atlas.bottomRight[2], scale * atlas.bottomRight[3])
            border.BottomRight:SetTexture(atlas.bottomRight[1])
            border.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

            border.Top:SetSize(scale * atlas.top[2], scale * atlas.top[3])
            border.Top:SetTexture(atlas.top[1], "MIRROR")
            border.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])
            border.Top:SetHorizTile(atlas.horizontalTiling)

            border.Bottom:SetSize(scale * atlas.bottom[2], scale * atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.horizontalTiling)

            border.Left:SetSize(scale * atlas.left[2], scale * atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.verticalTiling)

            border.Right:SetSize(scale * atlas.right[2], scale * atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.verticalTiling)
        end

        if border.scale ~= scale then
            border.scale = scale

            border.TopLeft:SetSize(scale * atlas.topLeft[2], scale * atlas.topLeft[3])
            border.TopRight:SetSize(scale * atlas.topRight[2], scale * atlas.topRight[3])
            border.BottomLeft:SetSize(scale * atlas.bottomLeft[2], scale * atlas.bottomLeft[3])
            border.BottomRight:SetSize(scale * atlas.bottomRight[2], scale * atlas.bottomRight[3])
            border.Top:SetSize(scale * atlas.top[2], scale * atlas.top[3])
            border.Bottom:SetSize(scale * atlas.bottom[2], scale * atlas.bottom[3])
            border.Left:SetSize(scale * atlas.left[2], scale * atlas.left[3])
            border.Right:SetSize(scale * atlas.right[2], scale * atlas.right[3])
        end

        border.offset = offset
        local offsetX, offsetY = offset and offset[1] or 0, offset and offset[2] or 0
        border:ClearAllPoints()
        border:SetPoint("TOPLEFT", anchor, "TOPLEFT", offsetX, offsetY)
        border:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -offsetX, -offsetY)

        local frameLevel = math.max(parent.shadow and (parent.shadow:GetFrameLevel() + 1) or 2,
                                    border.frameLevel or parent:GetFrameLevel() + 1)
        border:SetFrameLevel(frameLevel)

        local frameStrata = border.frameStrata or parent:GetFrameStrata()
        border:SetFrameStrata(frameStrata)
    end
end

local function GetBorderColor(border)
    if not border then
        return
    end

    return border.TopLeft:GetVertexColor()
end

local function SetBorderColor(border, r, g, b, a)
    if not border then
        return
    end

    local parts = {
        border.TopLeft,
        border.TopRight,
        border.BottomLeft,
        border.BottomRight,
        border.Top,
        border.Bottom,
        border.Left,
        border.Right
    }
    for _, part in ipairs(parts) do
        if part then
            part:SetVertexColor(r, g, b, a)
        end
    end
end

local function SetBorderDrawLayer(border, layer, subLevel)
    if not border then
        return
    end

    local parts = {
        border.TopLeft,
        border.TopRight,
        border.BottomLeft,
        border.BottomRight,
        border.Top,
        border.Bottom,
        border.Left,
        border.Right
    }
    for _, part in ipairs(parts) do
        if part then
            part:SetDrawLayer(layer, subLevel)
        end
    end
end

local function CreateBorder(frame, configKey, layer, subLayer)
    if not frame then
        return
    end
    local border = frame:GetBorder()
    if border then
        return border
    end

    layer = layer or "BORDER"
    subLayer = subLayer or 2

    local border = CreateFrame("Frame", nil, frame)
    border.styleConfigKey = configKey or Addon.STYLE_CONFIG_KEYS.DEFAULT
    border.scale = 1

    border.TopLeft = border:CreateTexture(nil, layer, nil, subLayer)
    border.TopRight = border:CreateTexture(nil, layer, nil, subLayer)
    border.BottomLeft = border:CreateTexture(nil, layer, nil, subLayer)
    border.BottomRight = border:CreateTexture(nil, layer, nil, subLayer)
    border.Top = border:CreateTexture(nil, layer, nil, subLayer)
    border.Bottom = border:CreateTexture(nil, layer, nil, subLayer)
    border.Left = border:CreateTexture(nil, layer, nil, subLayer)
    border.Right = border:CreateTexture(nil, layer, nil, subLayer)

    border.TopLeft:SetPoint("TOPLEFT", border, "TOPLEFT")
    border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT")
    border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
    border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
    border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
    border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
    border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
    border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
    border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT")
    border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
    border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
    border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

    -- TODO: if an element overlaying the current element has a shadow, it will overlap this frame's border. Fix that somehow.
    border:SetScript("OnShow", function(self)
        self:Update()
    end)

    if frame.SetBackdropBorderColor then
        frame._SetBackdropBorderColor = frame.SetBackdropBorderColor
        frame.SetBackdropBorderColor = function(self, r, g, b, a)
            local border = self:GetBorder()
            if border then
                border:SetColor(r, g, b, a)
            end
        end
    end

    border.GetColor = GetBorderColor
    border.SetColor = SetBorderColor
    border.SetDrawLayer = SetBorderDrawLayer
    border.Update = UpdateBorder
    border:Update()

    frame.border = border

    return border
end

local function GetBorder(frame)
    if not frame then
        return
    end

    return frame.border or (frame.backdrop and frame.backdrop.border)
end

local function UpdateShadow(shadow, styleConfigKey)
    shadow.styleConfigKey = styleConfigKey or shadow.styleConfigKey

    if not Addon:GetShadowEnabled(shadow.styleConfigKey) or shadow.isHidden then
        shadow:Hide()
    else
        shadow:Show()

        local r, g, b, a = unpack(Addon:GetShadowColor(shadow.styleConfigKey))
        local size = Addon:GetShadowSize(shadow.styleConfigKey) or 5

        if (shadow.size ~= size or not shadow.color or shadow.color[1] ~= r or shadow.color[2] ~= g or shadow.color[3] ~= b or
            shadow.color[4] ~= a) then
            shadow.size = size
            shadow.color = {r, g, b, a}

            shadow:SetBackdrop({edgeFile = LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(2 + size)})
            shadow:SetBackdropBorderColor(r, g, b, a)
        end

        shadow:SetOutside(shadow.anchor, size, size, nil, true)
        shadow:SetFrameLevel(1)
        shadow:SetFrameStrata("BACKGROUND")
    end
end

local function CreateShadow(frame, pass, configKey)
    if not frame then
        return
    end
    if frame.shadow and not pass then
        return frame.shadow
    end

    local shadow = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    shadow.styleConfigKey = configKey or Addon.STYLE_CONFIG_KEYS.DEFAULT

    shadow.GetColor = shadow.GetBackdropBorderColor
    shadow.SetColor = shadow.SetBackdropBorderColor
    shadow.Update = UpdateShadow
    shadow:Update()

    if not pass then
        frame.shadow = shadow
    end

    return shadow
end

local function GetShadow(frame)
    if not frame then
        return
    end

    return frame.shadow or (frame.backdrop and frame.backdrop.shadow)
end

local function UpdateInlay(inlay, styleConfigKey)
    if not inlay then
        return
    end

    inlay.styleConfigKey = styleConfigKey or inlay.styleConfigKey

    local atlas = Addon:GetInlayAtlas(inlay.styleConfigKey)

    if not Addon:GetInlayEnabled(inlay.styleConfigKey) or not atlas or inlay.isHidden then
        inlay:Hide()
    else
        inlay:Show()

        if inlay.atlas ~= atlas then
            inlay.atlas = atlas

            inlay.TopLeft:SetSize(atlas.topLeft[2], atlas.topLeft[3])
            inlay.TopLeft:SetTexture(atlas.topLeft[1])
            inlay.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

            inlay.TopRight:SetSize(atlas.topRight[2], atlas.topRight[3])
            inlay.TopRight:SetTexture(atlas.topRight[1])
            inlay.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

            inlay.BottomLeft:SetSize(atlas.bottomLeft[2], atlas.bottomLeft[3])
            inlay.BottomLeft:SetTexture(atlas.bottomLeft[1])
            inlay.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

            inlay.BottomRight:SetSize(atlas.bottomRight[2], atlas.bottomRight[3])
            inlay.BottomRight:SetTexture(atlas.bottomRight[1])
            inlay.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

            inlay.Top:SetSize(atlas.top[2], atlas.top[3])
            inlay.Top:SetTexture(atlas.top[1], "MIRROR")
            inlay.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])
            inlay.Top:SetHorizTile(atlas.horizontalTiling)

            inlay.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            inlay.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            inlay.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            inlay.Bottom:SetHorizTile(atlas.horizontalTiling)

            inlay.Left:SetSize(atlas.left[2], atlas.left[3])
            inlay.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            inlay.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            inlay.Left:SetVertTile(atlas.verticalTiling)

            inlay.Right:SetSize(atlas.right[2], atlas.right[3])
            inlay.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            inlay.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            inlay.Right:SetVertTile(atlas.verticalTiling)

            inlay.Center:SetSize(atlas.center[2], atlas.center[3])
            inlay.Center:SetTexture(atlas.center[1])
            inlay.Center:SetTexCoord(atlas.center[4], atlas.center[5], atlas.center[6], atlas.center[7])
        end

        local parent = inlay:GetParent()
        local anchor = inlay.anchor or parent
        local offset = Addon:GetInlayOffset(inlay.styleConfigKey) or {0, 0, 0, 0}
        inlay:ClearAllPoints()
        inlay:SetPoint("TOPLEFT", anchor, "TOPLEFT", offset[1], offset[2])
        inlay:SetPoint("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -offset[3], -offset[4])

        local frameLevel = inlay.frameLevel or (parent.border:GetFrameLevel() - 1)
        inlay:SetFrameLevel(frameLevel)

        local frameStrata = inlay.frameStrata or parent:GetFrameStrata()
        inlay:SetFrameStrata(frameStrata)

        local r, g, b, a = unpack(Addon:GetInlayColor(inlay.styleConfigKey) or {1, 1, 1, 0.5})
        inlay:SetColor(r, g, b, a)
    end
end

local function SetInlayColor(inlay, r, g, b, a)
    if not inlay then
        return
    end

    local parts = {
        inlay.TopLeft,
        inlay.TopRight,
        inlay.BottomLeft,
        inlay.BottomRight,
        inlay.Top,
        inlay.Bottom,
        inlay.Left,
        inlay.Right,
        inlay.Center
    }
    for _, part in ipairs(parts) do
        if part then
            part:SetVertexColor(r, g, b, a)
        end
    end
end

local function SetInlayDrawLayer(inlay, layer, subLevel)
    if not inlay then
        return
    end

    local parts = {
        inlay.TopLeft,
        inlay.TopRight,
        inlay.BottomLeft,
        inlay.BottomRight,
        inlay.Top,
        inlay.Bottom,
        inlay.Left,
        inlay.Right,
        inlay.Center
    }
    for _, part in ipairs(parts) do
        if part then
            part:SetDrawLayer(layer, subLevel)
        end
    end
end

local function CreateInlay(frame, configKey, layer, subLayer)
    if not frame then
        return
    end
    if frame.inlay then
        return frame.inlay
    end

    layer = layer or "OVERLAY"
    subLayer = subLayer or 2

    local inlay = CreateFrame("Frame", nil, frame)
    inlay.styleConfigKey = configKey or Addon.STYLE_CONFIG_KEYS.DEFAULT

    inlay.TopLeft = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.TopRight = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.BottomLeft = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.BottomRight = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.Top = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.Bottom = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.Left = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.Right = inlay:CreateTexture(nil, layer, nil, subLayer)
    inlay.Center = inlay:CreateTexture(nil, layer, nil, subLayer)

    inlay.TopLeft:SetPoint("TOPLEFT", inlay, "TOPLEFT")
    inlay.TopRight:SetPoint("TOPRIGHT", inlay, "TOPRIGHT")
    inlay.BottomLeft:SetPoint("BOTTOMLEFT", inlay, "BOTTOMLEFT")
    inlay.BottomRight:SetPoint("BOTTOMRIGHT", inlay, "BOTTOMRIGHT")
    inlay.Top:SetPoint("TOPLEFT", inlay.TopLeft, "TOPRIGHT")
    inlay.Top:SetPoint("TOPRIGHT", inlay.TopRight, "TOPLEFT")
    inlay.Bottom:SetPoint("BOTTOMLEFT", inlay.BottomLeft, "BOTTOMRIGHT")
    inlay.Bottom:SetPoint("BOTTOMRIGHT", inlay.BottomRight, "BOTTOMLEFT")
    inlay.Left:SetPoint("TOPLEFT", inlay.TopLeft, "BOTTOMLEFT")
    inlay.Left:SetPoint("BOTTOMLEFT", inlay.BottomLeft, "TOPLEFT")
    inlay.Right:SetPoint("TOPRIGHT", inlay.TopRight, "BOTTOMRIGHT")
    inlay.Right:SetPoint("BOTTOMRIGHT", inlay.BottomRight, "TOPRIGHT")
    inlay.Center:SetPoint("TOPLEFT", inlay.TopLeft, "BOTTOMRIGHT")
    inlay.Center:SetPoint("BOTTOMRIGHT", inlay.BottomRight, "TOPLEFT")

    inlay.SetColor = SetInlayColor
    inlay.SetDrawLayer = SetInlayDrawLayer
    inlay.Update = UpdateInlay
    inlay:Update()

    frame.inlay = inlay

    return inlay
end

local function GetInlay(frame)
    if not frame then
        return
    end

    return frame.inlay or (frame.backdrop and frame.backdrop.inlay)
end

local function AddApi(object)
    local mt = getmetatable(object).__index
    if not object.Offset then
        mt.Offset = Offset
    end
    if not mt._SetTemplate and mt.SetTemplate ~= SetTemplate then
        mt._SetTemplate = mt.SetTemplate
        mt.SetTemplate = SetTemplate
    end
    if not object.RefreshTemplate then
        mt.RefreshTemplate = RefreshTemplate
    end
    if not object.CreateBorder then
        mt.CreateBorder = CreateBorder
    end
    if not object.GetBorder then
        mt.GetBorder = GetBorder
    end
    if not object.CreateShadow or object.CreateShadow ~= CreateShadow then
        mt.CreateShadow = CreateShadow
    end
    if not object.GetShadow then
        mt.GetShadow = GetShadow
    end
    if not object.CreateInlay then
        mt.CreateInlay = CreateInlay
    end
    if not object.GetInlay then
        mt.GetInlay = GetInlay
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

local AS = AddOnSkins and unpack(AddOnSkins)
if AS then
    AS._SetTemplate = AS.SetTemplate
    AS.SetTemplate = function(self, frame, template)
        template = template or AS:CheckOption("SkinTemplate")

        SetTemplate(frame, template)

        if (template == "MerathilisUI" and AS:CheckAddOn("ElvUI_MerathilisUI")) then
            frame:Styling()
        end
    end

    AS._CreateShadow = AS.CreateShadow
    AS.CreateShadow = E.noop
end
