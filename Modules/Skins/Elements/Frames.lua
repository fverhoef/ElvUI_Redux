local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)

function Skins:HandleFrame(frame, setBackdrop)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(frame))
end

function Skins:HandleTab(tab, noBackdrop, orientation)
    if not tab then
        return
    end

    tab.orientation = orientation

    Skins:CreateShadow(tab)
    local border = Skins:CreateBorder(tab, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(tab))

    if orientation == "UP" then
        border.Bottom:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Left:SetPoint("BOTTOMLEFT", border.parent, "BOTTOMLEFT")
        border.Right:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT")
    elseif orientation == "DOWN" then
        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()

        border.Left:SetPoint("TOPLEFT", border.parent, "TOPLEFT")
        border.Right:SetPoint("TOPRIGHT", border.parent, "TOPRIGHT")
    elseif orientation == "LEFT" then
        border.Right:Hide()
        border.TopRight:Hide()
        border.BottomRight:Hide()

        border.Top:SetPoint("TOPRIGHT", border.parent, "TOPRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT")
    elseif orientation == "RIGHT" then
        border.Left:Hide()
        border.TopLeft:Hide()
        border.BottomLeft:Hide()

        border.Top:SetPoint("TOPLEFT", border.parent, "TOPLEFT")
        border.Bottom:SetPoint("BOTTOMLEFT", border.parent, "BOTTOMLEFT")
    end
end

function Skins:HandleCloseButton(button)
    if not button then
        return
    end    
end

function Skins:HandleButton(button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))
end

function Skins:HandleScrollBar(button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex)
    if not button then
        return
    end

    Skins:CreateShadow(button)
end

function Skins:HandleDropDownList(listFrame)
    if not listFrame then
        return
    end

    Skins:CreateShadow(listFrame)
end
