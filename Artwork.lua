local addonName, addonTable = ...
local Module = addonTable[1]
local Artwork = Module:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.Artwork = Artwork
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

Artwork.atlas = {
    buttons = {
        ["Red"] = {
            offset = {-3, 3},
            leftWidth = 73,
            rightWidth = 28,

            left = {Module.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.254395, 0.316895},
            right = {Module.media.textures.buttons.redButton, 0.25390625, 0.474609375, 0.444824, 0.507324},
            center = {Module.media.textures.buttons.redButton, 0, 0.125, 0.000488281, 0.0629883},

            leftDisabled = {Module.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.317871, 0.380371},
            rightDisabled = {Module.media.textures.buttons.redButton, 0.48140900, 0.701171875, 0.444824, 0.507324},
            centerDisabled = {Module.media.textures.buttons.redButton, 0, 0.125, 0.0639648, 0.126465},

            leftPressed = {Module.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.381348, 0.443848},
            rightPressed = {Module.media.textures.buttons.redButton, 0.255859, 0.478516, 0.444824, 0.507324},
            centerPressed = {Module.media.textures.buttons.redButton, 0, 0.125, 0.127441, 0.189941}
        },
        ["Silver"] = {
            offset = {-1, 1},
            leftWidth = 10,
            rightWidth = 10,

            left = {Module.media.textures.buttons.silverButton_Left_Up, 0, 12 / 32, 0, 0.734375},
            right = {Module.media.textures.buttons.silverButton_Right_Up, 20 / 32, 1, 0, 0.734375},
            center = {Module.media.textures.buttons.silverButton_Mid_Up, 0, 1, 0, 0.734375},

            leftPressed = {Module.media.textures.buttons.silverButton_Left_Down, 0, 12 / 32, 0, 0.734375},
            rightPressed = {Module.media.textures.buttons.silverButton_Right_Down, 20 / 32, 1, 0, 0.734375},
            centerPressed = {Module.media.textures.buttons.silverButton_Mid_Down, 0, 1, 0, 0.734375},

            leftHighlight = {Module.media.textures.buttons.silverButton_Left_Hi, 0, 12 / 32, 0, 0.734375},
            rightHighlight = {Module.media.textures.buttons.silverButton_Right_Hi, 20 / 32, 1, 0, 0.734375},
            centerHighlight = {Module.media.textures.buttons.silverButton_Mid_Hi, 0, 1, 0, 0.734375}
        }
    },
    frames = {
        ["Alliance"] = {
            size = {84, 84},
            offset = {-12, 12},
            topLeft = {Module.media.textures.frames.alliance, 0.000976562, 0.163086, 0.579102, 0.741211},
            topRight = {Module.media.textures.frames.alliance, 0.163086, 0.000976562, 0.579102, 0.741211},
            bottomLeft = {Module.media.textures.frames.alliance, 0.000976562, 0.163086, 0.741211, 0.579102},
            bottomRight = {Module.media.textures.frames.alliance, 0.163086, 0.000976562, 0.741211, 0.579102},
            top = {Module.media.textures.frames.alliance, 0, 0.25, 0.0322266, 0.0615234, nil, 15},
            bottom = {Module.media.textures.frames.alliance, 0, 0.25, 0.000976562, 0.0302734, nil, 15},
            left = {Module.media.textures.frames.allianceVertical, 0.015625, 0.484375, 0, 1, 15},
            right = {Module.media.textures.frames.allianceVertical, 0.515625, 0.984375, 0, 1, 15},
            closeButtonBackground = {Module.media.textures.frames.alliance, 0.165039, 0.197266, 0.579102, 0.610352, 33, 32}
        },
        ["Horde"] = {
            size = {84, 84},
            offset = {-12, 12},
            topLeft = {Module.media.textures.frames.horde, 0.000976562, 0.163086, 0.783203, 0.945312},
            topRight = {Module.media.textures.frames.horde, 0.163086, 0.000976562, 0.783203, 0.945312},
            bottomLeft = {Module.media.textures.frames.horde, 0.000976562, 0.163086, 0.945312, 0.783203},
            bottomRight = {Module.media.textures.frames.horde, 0.163086, 0.000976562, 0.945312, 0.783203},
            top = {Module.media.textures.frames.horde, 0, 0.25, 0.117188, 0.146484, nil, 15},
            bottom = {Module.media.textures.frames.horde, 0, 0.25, 0.0859375, 0.115234, nil, 15},
            left = {Module.media.textures.frames.hordeVertical, 0.015625, 0.484375, 0, 1, 15},
            right = {Module.media.textures.frames.hordeVertical, 0.515625, 0.984375, 0, 1, 15},
            closeButtonBackground = {Module.media.textures.frames.horde, 0.833984, 0.866211, 0.148438, 0.179688, 33, 32}
        },
        ["Metal"] = {
            size = {84, 84},
            offset = {-12, 12},
            topLeft = {Module.media.textures.frames.metal, 0.00390625, 0.652344, 0.253906, 0.902344},
            topRight = {Module.media.textures.frames.metal, 0.652344, 0.00390625, 0.253906, 0.902344},
            bottomLeft = {Module.media.textures.frames.metal, 0.00390625, 0.652344, 0.902344, 0.253906},
            bottomRight = {Module.media.textures.frames.metal, 0.652344, 0.00390625, 0.902344, 0.253906},
            top = {Module.media.textures.frames.metal, 0, 1, 0.128906, 0.246094, nil, 15},
            bottom = {Module.media.textures.frames.metal, 0, 1, 0.00390625, 0.121094, nil, 15},
            left = {Module.media.textures.frames.metalVertical, 0.015625, 0.484375, 0, 1, 15},
            right = {Module.media.textures.frames.metalVertical, 0.515625, 0.984375, 0, 1, 15},
            closeButtonBackground = {Module.media.textures.frames.metal, 0.660156, 0.789062, 0.253906, 0.378906, 33, 32}
        }
    },
    nestedFrames = {}
}

