local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)
local AS = unpack(AddOnSkins)
local A = E:GetModule("Auras")
local AB = E:GetModule("ActionBars")
local B = E:GetModule("Bags")
local DB = E:GetModule("DataBars")
local DT = E:GetModule("DataTexts")
local M = E:GetModule("Misc")
local NP = E:GetModule("NamePlates")
local RU = E:GetModule("RaidUtility")
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")
local UF = E:GetModule("UnitFrames")

Artwork:SecureHook(E, "SetBackdropBorderColor", function(self, frame, r, g, b, a)
    if Artwork:IsItemButtonRegistered(frame) or Artwork:IsAuraRegistered(frame) then
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
    local color = E.db[addonName].artwork.skins.useDefaultButtonHighlight and E.media.rgbvaluecolor or E.db[addonName].artwork.skins.buttonBorderHighlightColor
    Artwork:UpdateBorderColor(button.ArtworkBorder, color)
end)

Artwork:SecureHook(S, "SetOriginalBackdrop", function(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.skins.buttonBorderColor)
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

    -- TODO: skin scrollbar background
    --Artwork:SkinFrame(frame, true, true, true)
    --Artwork:SkinButton(thumb)
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

Artwork:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Artwork:SkinDataBar(_G[name])
end)

Artwork:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Artwork:SkinDataPanel(panel)
end)

Artwork:SecureHook(M, "START_LOOT_ROLL", function(self, _, rollID, time)
    for _, bar in ipairs(M.RollBars) do
        Artwork:SkinFrame(bar, true)
        Artwork:SkinActionButton(bar.button)
    end
end)

Artwork:SecureHook(NP, "StylePlate", function(self, nameplate)
    Artwork:SkinNamePlate(nameplate)
end)

Artwork:SecureHook(RU, "CreateUtilButton", function(self, name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
    Artwork:SkinButton(_G[name])
end)

Artwork:SecureHook(nil, "ToggleDropDownMenu", function(level)
    local listFrame = _G["DropDownList" .. (level or 1)]
    local listFrameName = listFrame:GetName()
    local backdrop = _G[listFrameName .. "Backdrop"]
    local menuBackdrop = _G[listFrameName .. "MenuBackdrop"]

    Artwork:SkinFrame(listFrame, true, true)
    if listFrame then
        if backdrop then
            if listFrame.ArtworkBorder:IsShown() then
                backdrop:SetInside(nil, 2, 2)
            else
                backdrop:SetInside()
            end
        end
        if menuBackdrop then
            if listFrame.ArtworkBorder:IsShown() then
                menuBackdrop:SetInside(nil, 2, 2)
            else
                menuBackdrop:SetInside()
            end
        end
    end
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
