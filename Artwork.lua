local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Artwork = Artwork
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")
local S = E:GetModule("Skins")

-- Registry
Artwork.registry = {frames = {}, nestedFrames = {}, buttons = {}, tabs = {}}

function Artwork:IsFrameRegistered(frame)
    return Artwork.registry.frames[frame] or Artwork.registry.nestedFrames[frame] or false
end

function Artwork:IsParentFrameRegistered(frame)
    local parent = frame:GetParent()
    while parent do
        if Artwork.registry.frames[parent] then
            return true
        end

        parent = parent:GetParent()
    end

    return false
end

function Artwork:IsButtonRegistered(button)
    return Artwork.registry.buttons[button] or false
end

function Artwork:IsTabRegistered(tab)
    return Artwork.registry.tabs[tab] or false
end

-- Init/Update
function Artwork:Initialize()
    Artwork:ScheduleTimer("UpdateArtwork", 1)

    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    Artwork:SkinFrame(_G.GameMenuFrame)
    Artwork:SkinFrame(_G.InterfaceOptionsFrame)
    Artwork:SkinFrame(_G.VideoOptionsFrame)
    Artwork:SkinFrame(_G.ScriptErrorsFrame)
    Artwork:SkinFrame(_G.StackSplitFrame, true)
    Artwork:SkinFrame(_G.LootFrame, true)
    Artwork:SkinFrame(_G.LootHistoryFrame, true)
    Artwork:SkinFrame(_G.MasterLooterFrame, true)
    Artwork:SkinFrame(_G.ReadyCheckFrame, true)
    Artwork:SkinFrame(_G.WorldMapFrame)
    for i = 1, 4 do
        Artwork:SkinFrame(_G["StaticPopup" .. i], true)
    end
    for i = 1, 4 do
        Artwork:SkinFrame(_G["ElvUI_StaticPopup" .. i], true)
    end
    Artwork:SkinFrame(B.BagFrame)
    Artwork:SkinFrame(B.BankFrame)

    -- skin any tab that isn't handled by overriding Skins.HandleTab
    for i = 1, _G.MAX_SKILLLINE_TABS do
        local tab = _G["SpellBookSkillLineTab" .. i]
        Artwork:SkinTab(tab, "RIGHT")
    end
end

function Artwork:UpdateArtwork()
    for frame, _ in pairs(Artwork.registry.frames) do
        Artwork:UpdateFrame(frame)
    end

    for frame, _ in pairs(Artwork.registry.nestedFrames) do
        Artwork:UpdateNestedFrame(frame)
    end

    for button, _ in pairs(Artwork.registry.buttons) do
        Artwork:UpdateButton(button)
    end

    for tab, _ in pairs(Artwork.registry.tabs) do
        Artwork:UpdateTab(tab)
    end
end

-- Frames
function Artwork:SkinFrame(frame, useNormalBorder)
    if not frame then
        return
    end
    if Artwork:IsFrameRegistered(frame) then
        Artwork:UpdateFrame(frame)
        return
    end

    frame.useNormalBorder = useNormalBorder

    local frameBackground = Artwork:GetFrameBackground()
    local normalBorderAtlas = Artwork:GetNormalBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()

    Artwork:CreateBackground(frame, frameBackground)
    Artwork:CreateBorder(frame, frame.useNormalBorder and normalBorderAtlas or frameBorderAtlas)
    Artwork:SkinCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], closeButtonAtlas)

    Artwork.registry.frames[frame] = true
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local frameBackground = Artwork:GetFrameBackground()
    local normalBorderAtlas = Artwork:GetNormalBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()

    Artwork:UpdateBackground(frame, frameBackground)
    Artwork:UpdateBorder(frame.Border, frame.useNormalBorder and normalBorderAtlas or frameBorderAtlas)
    Artwork:UpdateCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], closeButtonAtlas)
end

function Artwork:SkinNestedFrame(frame)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    Artwork.registry.nestedFrames[frame] = true
end

function Artwork:UpdateNestedFrame(frame)
    if not frame then
        return
    end
end

-- Frame Close Buttons
function Artwork:SkinCloseButton(button, backgroundAtlas)
    if button and not button.Background then
        if not backgroundAtlas then
            backgroundAtlas = Artwork:GetCloseButtonBackgroundAtlas()
        end

        button.Background = button:CreateTexture(nil, "ARTWORK")
        button.Background:SetAllPoints(button)
        Artwork:UpdateCloseButton(button, backgroundAtlas)
    end
