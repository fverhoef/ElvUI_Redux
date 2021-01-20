local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Artwork = Artwork
local AS = unpack(AddOnSkins)
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")

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
    Artwork:SkinFrame(_G.ColorPickerFrame, true)

    for i = 1, 4 do
        Artwork:SkinFrame(_G["StaticPopup" .. i], true)
    end
    for i = 1, 4 do
        Artwork:SkinFrame(_G["ElvUI_StaticPopup" .. i], true)
    end

    B.BagFrame.Title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.Title:FontTemplate()
    B.BagFrame.Title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.Title:SetText(INVENTORY_TOOLTIP)
    Artwork:SkinFrame(B.BagFrame)

    B.BankFrame.Title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.Title:FontTemplate()
    B.BankFrame.Title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.Title:SetText(BANK)
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
function Artwork:SkinFrame(frame, useThinBorder)
    if not frame then
        return
    end
    if Artwork:IsFrameRegistered(frame) then
        Artwork:UpdateFrame(frame)
        return
    end

    frame.useThinBorder = useThinBorder

    local frameBackground = Artwork:GetFrameBackground()
    local thinBorderAtlas = Artwork:GetThinFrameBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()
    local borderAtlas = frame.useThinBorder and thinBorderAtlas or frameBorderAtlas

    frame.ArtworkBackground = Artwork:CreateBackground(frame, frameBackground)
    frame.Border = Artwork:CreateBorder(frame, borderAtlas)
    Artwork:SkinCloseButton(Artwork:GetCloseButton(frame), closeButtonAtlas)

    Artwork:UpdateFrame(frame)

    Artwork.registry.frames[frame] = true
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local frameBackground = Artwork:GetFrameBackground()
    local thinBorderAtlas = Artwork:GetThinFrameBorderAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    local closeButtonAtlas = Artwork:GetCloseButtonBackgroundAtlas()
    local borderAtlas = frame.useThinBorder and thinBorderAtlas or frameBorderAtlas
    local borderColor = frame.useThinBorder and E.db[addonName].artwork.thinFrameBorderColor or E.db[addonName].artwork.frameBorderColor or {
        1,
        1,
        1
    }

    Artwork:UpdateBackground(frame.ArtworkBackground, frameBackground)
    Artwork:UpdateBorder(frame.Border, borderAtlas)

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        Artwork:EnablePixelBorders(frame)
        frame.Border:Hide()
    else
        Artwork:DisablePixelBorders(frame)
        frame.Border:Show()
    end

    Artwork:UpdateBorderColor(frame.Border, borderColor)
    Artwork:UpdateCloseButton(Artwork:GetCloseButton(frame), closeButtonAtlas)
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
function Artwork:GetCloseButton(frame)
    return frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"]
end

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
    if not frame then
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

    Artwork:UpdateBackground(background, texture)

    return background
end

function Artwork:UpdateBackground(background, texture)
    if not background then
        return
    end

    if not E.db[addonName].artwork.enabled or not texture then
        background:Hide()
    else
        background:Show()
        background.Texture:SetTexture(texture, "MIRROR", "MIRROR")

        local color = E.db[addonName].artwork.frameBackgroundColor or {0, 0, 0, 1}
        background.Texture:SetVertexColor(unpack(color))
    end
end

-- Borders
function Artwork:CreateBorder(frame, atlas, layer)
    layer = layer or "ARTWORK"

    local parent = frame.backdrop or frame
    local border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, layer)
    border.TopRight = border:CreateTexture(nil, layer)
    border.BottomLeft = border:CreateTexture(nil, layer)
    border.BottomRight = border:CreateTexture(nil, layer)
    border.Top = border:CreateTexture(nil, layer)
    border.Bottom = border:CreateTexture(nil, layer)
    border.Left = border:CreateTexture(nil, layer)
    border.Right = border:CreateTexture(nil, layer)

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

    Artwork:UpdateBorder(border, atlas)

    return border
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
            border.Top:SetHorizTile(atlas.horizontalTiling)

            border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.horizontalTiling)

            border.Left:SetSize(atlas.left[2], atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.verticalTiling)

            border.Right:SetSize(atlas.right[2], atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.verticalTiling)
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

