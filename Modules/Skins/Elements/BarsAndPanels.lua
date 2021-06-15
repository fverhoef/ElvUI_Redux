local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local CH = E:GetModule("Chat")

function Skins:HandlePanel(panel, location)
    if not panel then
        return
    end

    Skins:CreateShadow(panel)
    local border = Skins:CreateBorder(panel, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(panel))

    if location == "TOP" then
        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()
        border.Left:Hide()
        border.Right:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Bottom:SetPoint("BOTTOMLEFT", border.parent, "BOTTOMLEFT")
        border.Bottom:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT")
    elseif location == "BOTTOM" then
        border.TopLeft:Hide()
        border.TopRight:Hide()
        border.Left:Hide()
        border.Right:Hide()
        border.Bottom:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Top:SetPoint("TOPLEFT", border.parent, "TOPLEFT")
        border.Top:SetPoint("TOPRIGHT", border.parent, "TOPRIGHT")
    end
end

function Skins:HandleDataBar(bar, holder)
    if not bar then
        return
    end

    Skins:CreateShadow(holder)
    Skins:CreateBorder(bar, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(bar))
end

function Skins:HandleChatPanel(panel)
    if not panel then
        return
    end

    Skins:CreateShadow(panel)
    local border = Skins:CreateBorder(panel, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(panel))

    if panel == _G.LeftChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "RIGHT") then
        border:Hide()
    end
    if panel == _G.RightChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "LEFT") then
        border:Hide()
    end
end

function Skins:HandleDataPanel(panel)
    if not panel or panel == _G.MinimapPanel then
        return
    end

    Skins:CreateShadow(panel)
    Skins:CreateBorder(panel, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(panel))
end

function Skins:HandleActionBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
end

function Skins:HandleLootRollBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
    Skins:CreateShadow(bar.button)
    Skins:CreateBorder(bar, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(bar))
end

function Skins:HandleStatusBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
    Skins:CreateBorder(bar, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(bar))
end