end

function Artwork:UpdateCloseButton(button, backgroundAtlas)
    local background = button and button.Background
    if background then
        if not E.db[addonName].artwork.enabled or not backgroundAtlas then
            background:Hide()
        else
            background:Show()

            local texture = backgroundAtlas and backgroundAtlas[1]
            background:SetTexture(texture)
            if texture then
                background:SetTexCoord(backgroundAtlas[4], backgroundAtlas[5], backgroundAtlas[6], backgroundAtlas[7])
            end
        end
    end
end

-- Backgrounds
function Artwork:CreateBackground(frame, texture)
    if frame.ArtworkBackground then
        return
    end

    local parent = frame.backdrop or frame
    local background = CreateFrame("Frame", nil, parent)
    background:SetFrameLevel(math.max(0, parent:GetFrameLevel() - 1))
    background:SetAllPoints(parent)
    background.Texture = background:CreateTexture(nil, "BACKGROUND")
    background.Texture:SetHorizTile(true)
    background.Texture:SetVertTile(true)
    background.Texture:SetAllPoints(background)

    frame.ArtworkBackground = background

    Artwork:UpdateBackground(background, texture)
end

function Artwork:UpdateBackground(frame, texture)
    local background = frame.ArtworkBackground
    if not background then
        return
    end

    if not E.db[addonName].artwork.enabled or not texture then
        background:Hide()
    else
        background:Show()
        background.Texture:SetTexture(texture, "MIRROR", "MIRROR")

        local color = E.db[addonName].artwork.frameBackgroundColor or {r = 0, g = 0, b = 0, a = 1}
        background.Texture:SetVertexColor(color.r, color.g, color.b, color.a)
    end
end

-- Borders
function Artwork:CreateBorder(frame, atlas)
    if frame.Border then
        return
    end

    local parent = frame.backdrop or frame
    local border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, "ARTWORK")
    border.TopRight = border:CreateTexture(nil, "ARTWORK")
    border.BottomLeft = border:CreateTexture(nil, "ARTWORK")
    border.BottomRight = border:CreateTexture(nil, "ARTWORK")
    border.Top = border:CreateTexture(nil, "ARTWORK")
    border.Bottom = border:CreateTexture(nil, "ARTWORK")
    border.Left = border:CreateTexture(nil, "ARTWORK")
    border.Right = border:CreateTexture(nil, "ARTWORK")

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

    border:SetScript("OnShow", function(self)
        Artwork:UpdateBorderScale(self, atlas)
    end)

    frame.Border = border

    Artwork:UpdateBorder(frame.Border, atlas)
end

function Artwork:UpdateBorder(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        border:Hide()
    else
        border:Show()

        if border.atlas ~= atlas then
            border.atlas = atlas

            local parent = border:GetParent()
            local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
            border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX, offsetY)
            border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX, -offsetY)

            border.TopLeft:SetSize(atlas.topLeft[2], atlas.topLeft[3])
            border.TopLeft:SetTexture(atlas.topLeft[1])
            border.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

            border.TopRight:SetSize(atlas.topRight[2], atlas.topRight[3])
            border.TopRight:SetTexture(atlas.topRight[1])
            border.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

            border.BottomLeft:SetSize(atlas.bottomLeft[2], atlas.bottomLeft[3])
            border.BottomLeft:SetTexture(atlas.bottomLeft[1])
            border.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

            border.BottomRight:SetSize(atlas.bottomRight[2], atlas.bottomRight[3])
            border.BottomRight:SetTexture(atlas.bottomRight[1])
            border.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

            border.Top:SetSize(atlas.top[2], atlas.top[3])
            border.Top:SetTexture(atlas.top[1], "MIRROR")
            border.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])
            border.Top:SetHorizTile(atlas.top[4] == 0)

            border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.bottom[4] == 0)

            border.Left:SetSize(atlas.left[2], atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.left[6] == 0)

            border.Right:SetSize(atlas.right[2], atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.right[6] == 0)
        end

        Artwork:UpdateBorderScale(border, atlas)
    end
end