function Artwork:UpdateBorderColor(border, color)
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
            part:SetVertexColor(unpack(color))
        end
    end
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

    local borderAtlas = Artwork:GetButtonBorderAtlas()

    button.Border = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateButton(button)

    Artwork.registry.buttons[button] = true
end

function Artwork:UpdateButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetButtonBorderAtlas()

    Artwork:UpdateBorder(button.Border, borderAtlas)
    Artwork:UpdateBorderColor(button.Border, E.db[addonName].artwork.buttonBorderColor)

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        Artwork:EnablePixelBorders(button)
        button.Border:Hide()
    else
        Artwork:DisablePixelBorders(button)
        button.Border:Show()
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

    local atlas = Artwork:GetFrameTabBorderAtlas()

    Artwork:UpdateBorderColor(tab.Border, E.db[addonName].artwork.frameTabBorderColor or {1, 1, 1})

    if not E.db[addonName].artwork.enabled or not atlas then
        Artwork:EnablePixelBorders(tab)
        tab.Border:Hide()

        if tab.originalPoint then
            tab:ClearAllPoints()
            tab:SetPoint(unpack(tab.originalPoint))
        end
    else
        Artwork:DisablePixelBorders(tab)
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
            border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX + (tab.orientation == "RIGHT" and 4 or 0), offsetY - (tab.orientation == "DOWN" and 6 or -4))
            border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX + (tab.orientation == "RIGHT" and 4 or 0), -offsetY - (tab.orientation == "DOWN" and 2 or 4))

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
            border.Top:SetHorizTile(atlas.horizontalTiling)

            border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
            border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
            border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])
            border.Bottom:SetHorizTile(atlas.horizontalTiling)

            border.Left:SetSize(atlas.left[2], atlas.left[3])
            border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
            border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])
            border.Left:SetVertTile(atlas.verticalTiling)

            border.Right:SetSize(atlas.right[2], atlas.right[3])
            border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
            border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])
            border.Right:SetVertTile(atlas.verticalTiling)
        end

        border:SetScale(atlas.scale)

        tab:SetFrameLevel(math.max(0, parent:GetFrameLevel() - 10))
        if tab.backdrop then
            tab.backdrop:SetFrameLevel(math.max(0, tab:GetFrameLevel() - 1))
        end
    end
end

-- Tooltips
function Artwork:SkinTooltip(tip)
    if tip.Border then
        Artwork:UpdateTooltip(tip)
        return
    end

    local borderAtlas = Artwork:GetTooltipBorderAtlas()

    tip.Border = Artwork:CreateBorder(tip, borderAtlas)
    Artwork:UpdateTooltip(tip)
end

function Artwork:UpdateTooltip(tip)
    if not tip.Border then
        return
    end

    local borderAtlas = Artwork:GetTooltipBorderAtlas()

    Artwork:UpdateBorder(tip.Border, borderAtlas)

    local color = E.db[addonName].artwork.tooltipBorderColor
    if tip.GetItem then
        local _, link = tip:GetItem()
        if link then
            local _, _, quality = GetItemInfo(link)
            if quality and quality > 1 then
                color = {GetItemQualityColor(quality)}
            end
        end
    end

    Artwork:UpdateBorderColor(tip.Border, color)

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        Artwork:EnablePixelBorders(tip)
        tip.Border:Hide()
    else
        Artwork:DisablePixelBorders(tip)
        tip.Border:Show()
    end
end

-- Utils
function Artwork:EnablePixelBorders(frame)
    E:TogglePixelBorders(frame, true)
    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    end

    if frame.backdrop then
        Artwork:EnablePixelBorders(frame.backdrop)
    end
