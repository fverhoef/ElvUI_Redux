local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")

function Addon:HandleActionBar(bar)
    if not bar then
        return
    end

    Addon:CreateShadow(bar)
    Addon:CreateBorder(bar, Addon.BORDER_CONFIG_KEYS.ACTION_BAR)
end

Addon:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    Addon:HandleActionButton(button, noBackdrop, useMasque, ignoreNorma)
end)

function Addon:HandleActionButton(button, noBackdrop, useMasque, ignoreNormal)
    if not button or useMasque then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.ACTION_BUTTON)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Addon:SecureHook(AB, "HandleMicroButton", function(self, button)
    Addon:HandleMicroButton(button)
end)

function Addon:HandleMicroButton(button)
    if not button then
        return
    end

    Addon:CreateShadow(button)
    Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.MICRO_BUTTON)

    local pushed = button:GetPushedTexture()
    local normal = button:GetNormalTexture()
    local disabled = button:GetDisabledTexture()

    pushed:SetInside(button.backdrop, 2, 2)
    normal:SetInside(button.backdrop, 2, 2)

    if disabled then
        disabled:SetInside(button.backdrop, 2, 2)
    end
end
