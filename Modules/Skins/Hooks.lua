local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local Shadows = Addon.Shadows
local Skins = Addon.Skins
local Tooltips = Addon.Tooltips
local E, L, V, P, G = unpack(ElvUI)
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

Skins:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    Skins:HandleFrame(frame, setBackdrop)
end)

Skins:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    Skins:HandleTab(tab, noBackdrop, "DOWN")
end)

Skins:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Skins:HandleCloseButton(button)
end)

Skins:SecureHook(S, "HandleButton",
                 function(self, button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex,
                          frameLevel)
    Skins:HandleButton(button)
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

Skins:Hook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
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

    Skins:HandleScrollBar(frame)
end)

Skins:Hook(S, "HandleNextPrevButton", function(self, button, arrowDir, color, noBackdrop, stripTexts)
    button.artworkType = "NEXT_PREV"
end)

Skins:SecureHook(S, "HandleItemButton", function(self, button, shrinkIcon)
    Skins:HandleItemButton(button, shrinkIcon)
end)

Skins:SecureHook(RU, "CreateUtilButton",
                 function(self, name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
    Skins:HandleRaidUtilityButton(_G[name])
end)

Skins:SecureHook(E, "Config_WindowOpened", function(self)
    Skins:HandleFrame(E:Config_GetWindow())
end)

Skins:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Skins:HandleFrame(frame)
end)

Skins:SecureHook(A, "UpdateAura", function(self, button)
    Skins:HandleAuraButton(button)
end)

Skins:SecureHook(A, "UpdateTempEnchant", function(self, button)
    Skins:HandleTempEnchantButton(button)
end)

Skins:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    Skins:HandleActionButton(button, noBackdrop, useMasque, ignoreNorma)
end)

Skins:SecureHook(B, "UpdateSlot", function(self, frame, bagID, slotID)
    if frame and frame.Bags[bagID] then
        Skins:HandleBagSlotButton(frame.Bags[bagID][slotID], bagID, slotID)
    end
end)

Skins:SecureHook(B, "SkinBag", function(self, bag)
    Skins:HandleBagBarButton(bag)
end)

Skins:SecureHook(DB, "CreateBar", function(self, name, key, updateFunc, onEnter, onClick, points)
    Skins:HandleDataBar(_G[name], _G[name .. "Holder"])
end)

Skins:SecureHook(DT, "RegisterPanel", function(self, panel, numPoints, anchor, xOff, yOff, vertical)
    Skins:HandleDataPanel(panel)
end)

Skins:SecureHook(M, "START_LOOT_ROLL", function(self, _, rollID, time)
    for _, bar in ipairs(M.RollBars) do
        Skins:HandleLootRollBar(bar)
    end
end)

Skins:SecureHook(NP, "StylePlate", function(self, nameplate)
    Skins:HandleNamePlate(nameplate)
end)

Skins:SecureHook(TT, "SetStyle", function(self, tip)
    Skins:HandleToolTip(tip)
end)

Skins:SecureHook(S, "Ace3_StyleTooltip", function(self)
    Skins:HandleToolTip(self)
end)

Skins:SecureHook(UF, "Configure_Castbar", function(self, frame)
    local castbar = frame.Castbar
    if castbar.ButtonIcon and castbar.ButtonIcon.bg and castbar.ButtonIcon.bg.shadow then
        castbar.ButtonIcon.bg.shadow.isHidden = frame.db.castbar.iconAttached
        castbar.ButtonIcon.bg.shadow:Update()
    end
end)

Skins:SecureHook(nil, "ToggleDropDownMenu", function(level)
    Skins:HandleDropDownList(_G["DropDownList" .. (level or 1)])
end)

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Skins:HandleToolTip(self)
    end)
end

-- AddOnSkins Hooks
local AS = AS and unpack(AddOnSkins)
if AS and false then
    Skins:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        Skins:HandleFrame(frame)
    end)

    Skins:SecureHook(AS, "SkinButton", function(self, button, strip)
        Skins:HandleButton(button)
    end)

    Skins:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Skins:HandleCloseButton(button)
    end)

    Skins:SecureHook(AS, "SkinTooltip", function(self, tooltip, scale)
        Skins:HandleToolTip(tooltip)
    end)
end
