local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local RU = E:GetModule("RaidUtility")
local S = E:GetModule("Skins")

Skins:SecureHook(S, "HandleItemButton", function(self, button, shrinkIcon)
    Skins:HandleItemButton(button, shrinkIcon)
end)

function Skins:HandleItemButton(button, shrinkIcon)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetItemButtonBorderAtlas(), Skins:GetBorderColor(button))

    local name = button:GetName()
    if name then
        if string.match(name, "TradePlayerItem") or string.match(name, "TradeRecipientItem") then
            -- TODO: resize icon for trade items
            return
        end

        local icon = button.icon or _G[name .. "Icon"] or _G[name .. "IconTexture"]
        if icon then
            icon:SetInside(nil, 2, 2)
        end
    end
end

function Skins:HandleLargeItemButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetItemButtonBorderAtlas(), Skins:GetBorderColor(button))

    if button.Icon then
        button.Icon:Size(33)
        button.Icon:Point("TOPLEFT", 4, -4)
    end
end

Skins:SecureHook(RU, "CreateUtilButton",
                 function(self, name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
    Skins:HandleRaidUtilityButton(_G[name])
end)

function Skins:HandleRaidUtilityButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))
end

Skins:Hook(S, "HandleNextPrevButton", function(self, button, arrowDir, color, noBackdrop, stripTexts)
    button.artworkType = "NEXT_PREV"
end)

function Skins:HandleTalentButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    local border = Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))

    local rank = _G[button:GetName() .. "Rank"]
    if rank then
        rank:SetParent(border)
    end
end
