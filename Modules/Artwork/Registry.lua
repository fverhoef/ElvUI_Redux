local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork

-- Registry
Artwork.registry = {
    frames = {},
    nestedFrames = {},
    buttons = {},
    actionButtons = {},
    bagButtons = {},
    itemButtons = {},
    craftItemButtons = {},
    tabs = {}
}

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

function Artwork:IsButtonRegistered(button)
    return Artwork.registry.buttons[button] or false
end

function Artwork:IsActionButtonRegistered(button)
    return Artwork.registry.actionButtons[button] or false
end

function Artwork:IsBagButtonRegistered(button)
    return Artwork.registry.bagButtons[button] or false
end

function Artwork:IsItemButtonRegistered(button)
    return Artwork.registry.itemButtons[button] or false
end

function Artwork:IsCraftItemButtonRegistered(button)
    return Artwork.registry.craftItemButtons[button] or false
end

function Artwork:IsTabRegistered(tab)
    return Artwork.registry.tabs[tab] or false
end