function Artwork:UpdateBorderScale(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        return
    end

    local parent = border:GetParent()
    local scale = atlas.scale
    local minWidth = atlas.topLeft[2] + atlas.topRight[2]
    local minHeight = atlas.topLeft[3] + atlas.bottomLeft[3]

    local parentWidth, parentHeight = parent:GetSize()
    if parentWidth > 0 and parentWidth < (scale * minWidth) then
        scale = parentWidth / minWidth
    end
    if parentHeight > 0 and parentHeight < (scale * minHeight) then
        scale = parentHeight / minHeight
    end
    border:SetScale(scale)
end

-- Buttons
function Artwork:SkinButton(button)
    if not button then
        return
    end
    if Artwork:IsButtonRegistered(button) then
        Artwork:UpdateButton(button)
        return
    end

    button.ArtworkLeft = button:CreateTexture(nil, "BACKGROUND")
    button.ArtworkRight = button:CreateTexture(nil, "BACKGROUND")
    button.ArtworkCenter = button:CreateTexture(nil, "BACKGROUND")

    button.ArtworkLeftHighlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.ArtworkRightHighlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.ArtworkCenterHighlight = button:CreateTexture(nil, "HIGHLIGHT")

    button:HookScript("OnMouseDown", function()
    end)

    button:HookScript("OnMouseUp", function()
    end)

    Artwork:UpdateButton(button)

    Artwork.registry.buttons[button] = true
end

function Artwork:UpdateButton(button)
    if not button then
        return
    end

    local atlas = Artwork.atlas.buttons[E.db[addonName].artwork.buttonTheme]

    if not E.db[addonName].artwork.enabled or not atlas then
        E:TogglePixelBorders(button, true)

        button.ArtworkLeft:Hide()
        button.ArtworkCenter:Hide()
        button.ArtworkRight:Hide()
        button.ArtworkLeftHighlight:Hide()
        button.ArtworkCenterHighlight:Hide()
        button.ArtworkRightHighlight:Hide()
    else
        local offsetX, offsetY = unpack(atlas.offset)
        E:TogglePixelBorders(button, false)

        button.ArtworkLeft:Show()
        button.ArtworkLeft:SetWidth(atlas.leftWidth)
        button.ArtworkLeft:SetPoint("TOPLEFT", button, "TOPLEFT", offsetX, offsetY)
        button.ArtworkLeft:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", offsetX, -1 * offsetY)
        button.ArtworkLeft:SetTexture(atlas.left[1])
        button.ArtworkLeft:SetTexCoord(atlas.left[2], atlas.left[3], atlas.left[4], atlas.left[5])

        button.ArtworkRight:Show()
        button.ArtworkRight:SetWidth(atlas.rightWidth)
        button.ArtworkRight:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1 * offsetX, offsetY)
        button.ArtworkRight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1 * offsetX, -1 * offsetY)
        button.ArtworkRight:SetTexture(atlas.right[1])
        button.ArtworkRight:SetTexCoord(atlas.right[2], atlas.right[3], atlas.right[4], atlas.right[5])

        button.ArtworkCenter:Show()
        button.ArtworkCenter:SetPoint("TOPLEFT", button.ArtworkLeft, "TOPRIGHT")
        button.ArtworkCenter:SetPoint("BOTTOMRIGHT", button.ArtworkRight, "BOTTOMLEFT")
        button.ArtworkCenter:SetTexture(atlas.center[1])
        button.ArtworkCenter:SetTexCoord(atlas.center[2], atlas.center[3], atlas.center[4], atlas.center[5])

        if atlas.leftHighlight then
            button.ArtworkLeftHighlight:Show()
            button.ArtworkLeftHighlight:SetWidth(atlas.leftWidth)
            button.ArtworkLeftHighlight:SetPoint("TOPLEFT", button, "TOPLEFT", offsetX, offsetY)
            button.ArtworkLeftHighlight:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", offsetX, -1 * offsetY)
            button.ArtworkLeftHighlight:SetTexture(atlas.leftHighlight[1])
            button.ArtworkLeftHighlight:SetTexCoord(atlas.leftHighlight[2], atlas.leftHighlight[3], atlas.leftHighlight[4], atlas.leftHighlight[5])

            button.ArtworkRightHighlight:Show()
            button.ArtworkRightHighlight:SetWidth(atlas.rightWidth)
            button.ArtworkRightHighlight:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1 * offsetX, offsetY)
            button.ArtworkRightHighlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1 * offsetX, -1 * offsetY)
            button.ArtworkRightHighlight:SetTexture(atlas.rightHighlight[1])
            button.ArtworkRightHighlight:SetTexCoord(atlas.rightHighlight[2], atlas.rightHighlight[3], atlas.rightHighlight[4], atlas.rightHighlight[5])

            button.ArtworkCenterHighlight:Show()
            button.ArtworkCenterHighlight:SetPoint("TOPLEFT", button.ArtworkLeftHighlight, "TOPRIGHT")
            button.ArtworkCenterHighlight:SetPoint("BOTTOMRIGHT", button.ArtworkRightHighlight, "BOTTOMLEFT")
            button.ArtworkCenterHighlight:SetTexture(atlas.centerHighlight[1])
            button.ArtworkCenterHighlight:SetTexCoord(atlas.centerHighlight[2], atlas.centerHighlight[3], atlas.centerHighlight[4], atlas.centerHighlight[5])
        else
            button.ArtworkLeftHighlight:SetTexture()
            button.ArtworkCenterHighlight:SetTexture()
            button.ArtworkRightHighlight:SetTexture()
        end
    end
