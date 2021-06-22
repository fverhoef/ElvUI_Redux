local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")

Skins:SecureHook(B, "UpdateSlot", function(self, frame, bagID, slotID)
    if frame and frame.Bags[bagID] then
        Skins:HandleBagSlotButton(frame.Bags[bagID][slotID])
    end
end)

function Skins:HandleBagSlotButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.BAG_SLOT)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Skins:SecureHook(B, "SkinBag", function(self, bag)
    Skins:HandleBagBarButton(bag)
end)

function Skins:HandleBagBarButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.BAG_BAR)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end