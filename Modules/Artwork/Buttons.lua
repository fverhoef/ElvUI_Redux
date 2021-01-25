local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

function Artwork:SkinButton(button)
    if not button or Artwork:IsButtonRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetButtonBorderAtlas()

    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateButton(button)
    Artwork:RegisterButton(button)

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.skins.buttonBorderColor
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)
end

function Artwork:UpdateButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetButtonBorderAtlas()

    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.skins.buttonBorderColor)
end

-- Action Buttons
function Artwork:SkinActionButton(button, layer)
    if not button or Artwork:IsActionButtonRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetActionButtonBorderAtlas()

    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas, layer)
    Artwork:UpdateActionButton(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.actionBars.actionButtonBorderColor)

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.actionBars.actionButtonBorderColor
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)

    Artwork:RegisterActionButton(button)
end

function Artwork:UpdateActionButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetActionButtonBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local buttonName = button:GetName()
    local icon = buttonName and _G[buttonName .. "Icon"]
    local name = buttonName and _G[buttonName .. "Name"]

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetInside()
        end
        if name then
        end
        if button.hover then
            button.hover:SetInside()
        end
    else
        if icon then
            icon:SetInside(nil, 2, 2)
        end
        if name then
        end
        if button.hover then
            button.hover:SetInside(nil, 2, 2)
        end
    end
end

-- Bag Buttons
function Artwork:SkinBagButton(button)
    if not button or Artwork:IsBagButtonRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetBagButtonBorderAtlas()

    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateBagButton(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.bagsAndItems.bagButtonBorderColor)

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.bagsAndItems.bagButtonBorderColor
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)

    Artwork:RegisterBagButton(button)
end

function Artwork:UpdateBagButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetBagButtonBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local name = button:GetName()
    local icon = _G[name .. "Icon"]

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetInside()
        end
        if button.hover then
            button.hover:SetInside()
        end
    else
        if icon then
            icon:SetInside(nil, 4, 4)
        end
        if button.hover then
            button.hover:SetInside(nil, 2, 2)
        end
    end
end

-- Item Buttons
function Artwork:SkinItemButton(button, repositionIcon)
    if not button or Artwork:IsItemButtonRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetItemButtonBorderAtlas()

    button.repositionIcon = repositionIcon
    button.ArtworkBorder = Artwork:CreateBorder(button, borderAtlas)
    Artwork:UpdateItemButton(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.bagsAndItems.itemButtonBorderColor)

    Artwork:SecureHook(button, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.bagsAndItems.itemButtonBorderColor
        end
        Artwork:UpdateBorderColor(self.ArtworkBorder, color)
    end)

    Artwork:RegisterItemButton(button)
end

function Artwork:UpdateItemButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetItemButtonBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local name = button:GetName()
    local icon = _G[name .. "Icon"] or (button.repositionIcon and _G[name .. "IconTexture"])

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetInside()
        end
        if button.hover then
            button.hover:SetInside()
        end

        if button.repositionIcon and button.Icon then
            button.Icon:Size(E.PixelMode and 35 or 32)
            button.Icon:Point("TOPLEFT", E.PixelMode and 2 or 4, -(E.PixelMode and 2 or 4))
        end
    else
        if icon then
            icon:SetInside(nil, 2, 2)
        end
        if button.hover then
            button.hover:SetInside(nil, 2, 2)
        end

        if button.repositionIcon and button.Icon then
            button.Icon:Size(32)
            button.Icon:Point("TOPLEFT", 4, -4)
        end
    end
end

-- Trade/Craft Items
function Artwork:SkinCraftItemButton(button)
    if not button or Artwork:IsCraftItemButtonRegistered(button) then
        return
    end

    local borderAtlas = Artwork:GetItemButtonBorderAtlas()

    local icon = _G[button:GetName() .. "IconTexture"]

    button.ArtworkBorder = Artwork:CreateBorder(icon or button, borderAtlas)
    Artwork:UpdateCraftItemButton(button)
    Artwork:UpdateBorderColor(button.ArtworkBorder, E.db[addonName].artwork.bagsAndItems.itemButtonBorderColor)
    button.ArtworkBorder:SetFrameLevel(button:GetFrameLevel() + 1)

    Artwork:SecureHook((icon or button).backdrop, "SetBackdropBorderColor", function(self, r, g, b, a)
        local color = {r, g, b, a}
        if r == 0 and g == 0 and b == 0 then
            color = E.db[addonName].artwork.bagsAndItems.itemButtonBorderColor
        end
        Artwork:UpdateBorderColor(button.ArtworkBorder, color)
    end)

    Artwork:RegisterCraftItemButton(button)
end

function Artwork:UpdateCraftItemButton(button)
    if not button then
        return
    end

    local borderAtlas = Artwork:GetItemButtonBorderAtlas()
    Artwork:UpdateBorder(button.ArtworkBorder, borderAtlas)

    local icon = _G[button:GetName() .. "IconTexture"]

    if not E.db[addonName].artwork.enabled or not borderAtlas then
        if icon then
            icon:SetDrawLayer("OVERLAY")
            icon:Point("TOPLEFT", 0, 0)
        end
    else
        if icon then
            icon:SetDrawLayer("BACKGROUND")
            icon:Point("TOPLEFT", 2, 2)
        end
    end
end