-- Registry
Artwork.registry = {frames = {}, nestedFrames = {}, buttons = {}}

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

-- Init/Update
function Artwork:Initialize()
    Artwork:ScheduleTimer("UpdateArtwork", 1)

    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    Artwork:SkinFrame(_G.GameMenuFrame)
    Artwork:SkinFrame(_G.InterfaceOptionsFrame)
    Artwork:SkinFrame(_G.VideoOptionsFrame)
    Artwork:SkinFrame(_G.ScriptErrorsFrame)
    Artwork:SkinFrame(_G.StackSplitFrame)
    Artwork:SkinFrame(_G.LootFrame)
    Artwork:SkinFrame(_G.LootHistoryFrame)
    Artwork:SkinFrame(_G.MasterLooterFrame)
    Artwork:SkinFrame(_G.ReadyCheckFrame)
    for i = 1, 4 do
        Artwork:SkinFrame(_G["StaticPopup" .. i])
    end
    for i = 1, 4 do
        Artwork:SkinFrame(_G["ElvUI_StaticPopup" .. i])
    end

    if not E.hookedArtwork then
        hooksecurefunc(E, "Config_WindowOpened", function()
            local optionsFrame = E:Config_GetWindow()
            if optionsFrame then
                Artwork:SkinFrame(optionsFrame)
            end
        end)

        -- ElvUI Popups
        hooksecurefunc(E, "StaticPopupSpecial_Show", function(self, frame)
            Artwork:SkinFrame(frame)
        end)

        E.hookedArtwork = true
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
end

-- Frames
function Artwork:SkinFrame(frame)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    local atlas = Artwork.atlas.frames[E.db[addonName].artwork.frameTheme]

    Artwork:CreateBorder(frame, atlas)
    Artwork:SkinCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], atlas)

    Artwork.registry.frames[frame] = true
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local atlas = Artwork.atlas.frames[E.db[addonName].artwork.frameTheme]

    Artwork:UpdateBorder(frame.Border, atlas)
    Artwork:UpdateCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], atlas)
end

function Artwork:SkinNestedFrame(frame)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    local atlas = Artwork.atlas.nestedFrames[E.db[addonName].artwork.frameTheme]

    Artwork.registry.nestedFrames[frame] = true
end

function Artwork:UpdateNestedFrame(frame)
    if not frame then
        return
    end

    local atlas = Artwork.atlas.nestedFrames[E.db[addonName].artwork.frameTheme]
end

