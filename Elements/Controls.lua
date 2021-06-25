local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Addon:SecureHook(S, "HandleButton",
                 function(self, button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex,
                          frameLevel)
    Addon:HandleButton(button)
end)

if AS and false then
    Addon:SecureHook(AS, "SkinButton", function(self, button, strip)
        Addon:HandleButton(button)
    end)
end

function Addon:HandleButton(button)
    if not button then
        return
    end

    if button == _G.GraphicsButton or button == _G.RaidButton then
        Addon:HandleTab(button, nil, "UP")
        return
    end

    local parent = button:GetParent()
    if parent == _G.ChatConfigFrameChatTabManager then
        button.backdrop:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -5)
        button.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 0)
        Addon:HandleTab(button, nil, "UP")
        return
    elseif button.obj and (button.obj.type == "Dropdown" or strfind(button.obj.type, "LSM30_")) then
        -- Don't skin Ace3 dropdown buttons on this pass (to prevent layering issues)
        return
    end

    Addon:CreateShadow(button)
    local border = Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.BUTTON)
    if button == _G.ChatFrameChannelButton then
        border:SetShown(not CH.db.pinVoiceButtons)
    end
end

Addon:SecureHook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
    Addon:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
end)

function Addon:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.SCROLL_BAR)
end

Addon:SecureHook(S, "HandleEditBox", function(self, frame)
    Addon:HandleEditBox(frame)
end)

function Addon:HandleEditBox(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.EDIT_BOX)

    if frame.backdrop then
        frame.backdrop:SetOutside(nil, 4, 1)

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

Addon:SecureHook(S, "HandleRadioButton", function(self, button)
    Addon:HandleRadioButton(button)
end)

function Addon:HandleRadioButton(button)
    if not button then
        return
    end

    -- Addon:CreateShadow(button)
    -- Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.RADIO_BUTTON)
end

Addon:SecureHook(S, "HandleCheckBox", function(self, frame, noBackdrop, noReplaceTextures, frameLevel)
    Addon:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
end)

function Addon:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.CHECK_BOX)
end

Addon:SecureHook(S, "HandleDropDownBox", function(self, frame, width, pos)
    Addon:HandleDropDownBox(frame)
end)

function Addon:HandleDropDownBox(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.DROP_DOWN_BOX)

    local name = frame.GetName and frame:GetName()
    local button = frame.Button or (name and (_G[name .. "Button"] or _G[name .. "_Button"])) or (frame.obj and frame.obj.button)
    if button then
        button.backdrop:Hide()
    end
end

Addon:SecureHook(nil, "ToggleDropDownMenu", function(level)
    Addon:HandleDropDownList(_G["DropDownList" .. (level or 1)])
end)

function Addon:HandleDropDownList(listFrame, isAce3)
    if not listFrame then
        return
    end

    if not isAce3 then
        listFrame:CreateBackdrop("Transparent")
    end

    Addon:CreateShadow(listFrame)
    Addon:CreateBorder(listFrame, Addon.BORDER_CONFIG_KEYS.DROP_DOWN_LIST)

    if not isAce3 then
        local name = listFrame:GetName()
        for i = 1, _G.UIDROPDOWNMENU_MAXBUTTONS do
            local button = _G[name .. "Button" .. i]
            local text = _G[name .. "Button" .. i .. "NormalText"]
            local border = Addon:CreateBorder(button, Addon.BORDER_CONFIG_KEYS.DROP_DOWN_LIST_BUTTON)

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
                    border:SetBorderColor(E.media.bordercolor)
                end
            else
                text:SetPoint("LEFT", -5, 0)
                border:Hide()
            end
        end

        local backdrop = _G[name .. "Backdrop"]
        if backdrop then
            backdrop:SetBackdrop()
        end

        local menuBackdrop = _G[name .. "MenuBackdrop"]
        if menuBackdrop then
            menuBackdrop:SetBackdrop()
        end
    end
end

Addon:SecureHook(S, "HandleSliderFrame", function(self, frame)
    Addon:HandleSliderFrame(frame, color)
end)

function Addon:HandleSliderFrame(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.SLIDER)

    if frame.backdrop then
        frame.backdrop:SetOutside(nil, 1, 0)
    end
end

Addon:SecureHook(S, "HandleStatusBar", function(self, frame, color)
    Addon:HandleStatusBar(frame, color)
end)

Addon:SecureHook(E, "RegisterStatusBar", function(self, frame, color)
    Addon:HandleStatusBar(frame, color)
end)

function Addon:HandleStatusBar(bar)
    if not bar then
        return
    end

    Addon:CreateShadow(bar)
    Addon:CreateBorder(bar, Addon.BORDER_CONFIG_KEYS.STATUS_BAR)
end

function Addon:HandleColorPicker(frame)
    if not frame then
        return
    end

    Addon:CreateShadow(frame)
    Addon:CreateBorder(frame, Addon.BORDER_CONFIG_KEYS.COLOR_PICKER)
end