end

-- Tabs
function Artwork:SkinTab(tab, orientation)
    if not tab then
        return
    end
    if Artwork:IsTabRegistered(tab) then
        Artwork:UpdateTab(tab)
        return
    end

    tab.orientation = orientation
    tab.originalPoint = {tab:GetPoint()}

    local parent = tab.backdrop or tab
    local border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, "ARTWORK")
    border.TopRight = border:CreateTexture(nil, "ARTWORK")
    border.BottomLeft = border:CreateTexture(nil, "ARTWORK")
    border.BottomRight = border:CreateTexture(nil, "ARTWORK")
    border.Top = border:CreateTexture(nil, "ARTWORK")
    border.Bottom = border:CreateTexture(nil, "ARTWORK")
    border.Left = border:CreateTexture(nil, "ARTWORK")
    border.Right = border:CreateTexture(nil, "ARTWORK")

    if orientation == "DOWN" then
        border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Left:SetPoint("TOPLEFT", border, "TOPLEFT")
        border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
        border.Right:SetPoint("TOPRIGHT", border, "TOPRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()
    elseif orientation == "RIGHT" then
        border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT")
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
        border.Top:SetPoint("TOPLEFT", border, "TOPLEFT")
        border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
        border.Bottom:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

        border.Left:Hide()
        border.TopLeft:Hide()
        border.BottomLeft:Hide()
    end

    tab.Border = border

    Artwork:UpdateTab(tab)

    Artwork.registry.tabs[tab] = true
end

function Artwork:UpdateTab(tab)
    if not tab or not tab.Border then
        return
    end

    local atlas = Artwork:GetNormalBorderAtlas()

    if not E.db[addonName].artwork.enabled or not atlas then
        E:TogglePixelBorders(tab, true)
        tab.Border:Hide()

        if tab.originalPoint then
            tab:ClearAllPoints()
            tab:SetPoint(unpack(tab.originalPoint))
        end
    else
        E:TogglePixelBorders(tab, false)
        tab.Border:Show()

        if tab.originalPoint[2] == tab:GetParent() then
            local frameBorderAtlas = Artwork:GetFrameBorderAtlas()

            tab:ClearAllPoints()
            if frameBorderAtlas and tab.orientation == "DOWN" then
                tab:SetPoint(tab.originalPoint[1], tab.originalPoint[2], tab.originalPoint[3], tab.originalPoint[4],
                             tab.originalPoint[5] - frameBorderAtlas.scale * frameBorderAtlas.offset[2] + 3)
            elseif frameBorderAtlas and tab.orientation == "RIGHT" then
                tab:SetPoint(tab.originalPoint[1], tab.originalPoint[2], tab.originalPoint[3], tab.originalPoint[4] - frameBorderAtlas.scale * frameBorderAtlas.offset[1] - 3,
                             tab.originalPoint[5])
            else
                tab:SetPoint(unpack(tab.originalPoint))
            end
        end

        local parent = tab.backdrop or tab
        local border = tab.Border

        if tab.atlas ~= atlas then
            tab.atlas = atlas

            local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
            border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX + (tab.orientation == "RIGHT" and 10 or 0), offsetY - (tab.orientation == "DOWN" and 10 or 0))
            border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX, -offsetY)

            border.TopLeft:SetSize(atlas.topLeft[2], atlas.topLeft[3])
            border.TopLeft:SetTexture(atlas.topLeft[1])
            border.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

            border.TopRight:SetSize(atlas.topRight[2], atlas.topRight[3])
            border.TopRight:SetTexture(atlas.topRight[1])
            border.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

            border.BottomLeft:SetSize(atlas.bottomLeft[2], atlas.bottomLeft[3])
            border.BottomLeft:SetTexture(atlas.bottomLeft[1])
            border.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

            border.BottomRight:SetSize(atlas.bottomRight[2], atlas.bottomRight[3])
            border.BottomRight:SetTexture(atlas.bottomRight[1])
            border.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

            border.Top:SetSize(atlas.top[2], atlas.top[3])
            border.Top:SetTexture(atlas.top[1], "MIRROR")
            border.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])
            border.Top:SetHorizTile(atlas.top[4] == 0)

            border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.bottom[4] == 0)

            border.Left:SetSize(atlas.left[2], atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.left[6] == 0)

            border.Right:SetSize(atlas.right[2], atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.right[6] == 0)
        end

        border:SetScale(atlas.scale)

        tab:SetFrameLevel(math.max(0, parent:GetFrameLevel() - 10))
        if tab.backdrop then
            tab.backdrop:SetFrameLevel(math.max(0, tab:GetFrameLevel() - 1))
        end
    end
