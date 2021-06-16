local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)
local AS = AS and unpack(AddOnSkins)
local CH = E:GetModule("Chat")
local S = E:GetModule("Skins")

Skins:SecureHook(S, "HandleButton",
                 function(self, button, strip, isDeclineButton, noStyle, setTemplate, styleTemplate, noGlossTex, overrideTex,
                          frameLevel)
    Skins:HandleButton(button)
end)

if AS and false then
    Skins:SecureHook(AS, "SkinButton", function(self, button, strip)
        Skins:HandleButton(button)
    end)
end

function Skins:HandleButton(button, setBorderLevel)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    local border = Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))

    if setBorderLevel then
        border:SetFrameLevel(button:GetFrameLevel() + 1)
    end

    if button == _G.ChatFrameChannelButton then
        border:SetShown(not CH.db.pinVoiceButtons)
    end
end

Skins:Hook(S, "HandleScrollBar", function(self, frame, thumbTrimY, thumbTrimX)
    Skins:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
end)

function Skins:HandleScrollBar(frame, thumbTrimY, thumbTrimX)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(frame))
end

Skins:SecureHook(S, "HandleEditBox", function(self, frame)
    Skins:HandleEditBox(frame)
end)

function Skins:HandleEditBox(frame)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(frame))
end

Skins:SecureHook(S, "HandleDropDownBox", function(self, frame, width, pos)
    Skins:HandleDropDownBox(frame)
end)

function Skins:HandleDropDownBox(frame, width, pos)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    Skins:CreateBorder(frame, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(frame))
end

Skins:SecureHook(S, "HandleRadioButton", function(self, button)
    Skins:HandleRadioButton(button)
end)

function Skins:HandleRadioButton(button)
    if not button then
        return
    end

    Skins:CreateShadow(button)
    Skins:CreateBorder(button, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(button))
end

Skins:SecureHook(S, "HandleCheckBox", function(self, frame, noBackdrop, noReplaceTextures, frameLevel)
    Skins:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
end)

function Skins:HandleCheckBox(frame, noBackdrop, noReplaceTextures, frameLevel)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    local border = Skins:CreateBorder(frame, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(frame))
    border:SetFrameLevel(frame:GetFrameLevel() + 1)
end

Skins:SecureHook(nil, "ToggleDropDownMenu", function(level)
    Skins:HandleDropDownList(_G["DropDownList" .. (level or 1)])
end)

function Skins:HandleDropDownList(listFrame)
    if not listFrame then
        return
    end

    Skins:CreateShadow(listFrame)
    Skins:CreateBorder(listFrame, Skins:GetButtonBorderAtlas(), Skins:GetBorderColor(listFrame))
end

Skins:SecureHook(S, "HandleSliderFrame", function(self, frame)
    Skins:HandleSliderFrame(frame, color)
end)

function Skins:HandleSliderFrame(frame)
    if not frame then
        return
    end

    Skins:CreateShadow(frame)
    local border = Skins:CreateBorder(frame, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(frame))
    border:SetFrameLevel(frame:GetFrameLevel() + 1)
end

Skins:SecureHook(S, "HandleStatusBar", function(self, frame, color)
    Skins:HandleStatusBar(frame, color)
end)

function Skins:HandleStatusBar(bar)
    if not bar then
        return
    end

    Skins:CreateShadow(bar)
    local border = Skins:CreateBorder(bar, Skins:GetFrameBorderAtlas(), Skins:GetBorderColor(bar))

    if border and border:IsShown() then
        local borderColor = {border:GetBorderColor()}
        border:HideOriginalBackdrop(true)
        border:SetBorderColor(unpack(borderColor))
    end
end
