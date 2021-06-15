local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)

function Skins:HandleActionButton(button, noBackdrop, useMasque, ignoreNormal)
    if not button or useMasque then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetActionButtonBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

function Skins:HandleAuraButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetAuraBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

function Skins:HandleTempEnchantButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetTempEnchantBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

function Skins:HandleItemButton(button, shrinkIcon)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetItemButtonBorderAtlas(), Skins:GetBorderColor(button))

    local name = button:GetName()
    if string.match(name, "TradePlayerItem") or string.match(name, "TradeRecipientItem") then
        -- TODO: resize icon for trade items
        return
    end

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

function Skins:HandleRaidUtilityButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))
end

function Skins:HandleBagSlotButton(button, bagID, slotID)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetBagSlotButtonBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

function Skins:HandleBagBarButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetBagBarButtonBorderAtlas(), Skins:GetBorderColor(button))

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end
