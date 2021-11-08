local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Styling:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    if string.match(frame:GetName() or "", "FriendsTabHeaderTab") then
        Styling:HandleTab(frame)
    else
        Styling:HandleFrame(frame)
    end
end)

Styling:SecureHook(S, "HandlePortraitFrame", function(self, frame, setTemplate)
    Styling:HandleFrame(frame, true)
end)

Styling:SecureHook(S, "HandleMaxMinFrame", function(self, frame)
    Styling:HandleFrame(frame)
end)

Styling:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Styling:HandleFrame(frame)
end)

if AS and false then
    Styling:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        Styling:HandleFrame(frame)
    end)

    Styling:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Styling:HandleCloseButton(button)
    end)
end

function Styling:HandleFrame(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.FRAME)
end

Styling:SecureHook(S, "HandleInsetFrame", function(self, frame)
    -- Styling:HandleInsetFrame(frame)
end)

function Styling:HandleInsetFrame(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.INSET_FRAME)
end

Styling:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    local orientation = "DOWN"
    local name = tab and tab:GetName() or ""
    if string.match(name, "InspectTalentFrameTab") or string.match(name, "CombatConfigTab") then
        orientation = "UP"
    end

    Styling:HandleTab(tab, noBackdrop, orientation)
end)

function Styling:HandleTab(tab, noBackdrop, orientation)
    if not tab then
        return
    end

    tab.orientation = orientation

    Styling:ApplyStyle(tab, Addon.STYLE_CONFIG_KEYS.TAB)

    local border = tab:GetBorder()
    if not border then
        return
    end
    
    local parent = border:GetParent()

    if orientation == "UP" then
        border.Bottom:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Left:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 0, 2)
        border.Right:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 2)
        parent:Offset("BOTTOMRIGHT", 0, -1)
    elseif orientation == "DOWN" then
        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()

        border.Left:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -2)
        border.Right:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, -2)
        parent:Offset("TOPLEFT", 0, 1)
    elseif orientation == "LEFT" then
        border.Right:Hide()
        border.TopRight:Hide()
        border.BottomRight:Hide()

        border.Top:SetPoint("TOPRIGHT", parent, "TOPRIGHT")
        border.Bottom:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
    elseif orientation == "RIGHT" then
        border.Left:Hide()
        border.TopLeft:Hide()
        border.BottomLeft:Hide()

        border.Top:SetPoint("TOPLEFT", parent, "TOPLEFT")
        border.Bottom:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT")
    end
end

Styling:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Styling:HandleCloseButton(button)
end)

function Styling:HandleCloseButton(button)
    if not button then
        return
    end
end

Styling:SecureHook(S, "HandleRotateButton", function(self, button)
    Styling:HandleButton(button, true)
end)

function Styling:HandleChatPanel(panel)
    if not panel then
        return
    end

    Styling:ApplyStyle(panel, Addon.STYLE_CONFIG_KEYS.CHAT_PANEL)

    local border = panel:GetBorder()

    if panel == _G.LeftChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "RIGHT") then
        border:Hide()
    end
    if panel == _G.RightChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "LEFT") then
        border:Hide()
    end
end

function Styling:HandleDecorativePanel(panel, location)
    if not panel then
        return
    end

    Styling:ApplyStyle(panel, Addon.STYLE_CONFIG_KEYS.DECORATIVE_PANEL)

    local border = panel:GetBorder()
    local parent = border:GetParent()

    if location == "TOP" then
        border.Top:Hide()
        border.TopLeft:Hide()
        border.TopRight:Hide()
        border.Left:Hide()
        border.Right:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Bottom:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT")
        border.Bottom:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")

        parent:Offset("TOPLEFT", -1, 1)
        parent:Offset("TOPRIGHT", 1, 1)
    elseif location == "BOTTOM" then
        border.TopLeft:Hide()
        border.TopRight:Hide()
        border.Left:Hide()
        border.Right:Hide()
        border.Bottom:Hide()
        border.BottomLeft:Hide()
        border.BottomRight:Hide()

        border.Top:SetPoint("TOPLEFT", parent, "TOPLEFT")
        border.Top:SetPoint("TOPRIGHT", parent, "TOPRIGHT")

        parent:Offset("BOTTOMLEFT", -1, -1)
        parent:Offset("BOTTOMRIGHT", 1, -1)
    end
end

Styling:SecureHook(S, "HandleIcon", function(self, icon, backdrop)
    Styling:HandleIcon(icon, backdrop)
end)

Styling:SecureHook(S, "HandleIconSelectionFrame", function(self, frame, numIcons, buttonNameTemplate, frameNameOverride)
    Styling:HandleFrame(frame)

    for i = 1, numIcons do
        Styling:HandleIcon(_G[buttonNameTemplate .. i])
    end
end)

function Styling:HandleIcon(icon, backdrop)
    if not icon then
        return
    end

    if icon.backdrop then
        Styling:ApplyStyle(icon, Addon.STYLE_CONFIG_KEYS.ICON)
        local border = icon:GetBorder()
        border.frameLevel = (icon.GetFrameLevel and icon:GetFrameLevel() or icon:GetParent():GetFrameLevel()) + 4
        border:SetFrameLevel(border.frameLevel)
    end
end
