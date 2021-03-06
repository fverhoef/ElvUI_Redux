local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork

Artwork.registry = {
    frames = {},
    nestedFrames = {},
    closeButtons = {},
    tabs = {},
    buttons = {},
    actionButtons = {},
    bagButtons = {},
    itemButtons = {},
    craftItemButtons = {},
    auras = {},
    tempEnchants = {},
    unitFrames = {},
    groupHeaders = {},
    chatPanels = {},
    dataBars = {},
    dataPanels = {},
    namePlates = {}
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

function Artwork:GetRegisteredParentFrame(obj)
    local parent = obj:GetParent()
    while parent do
        if Artwork.registry.frames[parent] then
            return parent
        end

        parent = parent:GetParent()
    end
end

function Artwork:IsParentFrameRegistered(frame)
    return Artwork:GetRegisteredParentFrame(frame) ~= nil
end

function Artwork:RegisterCloseButton(button)
    Artwork.registry.closeButtons[button] = true
end

function Artwork:IsCloseButtonRegistered(button)
    return Artwork.registry.closeButtons[button] ~= nil
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

function Artwork:RegisterAura(button)
    Artwork.registry.auras[button] = true
end

function Artwork:IsAuraRegistered(button)
    return Artwork.registry.auras[button] ~= nil
end

function Artwork:RegisterTempEnchant(button)
    Artwork.registry.tempEnchants[button] = true
end

function Artwork:IsTempEnchantRegistered(button)
    return Artwork.registry.tempEnchants[button] ~= nil
end

function Artwork:RegisterUnitFrame(frame)
    Artwork.registry.unitFrames[frame] = true
end

function Artwork:IsUnitFrameRegistered(frame)
    return Artwork.registry.unitFrames[frame] ~= nil
end

function Artwork:RegisterGroupHeader(header)
    Artwork.registry.groupHeaders[header] = true
end

function Artwork:IsGroupHeaderRegistered(header)
    return Artwork.registry.groupHeaders[header] ~= nil
end

function Artwork:RegisterChatPanel(panel)
    Artwork.registry.chatPanels[panel] = true
end

function Artwork:IsChatPanelRegistered(panel)
    return Artwork.registry.chatPanels[panel] ~= nil
end

function Artwork:RegisterDataBar(bar)
    Artwork.registry.dataBars[bar] = true
end

function Artwork:IsDataBarRegistered(bar)
    return Artwork.registry.dataBars[bar] ~= nil
end

function Artwork:RegisterDataPanel(panel)
    Artwork.registry.dataPanels[panel] = true
end

function Artwork:IsDataPanelRegistered(panel)
    return Artwork.registry.dataPanels[panel] ~= nil
end

function Artwork:RegisterNamePlate(nameplate)
    Artwork.registry.namePlates[nameplate] = true
end

function Artwork:IsNamePlateRegistered(nameplate)
    return Artwork.registry.namePlates[nameplate] ~= nil
end