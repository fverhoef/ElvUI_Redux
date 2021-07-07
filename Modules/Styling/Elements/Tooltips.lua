local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")

Styling:SecureHook(TT, "SetStyle", function(self, tip)
    if not tip or (tip == E.ScanTooltip or tip.IsEmbedded) or tip:IsForbidden() then
        return
    end

    Styling:HandleToolTip(tip)
end)

local AS = AS and unpack(AddOnSkins)
if AS and false then
    Styling:SecureHook(AS, "SkinTooltip", function(self, tooltip, scale)
        Styling:HandleToolTip(tooltip)
    end)
end

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Styling:HandleToolTip(self)
    end)
end

function Styling:HandleToolTip(tip)
    if not tip then
        return
    end

    Styling:ApplyStyle(tip, Addon.STYLE_CONFIG_KEYS.TOOLTIP)

    local border = tip:GetBorder()
    if border and tip.StatusBar then
        border:SetFrameLevel(tip.StatusBar:GetFrameLevel() + 1)
        tip.StatusBar:SetScript("OnShow", function(self)
            self.text:Show()
        end)
        tip.StatusBar:SetScript("OnHide", function(self)
            self.text:Hide()
        end)
        tip.StatusBar.text:SetParent(border)

        if tip.StatusBar.border then
            tip.StatusBar.border:Hide()
        end
    end
end
