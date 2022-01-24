local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Styling:SecureHook(S, "HandleButton",
                   function(self, button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex,
                            frameLevel)
    Styling:HandleButton(button)
end)

if AS and false then
    Styling:SecureHook(AS, "SkinButton", function(self, button, strip)
        Styling:HandleButton(button)
    end)
end

function Styling:HandleButton(button)
    if not button then
        return
    end

    if button == _G.GraphicsButton or button == _G.RaidButton then
        Styling:HandleTab(button, nil, "UP")
        return
    end

    local parent = button:GetParent()
    if parent == _G.ChatConfigFrameChatTabManager then
        button.backdrop:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -5)
        button.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 0)
        Styling:HandleTab(button, nil, "UP")
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.BUTTON)
end

Styling:SecureHook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
    Styling:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
end)

function Styling:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.SCROLL_BAR)
end

Styling:SecureHook(S, "HandleEditBox", function(self, frame)
    Styling:HandleEditBox(frame)
end)

function Styling:HandleEditBox(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.EDIT_BOX)

    if frame.backdrop then
        frame.backdrop:SetOutside(nil, 4, 1)

        -- reposition Gold/Silver/Copper boxes
        local name = frame:GetName()
        if name then
            if strfind(name, "Gold") then
                frame.backdrop:Point("BOTTOMRIGHT", -4, -2)
            elseif strfind(name, "Silver") or strfind(name, "Copper") then
                frame.backdrop:Point("BOTTOMRIGHT", -12, -2)
            end
        end
    end
end

Styling:SecureHook(S, "HandleRadioButton", function(self, button)
    Styling:HandleRadioButton(button)
end)

function Styling:HandleRadioButton(button)
    if not button then
        return
    end

    Styling:ApplyStyle(button, Addon.STYLE_CONFIG_KEYS.RADIO_BUTTON)
end

Styling:SecureHook(S, "HandleCheckBox", function(self, frame, noBackdrop, noReplaceTextures, frameLevel)
    Styling:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
end)

function Styling:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.CHECK_BOX)
    local border = frame:GetBorder()
    if border then
        border:SetDrawLayer("OVERLAY")
    end
end

Styling:SecureHook(S, "HandleDropDownBox", function(self, frame, width, pos)
    Styling:HandleDropDownBox(frame)
end)

function Styling:HandleDropDownBox(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.DROP_DOWN_BOX)

    local name = frame.GetName and frame:GetName()
    local button = frame.Button or (name and (_G[name .. "Button"] or _G[name .. "_Button"])) or (frame.obj and frame.obj.button)
    if button and button.backdrop then
        button.backdrop:Hide()
    end
end

Styling:SecureHook(nil, "ToggleDropDownMenu", function(level)
    Styling:HandleDropDownList(_G["DropDownList" .. (level or 1)])
end)

function Styling:HandleDropDownList(listFrame, isAce3)
    if not listFrame then
        return
    end

    Styling:ApplyStyle(listFrame, Addon.STYLE_CONFIG_KEYS.DROP_DOWN_LIST)

    if not isAce3 then
        local name = listFrame:GetName()
        for i = 1, _G.UIDROPDOWNMENU_MAXBUTTONS do
            local button = _G[name .. "Button" .. i]
            local text = _G[name .. "Button" .. i .. "NormalText"]
            local border = button:CreateBorder(Addon.STYLE_CONFIG_KEYS.DROP_DOWN_LIST_BUTTON)

            button.backdrop = CreateFrame("Frame", nil, button)

            if not button.notCheckable then
                local check = _G[name .. "Button" .. i .. "Check"]
                local _, co = check:GetTexCoord()
                if co == 0 then
                    border:Hide()
                else
                    text:SetPoint("LEFT", 15, 0)
                    border:Show()
                    border:SetOutside(check)
                    border:SetColor(E.media.bordercolor)
                end
            else
                text:SetPoint("LEFT", -5, 0)
                border:Hide()
            end
        end
    end
end

Styling:SecureHook(S, "HandleSliderFrame", function(self, frame)
    Styling:HandleSliderFrame(frame, color)
end)

function Styling:HandleSliderFrame(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.SLIDER)

    if frame.backdrop then
        frame.backdrop:SetOutside(nil, 1, 0)
    end
end

Styling:SecureHook(S, "HandleStatusBar", function(self, frame, color)
    Styling:HandleStatusBar(frame, color)
end)

--Styling:SecureHook(E, "RegisterStatusBar", function(self, frame, color)
--    Styling:HandleStatusBar(frame, color)
--end)

function Styling:HandleStatusBar(bar)
    if not bar then
        return
    end

    Styling:ApplyStyle(bar, Addon.STYLE_CONFIG_KEYS.STATUS_BAR)

    local border = bar:GetBorder()
    if border then
        border:SetDrawLayer("OVERLAY")
    end
end

function Styling:HandleColorPicker(frame)
    if not frame then
        return
    end

    Styling:ApplyStyle(frame, Addon.STYLE_CONFIG_KEYS.COLOR_PICKER)
end
