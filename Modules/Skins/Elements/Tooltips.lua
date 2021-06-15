local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local TT = E:GetModule("Tooltip")

function Skins:HandleToolTip(tip)
    if not tip then
        return
    end

    Skins:CreateShadow(tip)
    local border = Skins:CreateBorder(tip, Skins:GetTooltipBorderAtlas(), E.media.bordercolor)

    if border and border:IsShown() then
        local backdropColor = {tip:GetBackdropColor()}
        backdropColor[4] = TT.db.colorAlpha

        border:HideOriginalBackdrop(true)

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
        tip:SetBackdropColor(unpack(backdropColor))

        if border and tip.StatusBar then
            border:SetFrameLevel(tip.StatusBar:GetFrameLevel() + 1)
            tip.StatusBar:SetScript("OnShow", function(self)
                self.text:Show()
            end)
            tip.StatusBar:SetScript("OnHide", function(self)
                self.text:Hide()
            end)
            tip.StatusBar.text:SetParent(border)
        end
    end
end
