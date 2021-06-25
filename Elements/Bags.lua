local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")

Addon:SecureHook(B, "UpdateSlot", function(self, frame, bagID, slotID)
    if frame and frame.Bags[bagID] then
        Addon:HandleBagSlotButton(frame.Bags[bagID][slotID])
    end
end)

function Addon:HandleBagSlotButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.BAG_SLOT)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Addon:SecureHook(B, "SkinBag", function(self, bag)
    Addon:HandleBagBarButton(bag)
end)

function Addon:HandleBagBarButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.BAG_BAR)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end