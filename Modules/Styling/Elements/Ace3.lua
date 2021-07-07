local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon.Styling
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

Styling:SecureHook(S, "Ace3_RegisterAsContainer", function(self, widget)
    local frame = widget.content:GetParent()
    if widget.type == "ScrollFrame" then
        Styling:HandleInsetFrame(frame)
    elseif widget.type == "DropdownGroup" then
        Styling:HandleInsetFrame(frame)
    elseif widget.type == "Frame" then
        Styling:HandleFrame(frame)
    elseif widget.type == "InlineGroup" then
        Styling:HandleInsetFrame(frame)
    elseif widget.type == "TabGroup" then
        Styling:HandleInsetFrame(frame)
    elseif widget.type == "TreeGroup" then
        Styling:HandleInsetFrame(frame)

        if widget.treeframe then
            Styling:HandleInsetFrame(widget.treeframe)
        end
    elseif widget.type == "SimpleGroup" then
        Styling:HandleInsetFrame(frame)
    end
end)

Styling:SecureHook(S, "Ace3_RegisterAsWidget", function(self, widget)
    if widget.type == "Button" or widget.type == "Button-ElvUI" then
        -- Nothing to do here
    elseif widget.type == "CheckBox" then
        local border = widget.checkbg:GetBorder()
        border:SetOutside(nil, 1, 1)
    elseif widget.type == "ColorPicker" or widget.type == "ColorPicker-ElvUI" then
        Styling:HandleColorPicker(widget.frame)

        widget.colorSwatch:SetInside(widget.frame.backdrop, 2, 2)
        if widget.colorSwatch.checkers then
            widget.colorSwatch.checkers:SetInside(widget.frame.backdrop, 2, 2)
        end
    elseif widget.type == "Dropdown" or widget.type == "LQDropdown" then
        Styling:HandleDropDownBox(widget.dropdown)
    elseif widget.type == "Dropdown-Pullout" then
        Styling:HandleDropDownList(widget.frame, true)
        if widget.slider then
            Styling:HandleSliderFrame(widget.slider)
        end
    elseif widget.type == "EditBox" then
        -- Nothing to do here
    elseif widget.type == "Keybinding" then
        Styling:HandleFrame(widget.msgframe)
    elseif strfind(widget.type, "LSM30_") then
        Styling:HandleDropDownBox(widget.frame)
        if widget.frame.dropButton and widget.frame.dropButton.backdrop then
            widget.frame.dropButton.backdrop:SetTemplate("NoBackdrop")
        end
    elseif widget.type == "MultiLineEditBox" or widget.type == "MultiLineEditBox-ElvUI" then
        Styling:HandleInsetFrame(widget.scrollBG)
    elseif widget.type == "Slider" or widget.type == "Slider-ElvUI" then
        Styling:HandleEditBox(widget.editbox)
    end
end)

-- NOTE: this is only called in the OnClick handler for LSM dropdowns
Styling:SecureHook(S, "Ace3_SkinDropdown", function(self)
    local widget = self.obj
    if not widget then
        return
    end

    if widget.dropdown then
        Styling:HandleDropDownList(widget.dropdown.frame or widget.dropdown, true)

        if widget.dropdown.slider then
            Styling:HandleSliderFrame(widget.dropdown.slider)
        end
    end
end)

Styling:SecureHook(S, "Ace3_SkinTab", function(self, tab)
    Styling:HandleTab(tab, false, "UP")
end)

Styling:SecureHook(S, "Ace3_StylePopup", function(self)
    Styling:HandleFrame(self)
end)

Styling:SecureHook(S, "Ace3_StyleTooltip", function(self)
    Styling:HandleToolTip(self)
end)

Styling:SecureHook(E, "Config_WindowOpened", function(self, frame)
    if frame.leftHolder then
        frame.leftHolder:SetTemplate("NoBackdrop")
    end
    if frame.topHolder then
        frame.topHolder:SetTemplate("NoBackdrop")
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
