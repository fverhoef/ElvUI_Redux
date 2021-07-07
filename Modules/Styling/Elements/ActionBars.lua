local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")

function Styling:HandleActionBar(bar)
    if not bar then
        return
    end

    Styling:ApplyStyle(bar, Addon.STYLE_CONFIG_KEYS.ACTION_BAR)
end

Styling:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    Styling:HandleActionButton(button, noBackdrop, useMasque, ignoreNorma)
end)

function Styling:HandleActionButton(button, noBackdrop, useMasque, ignoreNormal)
    if not button or useMasque then
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.ACTION_BUTTON)

    local icon = button.icon or _G[button:GetName() .. "Icon"]
    if icon then
        icon:SetInside(nil, 2, 2)
    end
end

Styling:SecureHook(AB, "HandleMicroButton", function(self, button)
    Styling:HandleMicroButton(button)
end)

function Styling:HandleMicroButton(button)
    if not button then
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.MICRO_BUTTON)

    local pushed = button:GetPushedTexture()
    local normal = button:GetNormalTexture()
    local disabled = button:GetDisabledTexture()

    pushed:SetInside(button.backdrop, 2, 2)
    normal:SetInside(button.backdrop, 2, 2)

    if disabled then
        disabled:SetInside(button.backdrop, 2, 2)
    end
end
