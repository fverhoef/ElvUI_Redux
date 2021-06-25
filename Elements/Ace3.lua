local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

Addon:SecureHook(S, "Ace3_RegisterAsContainer", function(self, widget)
    if widget.type == "ScrollFrame" then
        RaiseFrameLevel(widget.scrollbar)
    elseif widget.type == "DropdownGroup" then
        local frame = widget.content:GetParent()
        Addon:HandleInsetFrame(frame)
        RaiseFrameLevel(frame)
    elseif widget.type == "Frame" then
        local frame = widget.content:GetParent()
        Addon:HandleFrame(frame)
    elseif widget.type == "InlineGroup" then
        local frame = widget.content:GetParent()
        Addon:HandleInsetFrame(frame)
        RaiseFrameLevel(frame)
    elseif widget.type == "TabGroup" then
        local frame = widget.content:GetParent()
        Addon:HandleInsetFrame(frame)
        RaiseFrameLevel(frame)
    elseif widget.type == "TreeGroup" then
        local frame = widget.content:GetParent()
        Addon:HandleInsetFrame(frame)
        RaiseFrameLevel(frame)

        if widget.treeframe then
            Addon:HandleInsetFrame(widget.treeframe)
            RaiseFrameLevel(widget.treeframe)
        end
    elseif widget.type == "SimpleGroup" then
        local frame = widget.content:GetParent()
        Addon:HandleInsetFrame(frame)
        RaiseFrameLevel(frame)
    end
end)

Addon:SecureHook(S, "Ace3_RegisterAsWidget", function(self, widget)
    if widget.type == "Button" or widget.type == "Button-ElvUI" then
        RaiseFrameLevel(widget.frame)
    elseif widget.type == "CheckBox" then
        -- TODO: fix Ace3 checkbox shadow
        -- local shadow = Addon:CreateShadow(widget.checkbg)
        local border = Addon:CreateBorder(widget.checkbg.backdrop, Addon.BORDER_CONFIG_KEYS.CHECK_BOX)
        border:SetOutside(widget.checkbg.backdrop, 3, 3)
    elseif widget.type == "ColorPicker" or widget.type == "ColorPicker-ElvUI" then
        Addon:HandleColorPicker(widget.frame)
        widget.frame.border:SetDrawLayer("OVERLAY")

        widget.colorSwatch:SetInside(widget.frame.backdrop, 2, 2)
        if widget.colorSwatch.checkers then
            widget.colorSwatch.checkers:SetInside(widget.frame.backdrop, 2, 2)
        end
    elseif widget.type == "Dropdown" or widget.type == "LQDropdown" then
        Addon:HandleDropDownBox(widget.dropdown)
        RaiseFrameLevel(widget.dropdown)
    elseif widget.type == "Dropdown-Pullout" then
        Addon:HandleDropDownList(widget.frame, true)
        RaiseFrameLevel(widget.frame)
        if widget.slider then
            Addon:HandleSliderFrame(widget.slider)
            RaiseFrameLevel(widget.slider)
        end
    elseif widget.type == "EditBox" then
        RaiseFrameLevel(widget.editbox)
        RaiseFrameLevel(widget.button)
    elseif widget.type == "Keybinding" then
        RaiseFrameLevel(widget.button)
        Addon:HandleFrame(widget.msgframe)
    elseif strfind(widget.type, "LSM30_") then
        widget.frame.backdrop:SetFrameLevel(0)
        Addon:HandleDropDownBox(widget.frame)

        if widget.type ~= "LSM30_Statusbar" then
            -- Addon:HandleFrame(widget.frame.dropButton)
        end
    elseif widget.type == "MultiLineEditBox" or widget.type == "MultiLineEditBox-ElvUI" then
        RaiseFrameLevel(widget.button)
        Addon:HandleInsetFrame(widget.scrollBG)
        RaiseFrameLevel(widget.scrollBG)
        RaiseFrameLevel(widget.scrollBar)
        RaiseFrameLevel(widget.editBox)
    elseif widget.type == "Slider" or widget.type == "Slider-ElvUI" then
        RaiseFrameLevel(widget.slider)
        Addon:HandleEditBox(widget.editbox)
        RaiseFrameLevel(widget.editbox)
    end
end)

-- NOTE: this is only called in the OnClick handler for LSM dropdowns
Addon:SecureHook(S, "Ace3_SkinDropdown", function(self)
    local widget = self.obj
    if not widget then
        return
    end

    if widget.dropdown then
        Addon:HandleDropDownList(widget.dropdown.frame or widget.dropdown, true)

        if widget.dropdown.slider then
            Addon:HandleSliderFrame(widget.dropdown.slider)
        end
    end
end)

Addon:SecureHook(S, "Ace3_SkinTab", function(self, tab)
    Addon:HandleTab(tab, false, "UP")
    local border = tab.border
    border:SetPoint("TOPLEFT", border.parent, "TOPLEFT", -2, 0)
    border:SetPoint("BOTTOMRIGHT", border.parent, "BOTTOMRIGHT", 2, 0)
    RaiseFrameLevel(tab)
end)

Addon:SecureHook(S, "Ace3_StylePopup", function(self)
    Addon:HandleFrame(self)
end)

Addon:SecureHook(S, "Ace3_StyleTooltip", function(self)
    Addon:HandleToolTip(self)
end)

Addon:SecureHook(E, "Config_WindowOpened", function(self, frame)
    if frame.leftHolder then
        frame.leftHolder:SetBackdrop()
    end
    if frame.topHolder then
        frame.topHolder:SetBackdrop()
    end
    if frame.bottomHolder then
        -- frame.bottomHolder:SetBackdrop()
    end

    local holderHeight = frame.bottomHolder:GetHeight()
    local content = frame.obj.content
    content:ClearAllPoints()
    content:Point("TOPLEFT", frame, "TOPLEFT", 8, -40)
    content:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, holderHeight + 6)
end)
