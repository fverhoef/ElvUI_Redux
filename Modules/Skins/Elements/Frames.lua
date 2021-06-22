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
        Skins:HandleFrame(frame)
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

function Skins:HandleFrame(frame)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.FRAME)
end

Skins:SecureHook(S, "HandleInsetFrame", function(self, frame)
    --Skins:HandleInsetFrame(frame)
end)

function Skins:HandleInsetFrame(frame)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.INSET_FRAME)
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
    local border = Skins:CreateBorder(tab, Addon.BORDER_CONFIG_KEYS.TAB)

    if orientation == "UP" then
        border.Bottom:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Left:SetPoint("BOTTOMLEFT", border.parent, "BOTTOMLEFT", 0, 2)
        border.Right:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT", 0, 2)
        border.parent:Offset("BOTTOMRIGHT", 0, -1)
    elseif orientation == "DOWN" then
        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()

        border.Left:SetPoint("TOPLEFT", border.parent, "TOPLEFT", 0, -2)
        border.Right:SetPoint("TOPRIGHT", border.parent, "TOPRIGHT", 0, -2)
        border.parent:Offset("TOPLEFT", 0, 1)
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
    local border = Skins:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.CHAT_PANEL)

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
    local border = Skins:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.DECORATIVE_PANEL)

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

        border.parent:Offset("TOPLEFT", -1, 1)
        border.parent:Offset("TOPRIGHT", 1, 1)
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

        border.parent:Offset("BOTTOMLEFT", -1, -1)
        border.parent:Offset("BOTTOMRIGHT", 1, -1)
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
        local border = Skins:CreateBorder(icon.backdrop, Addon.BORDER_CONFIG_KEYS.ICON)
        border.frameLevel = (icon.GetFrameLevel and icon:GetFrameLevel() or icon:GetParent():GetFrameLevel()) + 4
        border:Update()
    end
end
