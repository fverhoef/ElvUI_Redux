local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")

function Skins:HandleActionBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
    Skins:CreateBorder(bar, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(bar))
end

Skins:SecureHook(AB, "StyleButton", function(self, button, noBackdrop, useMasque, ignoreNormal)
    Skins:HandleActionButton(button, noBackdrop, useMasque, ignoreNorma)
end)

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

Skins:SecureHook(AB, "HandleMicroButton", function(self, button)
    Skins:HandleMicroButton(button)
end)

function Skins:HandleMicroButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetActionButtonBorderAtlas(), Skins:GetBorderColor(button))

    local pushed = button:GetPushedTexture()
    local normal = button:GetNormalTexture()
    local disabled = button:GetDisabledTexture()

    pushed:SetInside(button.backdrop, 2, 2)
    normal:SetInside(button.backdrop, 2, 2)

    if disabled then
        disabled:SetInside(button.backdrop, 2, 2)
    end
end
