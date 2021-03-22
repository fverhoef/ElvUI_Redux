local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local Shadows = Addon.Shadows
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
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

Addon:SecureHook(E, "SetBackdropBorderColor", function(self, frame, r, g, b, a)
    if Addon:IsItemButtonRegistered(frame) or Addon:IsAuraRegistered(frame) then
        Artwork:UpdateBorderColor(frame.ArtworkBorder, {r, g, b, a})
    end
end)

Addon:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    Shadows:CreateShadow(frame)

    if Addon:IsParentFrameRegistered(frame) then
        Artwork:SkinNestedFrame(frame)
    else
        Artwork:SkinFrame(frame)
    end
end)

Addon:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    Shadows:CreateShadow(tab)
    Artwork:SkinTab(tab, "DOWN")
end)

Addon:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Artwork:SkinCloseButton(button)
end)

Addon:SecureHook(S, "HandleButton", function(self, button, strip, isDeclineButton, useCreateBackdrop, noSetTemplate)
    if noSetTemplate then
        return
    end

    Artwork:SkinButton(button)
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

Addon:Hook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
    local parent = frame:GetParent()
    local up = GrabScrollBarElement(frame, {"ScrollUpButton", "UpButton", "ScrollUp", "scrollUp"})
    local down = GrabScrollBarElement(frame, {"ScrollDownButton", "DownButton", "ScrollDown", "scrollDown"})
    local thumb = GrabScrollBarElement(frame, {"Thumb"})
    local thumbTexture = GrabScrollBarElement(frame, {"ThumbTexture", "thumbTexture"}) or frame.GetThumbTexture and
                             frame:GetThumbTexture()

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
    -- Artwork:SkinFrame(frame, true, true, true)
    -- Artwork:SkinButton(thumb)
end)

Addon:Hook(S, "HandleNextPrevButton", function(self, button, arrowDir, color, noBackdrop, stripTexts)
    button.artworkType = "NEXT_PREV"
end)

Addon:SecureHook(S, "HandleItemButton", function(self, button, shrinkIcon)
    Artwork:SkinItemButton(button)
end)

Addon:SecureHook(RU, "CreateUtilButton",
                 function(self, name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
    Artwork:SkinButton(_G[name])
end)

Addon:SecureHook(S, "SetModifiedBackdrop", function(button)
    local color = E.db[addonName].artwork.skins.useDefaultButtonHighlight and E.media.rgbvaluecolor or
                      E.db[addonName].artwork.skins.buttonBorderHighlightColor
    Artwork:UpdateBorderColor(button.ArtworkBorder, color)
end)

Addon:SecureHook(S, "SetOriginalBackdrop", function(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.skins.buttonBorderColor)
end)

Addon:SecureHook(E, "Config_WindowOpened", function(self)
    local optionsFrame = E:Config_GetWindow()
    if optionsFrame then
        Shadows:CreateShadow(optionsFrame)
        Artwork:SkinFrame(optionsFrame)
    end
end)

Addon:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Shadows:CreateShadow(frame)
    Artwork:SkinFrame(frame, true)
end)

Addon:SecureHook(A, "UpdateAura", function(self, button)
    Shadows:CreateShadow(button)
    Artwork:SkinAura(button)
end)

Addon:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Shadows:CreateShadow(button)
    Artwork:SkinTempEnchant(button)
end)

Addon:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    if useMasque then
        return
    end
    Shadows:CreateShadow(button)
    Artwork:SkinActionButton(button)
end)

Addon:SecureHook(B, "UpdateSlot", function(self, frame, bagID, slotID)
    if frame and frame.Bags[bagID] then
        Artwork:SkinBagButton(frame.Bags[bagID][slotID])
    end
end)

Addon:SecureHook(B, "SkinBag", function(self, bag)
    Artwork:SkinItemButton(bag)
end)

Addon:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Shadows:CreateShadow(_G[name .. "Holder"])
    Artwork:SkinDataBar(_G[name])
end)

Addon:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Shadows:CreateShadow(panel)
    Artwork:SkinDataPanel(panel)
end)

Addon:SecureHook(M, "START_LOOT_ROLL", function(self, _, rollID, time)
    for _, bar in ipairs(M.RollBars) do
        Shadows:CreateShadow(bar)
        Shadows:CreateShadow(bar.button)

        Artwork:SkinFrame(bar, true)
        Artwork:SkinActionButton(bar.button)
    end
end)

Addon:SecureHook(NP, "StylePlate", function(self, nameplate)
    if not nameplate.Health.shadow then
        Shadows:CreateShadow(nameplate.Health)
        Shadows:CreateShadow(nameplate.Power)
        Shadows:CreateShadow(nameplate.Castbar)
        if nameplate.Auras and not Addon:IsHooked(nameplate.Auras, "PostUpdateIcon") then
            Addon:SecureHook(nameplate.Auras, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if nameplate.Buffs and not Addon:IsHooked(nameplate.Buffs, "PostUpdateIcon") then
            Addon:SecureHook(nameplate.Buffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
        if nameplate.Debuffs and not Addon:IsHooked(nameplate.Debuffs, "PostUpdateIcon") then
            Addon:SecureHook(nameplate.Debuffs, "PostUpdateIcon", function(self, unit, button)
                Shadows:CreateShadow(button)
            end)
        end
    end

    Artwork:SkinNamePlate(nameplate)
end)

Addon:SecureHook(TT, "SetStyle", function(self, tip)
    Shadows:CreateShadow(tip)
    Artwork:SkinTooltip(tip)
end)

Addon:SecureHook(S, "Ace3_StyleTooltip", function(self)
    Shadows:CreateShadow(self)
    Artwork:SkinTooltip(self)
end)

Addon:SecureHook(UF, "Configure_Castbar", function(self, frame)
    if not frame.shadow then
        return
    end
    if frame.Castbar.ButtonIcon and frame.Castbar.ButtonIcon.bg and frame.Castbar.ButtonIcon.bg.shadow then
        frame.Castbar.ButtonIcon.bg.shadow.isHidden = frame.db.castbar.iconAttached
        Shadows:UpdateShadow(frame.Castbar.ButtonIcon.bg.shadow)
    end
end)

Addon:SecureHook(nil, "ToggleDropDownMenu", function(level)
    local listFrame = _G["DropDownList" .. (level or 1)]
    local listFrameName = listFrame:GetName()
    local backdrop = _G[listFrameName .. "Backdrop"]
    local menuBackdrop = _G[listFrameName .. "MenuBackdrop"]

    Shadows:CreateShadow(listFrame)
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

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Shadows:CreateShadow(self)
        Artwork:SkinTooltip(self)
    end)
end

-- AddOnSkins Hooks
if AS and false then
    Addon:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        if Addon:IsParentFrameRegistered(frame) then
            Artwork:SkinNestedFrame(frame)
        else
            Artwork:SkinFrame(frame)
        end
    end)

    Addon:SecureHook(AS, "SkinButton", function(self, button, strip)
        Artwork:SkinButton(button)
    end)

    Addon:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Artwork:SkinCloseButton(button)
    end)

    Addon:SecureHook(AS, "SkinTooltip", function(self, tooltip, scale)
        Artwork:SkinTooltip(tooltip)
    end)
end
