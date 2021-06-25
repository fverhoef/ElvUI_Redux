local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Addon:SecureHook(S, "HandleFrame", function(self, frame, setBackdrop, template, x1, y1, x2, y2)
    if string.match(frame:GetName() or "", "FriendsTabHeaderTab") then
        Addon:HandleTab(frame)
    else
        Addon:HandleFrame(frame)
    end
end)

Addon:SecureHook(S, "HandlePortraitFrame", function(self, frame, setTemplate)
    Addon:HandleFrame(frame, true)
end)

Addon:SecureHook(S, "HandleMaxMinFrame", function(self, frame)
    Addon:HandleFrame(frame)
end)

Addon:SecureHook(E, "StaticPopupSpecial_Show", function(self, frame)
    Addon:HandleFrame(frame)
end)

if AS and false then
    Addon:SecureHook(AS, "SkinFrame", function(self, frame, template, override, kill)
        Addon:HandleFrame(frame)
    end)

    Addon:SecureHook(AS, "SkinCloseButton", function(self, button, reposition)
        Addon:HandleCloseButton(button)
    end)
end

function Addon:HandleFrame(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.FRAME)
end

Addon:SecureHook(S, "HandleInsetFrame", function(self, frame)
    --Addon:HandleInsetFrame(frame)
end)

function Addon:HandleInsetFrame(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.INSET_FRAME)
end

Addon:SecureHook(S, "HandleTab", function(self, tab, noBackdrop)
    local orientation = "DOWN"
    local name = tab and tab:GetName() or ""
    if string.match(name, "InspectTalentFrameTab") or string.match(name, "CombatConfigTab") then
        orientation = "UP"
    end
    
    Addon:HandleTab(tab, noBackdrop, orientation)
end)

function Addon:HandleTab(tab, noBackdrop, orientation)
    if not tab then
        return
    end

    tab.orientation = orientation

    Addon:CreateShadow(tab)
    local border = Addon:CreateBorder(tab, Addon.BORDER_CONFIG_KEYS.TAB)

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

Addon:SecureHook(S, "HandleCloseButton", function(self, button, point, x, y)
    Addon:HandleCloseButton(button)
end)

function Addon:HandleCloseButton(button)
    if not button then
        return
    end
end

Addon:SecureHook(S, "HandleRotateButton", function(self, button)
    Addon:HandleButton(button, true)
end)

function Addon:HandleChatPanel(panel)
    if not panel then
        return
    end

    Addon:CreateShadow(panel)
    local border = Addon:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.CHAT_PANEL)

    if panel == _G.LeftChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "RIGHT") then
        border:Hide()
    end
    if panel == _G.RightChatPanel and (CH.db.panelBackdrop == "HIDEBOTH" or CH.db.panelBackdrop == "LEFT") then
        border:Hide()
    end
end

function Addon:HandleDecorativePanel(panel, location)
    if not panel then
        return
    end

    Addon:CreateShadow(panel)
    local border = Addon:CreateBorder(panel, Addon.BORDER_CONFIG_KEYS.DECORATIVE_PANEL)

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

Addon:SecureHook(S, "HandleIcon", function(self, icon, backdrop)
    Addon:HandleIcon(icon, backdrop)
end)

Addon:SecureHook(S, "HandleIconSelectionFrame", function(self, frame, numIcons, buttonNameTemplate, frameNameOverride)
    Addon:HandleFrame(frame)

    for i = 1, numIcons do
        Addon:HandleIcon(_G[buttonNameTemplate .. i])
    end
end)

function Addon:HandleIcon(icon, backdrop)
    if not icon then
        return
    end

    if icon.backdrop then
        Addon:CreateShadow(icon.backdrop)
        local border = Addon:CreateBorder(icon.backdrop, Addon.BORDER_CONFIG_KEYS.ICON)
        border.frameLevel = (icon.GetFrameLevel and icon:GetFrameLevel() or icon:GetParent():GetFrameLevel()) + 4
        border:Update()
    end
end
