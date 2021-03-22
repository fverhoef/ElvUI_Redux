local addonName, addonTable = ...
local Addon = addonTable[1]


Addon.registry = {
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
    namePlates = {},
    shadows = {}
}

function Addon:RegisterShadow(shadow)
    if not shadow or shadow.isRegistered then
        return
    end
    Addon.registry.shadows[shadow] = true
    shadow.isRegistered = true
end

function Addon:UnregisterShadow(shadow)
    if not shadow or not shadow.isRegistered then
        return
    end
    Addon.registry.shadows[shadow] = false
    shadow.isRegistered = false
    shadow.isHidden = true
end

function Addon:RegisterFrame(frame)
    Addon.registry.frames[frame] = true
end

function Addon:RegisterNestedFrame(frame)
    Addon.registry.nestedFrames[frame] = true
end

function Addon:IsFrameRegistered(frame)
    return Addon.registry.frames[frame] or Addon.registry.nestedFrames[frame] or false
end

function Addon:GetRegisteredParentFrame(obj)
    local parent = obj:GetParent()
    while parent do
        if Addon.registry.frames[parent] then
            return parent
        end

        parent = parent:GetParent()
    end
end

function Addon:IsParentFrameRegistered(frame)
    return Addon:GetRegisteredParentFrame(frame) ~= nil
end

function Addon:RegisterCloseButton(button)
    Addon.registry.closeButtons[button] = true
end

function Addon:IsCloseButtonRegistered(button)
    return Addon.registry.closeButtons[button] ~= nil
end

function Addon:RegisterTab(tab)
    Addon.registry.tabs[tab] = true
end

function Addon:IsTabRegistered(tab)
    return Addon.registry.tabs[tab] ~= nil
end

function Addon:RegisterButton(button)
    Addon.registry.buttons[button] = true
end

function Addon:IsButtonRegistered(button)
    return Addon.registry.buttons[button] ~= nil
end

function Addon:RegisterActionButton(button)
    Addon.registry.actionButtons[button] = true
end

function Addon:IsActionButtonRegistered(button)
    return Addon.registry.actionButtons[button] ~= nil
end

function Addon:RegisterBagButton(button)
    Addon.registry.bagButtons[button] = true
end

function Addon:IsBagButtonRegistered(button)
    return Addon.registry.bagButtons[button] ~= nil
end

function Addon:RegisterItemButton(button)
    Addon.registry.itemButtons[button] = true
end

function Addon:IsItemButtonRegistered(button)
    return Addon.registry.itemButtons[button] ~= nil
end

function Addon:RegisterCraftItemButton(button)
    Addon.registry.craftItemButtons[button] = true
end

function Addon:IsCraftItemButtonRegistered(button)
    return Addon.registry.craftItemButtons[button] ~= nil
end

function Addon:RegisterAura(button)
    Addon.registry.auras[button] = true
end

function Addon:IsAuraRegistered(button)
    return Addon.registry.auras[button] ~= nil
end

function Addon:RegisterTempEnchant(button)
    Addon.registry.tempEnchants[button] = true
end

function Addon:IsTempEnchantRegistered(button)
    return Addon.registry.tempEnchants[button] ~= nil
end

function Addon:RegisterUnitFrame(frame)
    Addon.registry.unitFrames[frame] = true
end

function Addon:IsUnitFrameRegistered(frame)
    return Addon.registry.unitFrames[frame] ~= nil
end

function Addon:RegisterGroupHeader(header)
    Addon.registry.groupHeaders[header] = true
end

function Addon:IsGroupHeaderRegistered(header)
    return Addon.registry.groupHeaders[header] ~= nil
end

function Addon:RegisterChatPanel(panel)
    Addon.registry.chatPanels[panel] = true
end

function Addon:IsChatPanelRegistered(panel)
    return Addon.registry.chatPanels[panel] ~= nil
end

function Addon:RegisterDataBar(bar)
    Addon.registry.dataBars[bar] = true
end

function Addon:IsDataBarRegistered(bar)
    return Addon.registry.dataBars[bar] ~= nil
end

function Addon:RegisterDataPanel(panel)
    Addon.registry.dataPanels[panel] = true
end

function Addon:IsDataPanelRegistered(panel)
    return Addon.registry.dataPanels[panel] ~= nil
end

function Addon:RegisterNamePlate(nameplate)
    Addon.registry.namePlates[nameplate] = true
end

function Addon:IsNamePlateRegistered(nameplate)
    return Addon.registry.namePlates[nameplate] ~= nil
end