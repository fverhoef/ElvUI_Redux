local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")

local function UpdateShadow(shadow)
    local config = E.db[addonName].skins.shadows

    if not config.enabled or shadow.isHidden then
        shadow:Hide()
    else
        shadow:Show()

        if (not shadow.color or shadow.color[1] ~= config.color[1] or shadow.color[2] ~= config.color[2] or shadow.color[3] ~=
            config.color[3] or shadow.size ~= config.size) then
            shadow.color = {unpack(config.color)}
            shadow.size = config.size

            shadow:SetFrameLevel(0)
            shadow:SetOutside(shadow.parent, config.size or 3, config.size or 3)
            shadow:SetBackdrop({edgeFile = LSM:Fetch("border", "ElvUI GlowBorder"), edgeSize = E:Scale(2 + (config.size or 3))})
            
            shadow:SetShadowColor(unpack(config.color))
        end
    end
end

local function GetShadowColor(shadow)
    if not shadow then
        return
    end

    return shadow:GetBackdropBorderColor()
end

local function SetShadowColor(shadow, r, g, b, a)
    if not shadow then
        return
    end

    return shadow:SetBackdropBorderColor(r, g, b, a)
end

function Skins:CreateShadow(frame, isHidden)
    if not frame then
        return
    end
    if frame.shadow then
        return frame.shadow
    end

    local parent = frame.backdrop or frame

    local shadow = parent:CreateShadow(nil, true)
    shadow.parent = parent
    shadow.isHidden = isHidden
    shadow.Update = UpdateShadow
    shadow.GetShadowColor = GetShadowColor
    shadow.SetShadowColor = SetShadowColor
    shadow:Update()

    frame.shadow = shadow

    Skins:RegisterShadow(shadow)

    return shadow
end