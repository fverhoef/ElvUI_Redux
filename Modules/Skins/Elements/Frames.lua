local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Skins:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    if string.match(frame:GetName() or "", "FriendsTabHeaderTab") then
        Skins:HandleTab(frame)
    else
        Skins:HandleFrame(frame, setBackdrop)
    end
end)

Skins:SecureHook(S, "HandlePortraitFrame", function(self, frame, setTemplate)
    Skins:HandleFrame(frame, true)
end)

Skins:SecureHook(S, "HandleMaxMinFrame", function(self, frame)
    Skins:HandleFrame(frame)
end)

Skins:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Skins:HandleFrame(frame)
end)

if AS and false then
    Skins:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        Skins:HandleFrame(frame)
    end)

    Skins:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Skins:HandleCloseButton(button)
    end)
end

function Skins:HandleFrame(frame, setBackdrop)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(frame))
end

Skins:SecureHook(S, "HandleInsetFrame", function(self, frame)
    --Skins:HandleInsetFrame(frame)
end)

function Skins:HandleInsetFrame(frame)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(frame))
end

Skins:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    local orientation = "DOWN"
    local name = tab and tab:GetName() or ""
    if string.match(name, "InspectTalentFrameTab") or string.match(name, "CombatConfigTab") then
        orientation = "UP"
    end
    
    Skins:HandleTab(tab, noBackdrop, orientation)
end)

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

Skins:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Skins:HandleCloseButton(button)
end)

function Skins:HandleCloseButton(button)
    if not button then
        return
    end
end

Skins:SecureHook(S, "HandleRotateButton", function(self, button)
    Skins:HandleButton(button, true)
end)

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

function Skins:HandleDecorativePanel(panel, location)
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

Skins:SecureHook(S, "HandleIcon", function(self, icon, backdrop)
    Skins:HandleIcon(icon, backdrop)
end)

Skins:SecureHook(S, "HandleIconSelectionFrame", function(self, frame, numIcons, buttonNameTemplate, frameNameOverride)
    Skins:HandleFrame(frame)

    for i = 1, numIcons do
        Skins:HandleIcon(_G[buttonNameTemplate .. i])
    end
end)

function Skins:HandleIcon(icon, backdrop)
    if not icon then
        return
    end

    if icon.backdrop then
        Skins:CreateShadow(icon.backdrop)
        local border = Skins:CreateBorder(icon.backdrop, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(icon.backdrop))
        border:SetFrameLevel((icon.GetFrameLevel and icon:GetFrameLevel() or icon:GetParent():GetFrameLevel()) + 4)
    end
end