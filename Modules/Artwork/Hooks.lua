local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)
local AS = unpack(AddOnSkins)
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local DT = E:GetModule("DataTexts")
local NP = E:GetModule("NamePlates")
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")
local UF = E:GetModule("UnitFrames")

-- ElvUI Hooks
Artwork:SecureHook(E, "SetBackdropBorderColor", function(self, frame, r, g, b, a)
    if Artwork:IsItemButtonRegistered(frame) then
        Artwork:UpdateBorderColor(frame.ArtworkBorder, {r, g, b, a})
    end
end)

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
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.buttonBorderHighlightColor)
end)

Artwork:SecureHook(S, "SetOriginalBackdrop", function(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.buttonBorderColor)
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

Artwork:SecureHook(S, "HandleItemButton", function(self, button, shrinkIcon)
    Artwork:SkinItemButton(button)
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

Artwork:SecureHook(A, "UpdateAura", function(self, button, index)
    Artwork:SkinAura(button)
end)

Artwork:SecureHook(A, "UpdateTempEnchant", function(self, button, index)
    Artwork:SkinTempEnchant(button)
end)

Artwork:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    if useMasque then
        return
    end
    Artwork:SkinActionButton(button)
end)

Artwork:SecureHook(B, "UpdateSlot", function(self, frame, bagID, slotID)
    if frame and frame.Bags[bagID] then
        Artwork:SkinBagButton(frame.Bags[bagID][slotID])
    end
end)

Artwork:SecureHook(B, "SkinBag", function(self, bag)
    Artwork:SkinItemButton(bag)
end)

Artwork:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Artwork:SkinDataPanel(panel)
end)

Artwork:SecureHook(NP, "StylePlate", function(self, nameplate)
    Artwork:SkinNamePlate(nameplate)
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

-- Lib Hooks
local libDBIcon = LibStub("LibDBIcon-1.0", true)
if libDBIcon and libDBIcon.tooltip and libDBIcon.tooltip:IsObjectType("GameTooltip") then
    libDBIcon.tooltip:HookScript("OnShow", function(self)
        Artwork:SkinTooltip(self)
    end)
end