end

-- ElvUI Overrides
local originalHandleFrame = S.HandleFrame
S.HandleFrame = function(...)
    originalHandleFrame(...)

    local _, frame, setBackdrop, template, x1, y1, x2, y2 = ...
    if Artwork:IsParentFrameRegistered(frame) then
        Artwork:SkinNestedFrame(frame)
    else
        Artwork:SkinFrame(frame)
    end
end

local originalHandleCloseButton = S.HandleCloseButton
S.HandleCloseButton = function(...)
    originalHandleCloseButton(...)

    local _, f, point, x, y = ...
    Artwork:SkinCloseButton(f)
end

local originalHandleButton = S.HandleButton
S.HandleButton = function(...)
    originalHandleButton(...)

    local _, button, strip, isDeclineButton, useCreateBackdrop, noSetTemplate = ...

    if strip then
        return
    end
    if button.artworkType == "SCROLL_UP" or button.artworkType == "SCROLL_DOWN" or button.artworkType == "NEXT_PREV" then
        return
    end

    Artwork:SkinButton(button)
end

local originalHandleTab = S.HandleTab
S.HandleTab = function(...)
    originalHandleTab(...)

    local _, tab, noBackdrop = ...
    Artwork:SkinTab(tab, "DOWN")
end

local originalHandleScrollBar = S.HandleScrollBar
S.HandleScrollBar = function(...)
    local function GrabScrollBarElement(frame, element)
        local FrameName = frame:GetName()
        return frame[element] or FrameName and (_G[FrameName .. element] or strfind(FrameName, element)) or nil
    end

    local _, frame, thumbTrimY, thumbTrimX = ...

    local parent = frame:GetParent()
    local ScrollUpButton = GrabScrollBarElement(frame, "ScrollUpButton") or GrabScrollBarElement(frame, "UpButton") or GrabScrollBarElement(frame, "ScrollUp") or
                               GrabScrollBarElement(parent, "scrollUp")
    local ScrollDownButton = GrabScrollBarElement(frame, "ScrollDownButton") or GrabScrollBarElement(frame, "DownButton") or GrabScrollBarElement(frame, "ScrollDown") or
                                 GrabScrollBarElement(parent, "scrollDown")
    local Thumb = GrabScrollBarElement(frame, "ThumbTexture") or GrabScrollBarElement(frame, "thumbTexture") or frame.GetThumbTexture and frame:GetThumbTexture()

    ScrollUpButton.artworkType = "SCROLL_UP"
    ScrollDownButton.artworkType = "SCROLL_DOWN"
    Thumb.artworkType = "SCROLL_THUMB"

    originalHandleScrollBar(...)
end

local originalHandleNextPrevButton = S.HandleNextPrevButton
S.HandleNextPrevButton = function(...)
    local _, btn, arrowDir, color, noBackdrop, stripTexts = ...
    btn.artworkType = "NEXT_PREV"

    originalHandleNextPrevButton(...)
end

local originalConfig_WindowOpened = E.Config_WindowOpened
E.Config_WindowOpened = function(...)
    originalConfig_WindowOpened(...)

    local optionsFrame = E:Config_GetWindow()
    if optionsFrame then
        Artwork:SkinFrame(optionsFrame)
    end
end

local originalStaticPopupSpecial_Show = E.StaticPopupSpecial_Show
E.StaticPopupSpecial_Show = function(...)
    originalStaticPopupSpecial_Show(...)

    local _, frame = ...
    Artwork:SkinFrame(frame, true)
end