end

function Artwork:DisablePixelBorders(frame)
    E:TogglePixelBorders(frame, false)
    if frame.pixelBorders then
        frame.pixelBorders.CENTER:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
        frame.pixelBorders.CENTER:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    end

    if frame.backdrop then
        Artwork:DisablePixelBorders(frame.backdrop)
    end
end

-- ElvUI Hooks
Artwork:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    if Artwork:IsParentFrameRegistered(frame) then
        Artwork:SkinNestedFrame(frame)
    else
        Artwork:SkinFrame(frame)
    end
end)

Artwork:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Artwork:SkinCloseButton(button)
end)

Artwork:SecureHook(S, "HandleButton", function(self, button, strip, isDeclineButton, useCreateBackdrop, noSetTemplate)
    if noSetTemplate then
        return
    end

    Artwork:SkinButton(button)
end)

Artwork:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    Artwork:SkinTab(tab, "DOWN")
end)

Artwork:SecureHook(S, "SetModifiedBackdrop", function(button)
    Artwork:UpdateBorderColor(button.Border, E.db[addonName].artwork.buttonBorderHighlightColor)
end)

Artwork:SecureHook(S, "SetOriginalBackdrop", function(button)
    Artwork:UpdateBorderColor(button.Border, E.db[addonName].artwork.buttonBorderColor)
end)

local function GrabScrollBarElement(frame, elements)
    local frameName = frame:GetName()

    for _, element in ipairs(elements) do
        local part = frame[element] or frameName and (_G[frameName .. element] or strfind(frameName, element)) or nil
        if part then
            return part
        end
    end
end

Artwork:Hook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
    local parent = frame:GetParent()
    local up = GrabScrollBarElement(frame, {"ScrollUpButton", "UpButton", "ScrollUp", "scrollUp"})
    local down = GrabScrollBarElement(frame, {"ScrollDownButton", "DownButton", "ScrollDown", "scrollDown"})
    local thumb = GrabScrollBarElement(frame, {"Thumb"})
    local thumbTexture = GrabScrollBarElement(frame, {"ThumbTexture", "thumbTexture"}) or frame.GetThumbTexture and frame:GetThumbTexture()

    if up then
        up.artworkType = "SCROLL_UP"
    end
    if down then
        down.artworkType = "SCROLL_DOWN"
    end
    if thumb then
        thumb.artworkType = "SCROLL_THUMB"
    end
end)

Artwork:Hook(S, "HandleNextPrevButton", function(self, button, arrowDir, color, noBackdrop, stripTexts)
    button.artworkType = "NEXT_PREV"
end)

Artwork:SecureHook(E, "Config_WindowOpened", function(self)
    local optionsFrame = E:Config_GetWindow()
    if optionsFrame then
        Artwork:SkinFrame(optionsFrame)
    end
end)

Artwork:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Artwork:SkinFrame(frame, true)
end)

Artwork:SecureHook(TT, "SetStyle", function(self, tip)
    Artwork:SkinTooltip(tip)
end)

Artwork:SecureHook(S, "Ace3_StyleTooltip", function(self)
    Artwork:SkinTooltip(self)
end)

-- AddOnSkins Hooks
if AS and false then
    Artwork:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        if Artwork:IsParentFrameRegistered(frame) then
            Artwork:SkinNestedFrame(frame)
        else
            Artwork:SkinFrame(frame)
        end
    end)

    Artwork:SecureHook(AS, "SkinButton", function(self, button, strip)
        Artwork:SkinButton(button)
    end)

    Artwork:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Artwork:SkinCloseButton(button)
    end)

    Artwork:SecureHook(AS, "SkinTooltip", function(self, tooltip, scale)
        Artwork:SkinTooltip(tooltip)
    end)
end

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Artwork:SkinTooltip(self)
    end)
end