-- Frame Close Buttons
function Artwork:SkinCloseButton(closeButton, atlas)
    if closeButton then
        closeButton.Background = closeButton:CreateTexture(nil, "ARTWORK")
        closeButton.Background:SetAllPoints(closeButton)
        Artwork:UpdateCloseButton(closeButton, atlas)
    end
end

function Artwork:UpdateCloseButton(closeButton, atlas)
    local background = closeButton and closeButton.Background
    if background then
        if not E.db[addonName].artwork.enabled or not atlas then
            background:Hide()
        else
            background:Show()

            local texture = atlas.closeButtonBackground and atlas.closeButtonBackground[1]
            background:SetTexture(texture)
            if texture then
                background:SetTexCoord(atlas.closeButtonBackground[2], atlas.closeButtonBackground[3], atlas.closeButtonBackground[4], atlas.closeButtonBackground[5])
            end
        end
    end
end

-- Borders
function Artwork:CreateBorder(frame, atlas)
    if frame.Border then
        return
    end

    -- TODO: handle situation where size is outside frame size
    local parent = frame.backdrop or frame
    frame.Border = CreateFrame("Frame", nil, parent)
    frame.Border:SetAllPoints(parent)

    frame.Border.TopLeft = Artwork:CreateBorderPart(frame.Border, atlas and atlas.topLeft)
    frame.Border.TopRight = Artwork:CreateBorderPart(frame.Border, atlas and atlas.topRight)
    frame.Border.BottomLeft = Artwork:CreateBorderPart(frame.Border, atlas and atlas.bottomLeft)
    frame.Border.BottomRight = Artwork:CreateBorderPart(frame.Border, atlas and atlas.bottomRight)
    frame.Border.Top = Artwork:CreateBorderPart(frame.Border, atlas and atlas.top)
    frame.Border.Bottom = Artwork:CreateBorderPart(frame.Border, atlas and atlas.bottom)
    frame.Border.Left = Artwork:CreateBorderPart(frame.Border, atlas and atlas.left)
    frame.Border.Right = Artwork:CreateBorderPart(frame.Border, atlas and atlas.right)

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
        local width, height = unpack(atlas.size)
        local offsetX, offsetY = unpack(atlas.offset)

        Artwork:UpdateBorderPart(border.TopLeft, atlas.topLeft)
        border.TopLeft:SetPoint("TOPLEFT", border, offsetX, offsetY)
        border.TopLeft:SetSize(width, height)

        Artwork:UpdateBorderPart(border.TopRight, atlas.topRight)
        border.TopRight:SetPoint("TOPRIGHT", border, -1 * offsetX, offsetY)
        border.TopRight:SetSize(width, height)

        Artwork:UpdateBorderPart(border.BottomLeft, atlas.bottomLeft)
        border.BottomLeft:SetPoint("BOTTOMLEFT", border, offsetX, -1 * offsetY)
        border.BottomLeft:SetSize(width, height)

        Artwork:UpdateBorderPart(border.BottomRight, atlas.bottomRight)
        border.BottomRight:SetPoint("BOTTOMRIGHT", border, -1 * offsetX, -1 * offsetY)
        border.BottomRight:SetSize(width, height)

        Artwork:UpdateBorderPart(border.Top, atlas.top)
        border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
        border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
        border.Top:SetHeight(atlas.top[7] or height)

        Artwork:UpdateBorderPart(border.Bottom, atlas.bottom)
        border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
        border.Bottom:SetHeight(atlas.bottom[7] or height)

        Artwork:UpdateBorderPart(border.Left, atlas.left)
        border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT")
        border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
        border.Left:SetWidth(atlas.left[6] or width)

        Artwork:UpdateBorderPart(border.Right, atlas.right)
        border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
        border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")
        border.Right:SetWidth(atlas.right[6] or width)
    end
end

function Artwork:CreateBorderPart(border, atlas)
    local part = border:CreateTexture(nil, "ARTWORK")
    part:SetParent(border)
    Artwork:UpdateBorderPart(part, atlas)

    return part
end

function Artwork:UpdateBorderPart(part, atlas)
    if atlas then
        part:SetTexture(atlas[1])
        part:SetTexCoord(atlas[2], atlas[3], atlas[4], atlas[5])
    end
end

-- Buttons
function Artwork:SkinButton(button)
    if not button and not Artwork:IsButtonRegistered(button) then
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
