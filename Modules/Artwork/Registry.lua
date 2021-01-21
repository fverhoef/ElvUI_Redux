local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork

Artwork.registry = {
    frames = {},
    nestedFrames = {},
    tabs = {},
    buttons = {},
    actionButtons = {},
    bagButtons = {},
    itemButtons = {},
    craftItemButtons = {}
}

function Artwork:RegisterFrame(frame)
    Artwork.registry.frames[frame] = true
end

function Artwork:RegisterNestedFrame(frame)
    Artwork.registry.nestedFrames[frame] = true
end

function Artwork:IsFrameRegistered(frame)
    return Artwork.registry.frames[frame] or Artwork.registry.nestedFrames[frame] or false
end

function Artwork:IsParentFrameRegistered(frame)
    local parent = frame:GetParent()
    while parent do
        if Artwork.registry.frames[parent] then
            return true
        end

        parent = parent:GetParent()
    end

    return false
end

function Artwork:RegisterTab(tab)
    Artwork.registry.tabs[tab] = true
end

function Artwork:IsTabRegistered(tab)
    return Artwork.registry.tabs[tab] ~= nil
end

function Artwork:RegisterButton(button)
    Artwork.registry.buttons[button] = true
end

function Artwork:IsButtonRegistered(button)
    return Artwork.registry.buttons[button] ~= nil
end

function Artwork:RegisterActionButton(button)
    Artwork.registry.actionButtons[button] = true
end

function Artwork:IsActionButtonRegistered(button)
    return Artwork.registry.actionButtons[button] ~= nil
end

function Artwork:RegisterBagButton(button)
    Artwork.registry.bagButtons[button] = true
end

function Artwork:IsBagButtonRegistered(button)
    return Artwork.registry.bagButtons[button] ~= nil
end

function Artwork:RegisterItemButton(button)
    Artwork.registry.itemButtons[button] = true
end

function Artwork:IsItemButtonRegistered(button)
    return Artwork.registry.itemButtons[button] ~= nil
end

function Artwork:RegisterCraftItemButton(button)
    Artwork.registry.craftItemButtons[button] = true
end

function Artwork:IsCraftItemButtonRegistered(button)
    return Artwork.registry.craftItemButtons[button] ~= nil
end