local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local TT = E:GetModule("Tooltip")

Skins:SecureHook(TT, "SetStyle", function(self, tip)
    if not tip or (tip == E.ScanTooltip or tip.IsEmbedded) or tip:IsForbidden() then
        return
    end

    Skins:HandleToolTip(tip)
end)

local AS = AS and unpack(AddOnSkins)
if AS and false then
    Skins:SecureHook(AS, "SkinTooltip", function(self, tooltip, scale)
        Skins:HandleToolTip(tooltip)
    end)
end

local DBIcon = LibStub("LibDBIcon-1.0", true)
if DBIcon and DBIcon.tooltip and DBIcon.tooltip:IsObjectType("GameTooltip") then
    DBIcon.tooltip:HookScript("OnShow", function(self)
        Skins:HandleToolTip(self)
    end)
end

function Skins:HandleToolTip(tip)
    if not tip then
        return
    end

    Skins:CreateShadow(tip)
    local border = Skins:CreateBorder(tip, Skins:GetTooltipBorderAtlas(), E.media.bordercolor)

    if border and border:IsShown() then
        local borderColor = E.media.bordercolor
        if E.db.tooltip.itemQualityBorderColor and tip.GetItem then
            local _, link = tip:GetItem()
            if link then
                local _, _, quality = GetItemInfo(link)
                if quality and quality > 1 then
                    borderColor = {GetItemQualityColor(quality)}
                end
            end
        end
        tip:SetBackdropBorderColor(unpack(borderColor))

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
end
