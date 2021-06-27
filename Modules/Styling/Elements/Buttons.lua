local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local RU = E:GetModule("RaidUtility")
local S = E:GetModule("Skins")

Styling:SecureHook(S, "HandleItemButton", function(self, button, shrinkIcon)
    Styling:HandleItemButton(button, shrinkIcon)
end)

Styling:Hook(S, "HandleNextPrevButton", function(self, button, arrowDir, color, noBackdrop, stripTexts)
    button.artworkType = "NEXT_PREV"
end)

function Styling:HandleItemButton(button, shrinkIcon)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.ITEM_BUTTON)

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

function Styling:HandleLargeItemButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.ITEM_BUTTON)

    if button.Icon then
        button.Icon:Size(33)
        button.Icon:Point("TOPLEFT", 4, -4)
    end
end

Styling:SecureHook(RU, "CreateUtilButton",
                 function(self, name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
    Styling:HandleRaidUtilityButton(_G[name])
end)

function Styling:HandleRaidUtilityButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.RAID_UTILITY_BUTTON)
end

function Styling:HandleTalentButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    local border = Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.TALENT_BUTTON)

    local rank = _G[button:GetName() .. "Rank"]
    if rank then
        rank:SetParent(border)
    end
end
