local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

local BACKGROUNDS = {
    [""] = "(ElvUI)",
    ["Alliance"] = "Alliance",
    ["Horde"] = "Horde",
    ["Neutral"] = "Neutral",
    ["Marine"] = "Marine",
    ["Mechagon"] = "Mechagon",
    ["Kyrian"] = "Kyrian",
    ["Necrolord"] = "Necrolord",
    ["NightFae"] = "NightFae",
    ["Oribos"] = "Oribos",
    ["Venthyr"] = "Venthyr"
}
local BORDERS = {
    ["(ElvUI)"] = "(ElvUI)",
    ["BeautyCase"] = "BeautyCase",
    ["Cainyx"] = "Cainyx",
    ["Caith"] = "Caith",
    ["Diablo"] = "Diablo",
    ["Entropy"] = "Entropy",
    ["Goldpaw"] = "Goldpaw",
    ["Onyx"] = "Onyx",
    ["Redux"] = "Redux",
    ["Retina"] = "Retina"
}
local FRAME_BORDERS = {
    [""] = "(Inherit from Default)",
    ["(ElvUI)"] = "(ElvUI)",
    ["Alliance"] = "Alliance",
    ["Horde"] = "Horde",
    ["Neutral"] = "Neutral",
    ["Metal"] = "Metal",
    ["Marine"] = "Marine",
    ["Mechagon"] = "Mechagon",
    ["Kyrian"] = "Kyrian",
    ["Necrolord"] = "Necrolord",
    ["NightFae"] = "NightFae",
    ["Oribos"] = "Oribos",
    ["Venthyr"] = "Venthyr"
}
local STYLE_CONFIG_KEYS = {
    DEFAULT = "default",

    -- Frames
    FRAME = "frame",
    INSET_FRAME = "insetFrame",
    CHAT_PANEL = "chatPanel",
    DECORATIVE_PANEL = "decorativePanel",
    TAB = "tab",
    MINIMAP = "minimap",

    -- Controls
    BUTTON = "button",
    CHECK_BOX = "checkBox",
    COLOR_PICKER = "colorPicker",
    DROP_DOWN_BOX = "dropDownBox",
    DROP_DOWN_LIST = "dropDownList",
    DROP_DOWN_LIST_BUTTON = "dropDownListButton",
    EDIT_BOX = "editBox",
    RADIO_BUTTON = "radioButton",
    SCROLL_BAR = "scrollBar",
    SLIDER = "slider",
    STATUS_BAR = "statusBar",

    -- Action Bars
    ACTION_BAR = "actionBar",
    ACTION_BUTTON = "actionButton",
    MICRO_BUTTON = "microButton",
    LOOT_ROLL_BAR = "lootRollBar",

    -- Auras
    AURA = "aura",

    -- Bags
    BAG_SLOT = "bagSlot",
    BAG_BAR = "bagBar",

    -- Buttons
    ITEM_BUTTON = "itemButton",
    TALENT_BUTTON = "talentButton",
    RAID_UTILITY_BUTTON = "raidUtilityButton",
    ICON = "icon",

    -- Data Bars/Text
    DATA_BAR = "dataBar",
    DATA_PANEL = "dataPanel",

    -- Nameplates
    NAMEPLATE_HEALTH = "nameplateHealth",
    NAMEPLATE_POWER = "nameplatePower",
    NAMEPLATE_CASTBAR = "nameplateCastBar",

    -- Unit Frames
    UNITFRAME_HEALTH = "unitFrameHealth",
    UNITFRAME_POWER = "unitFramePower",
    UNITFRAME_CASTBAR = "unitFrameCastBar",
    UNITFRAME_CLASSBAR = "unitFrameClassBar",

    -- Tooltips
    TOOLTIP = "tooltip"
}

local BORDERS_WITH_INHERIT = {[""] = "(Inherit from Default)"}
for key, value in pairs(BORDERS) do
    BORDERS_WITH_INHERIT[key] = value
end

Addon.BACKGROUNDS = BACKGROUNDS
Addon.BORDERS = BORDERS
Addon.BORDERS_WITH_INHERIT = BORDERS_WITH_INHERIT
Addon.FRAME_BORDERS = FRAME_BORDERS
Addon.STYLE_CONFIG_KEYS = STYLE_CONFIG_KEYS

P[addonName] = {
    layout = {
        characterFrame = {enabled = true},
        classTrainerFrame = {enabled = true},
        guildMemberDetailFrame = {enabled = true},
        questLogFrame = {enabled = true},
        tradeSkillFrame = {enabled = true},
        minimapButtonFrame = {enabled = true, iconSize = 22, buttonsPerRow = 6, buttonSpacing = 2, collapsed = true},
        tooltips = {
            enabled = true,
            showIcons = true,
            showVendorPrice = true,
            showItemLevel = false,
            colors = {itemLevel = {220 / 255, 195 / 255, 30 / 255}}
        }
    },
    styling = {
        enabled = true,
        default = {
            border = {enabled = true, style = BORDERS["Redux"], scale = 1.0},
            shadow = {enabled = true, color = {0, 0, 0, 0.7}, size = 5, shadowPerButton = true}
        }
    }
}

for key, value in pairs(STYLE_CONFIG_KEYS) do
    if not P[addonName].styling[value] then
        P[addonName].styling[value] = {border = {}, shadow = {}}
    end
end

if E.db[addonName] == nil then
    E.db[addonName] = P[addonName]
end

local function GetOptionValue(setting)
    local value = E.db[addonName]
    for i, name in ipairs(setting) do
        value = value[name]
    end

    return value
end

local function GetDefaultOptionValue(setting)
    local value = P[addonName]
    for i, name in ipairs(setting) do
        value = value[name]
    end

    return value
end

local function SetOptionValue(setting, val)
    local value = E.db[addonName]
    for i, name in ipairs(setting) do
        if i == #setting then
            value[name] = val
        else
            value = value[name]
        end
    end

    return value
end

local function CreateToggleOption(caption, desc, order, width, setting, tristate, disabled, hidden)
    return {
        type = "toggle",
        name = caption,
        desc = desc,
        order = order,
        width = width,
        tristate = tristate,
        disabled = disabled,
        hidden = hidden,
        get = function(info)
            return GetOptionValue(setting)
        end,
        set = function(info, value)
            SetOptionValue(setting, value)
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateRangeOption(caption, desc, order, min, max, step, setting, disabled, hidden)
    return {
        type = "range",
        name = caption,
        desc = desc,
        order = order,
        min = min,
        max = max,
        step = step,
        disabled = disabled,
        hidden = hidden,
        get = function(info)
            return GetOptionValue(setting)
        end,
        set = function(info, value)
            SetOptionValue(setting, value)
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateColorOption(caption, order, setting, noAlpha, disabled, hidden)
    return {
        order = order,
        type = "color",
        name = caption,
        hasAlpha = not noAlpha,
        disabled = disabled,
        hidden = hidden,
        get = function(info)
            local t = GetOptionValue(setting)
            local d = GetDefaultOptionValue(setting)
            if d then
                return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
            elseif t then
                return t[1], t[2], t[3], t[4]
            end
        end,
        set = function(info, r, g, b, a)
            local t = GetOptionValue(setting)
            t[1], t[2], t[3], t[4] = r, g, b, a
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateBorderStyleOption(caption, order, setting, allowInherit, disabled, hidden)
    local values = allowInherit and BORDERS_WITH_INHERIT or BORDERS
    return {
        order = order,
        type = "select",
        name = caption,
        values = values,
        disabled = disabled,
        hidden = hidden,
        get = function()
            local optionValue = GetOptionValue(setting)
            for key, val in pairs(values) do
                if (optionValue or "") == key then
                    return key
                end
            end
        end,
        set = function(_, key)
            if key == "" then
                key = nil
            end
            SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateFrameBorderStyleOption(caption, order, setting, disabled, hidden)
    return {
        order = order,
        type = "select",
        name = caption,
        values = FRAME_BORDERS,
        disabled = disabled,
        hidden = hidden,
        get = function()
            local optionValue = GetOptionValue(setting)
            for key, val in pairs(FRAME_BORDERS) do
                if (optionValue or "") == key then
                    return key
                end
            end
        end,
        set = function(_, key)
            if key == "" then
                key = nil
            end
            SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateFrameBackgroundOption(caption, order, setting, disabled, hidden)
    return {
        order = order,
        type = "select",
        name = caption,
        values = BACKGROUNDS,
        disabled = disabled,
        hidden = hidden,
        get = function()
            local optionValue = GetOptionValue(setting)
            for key, val in pairs(BACKGROUNDS) do
                if (optionValue or "") == key then
                    return key
                end
            end
        end,
        set = function(_, key)
            if key == "" then
                key = nil
            end
            SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end

local function CreateStyleGroup(caption, order, key)
    return {
        order = order,
        type = "group",
        name = caption,
        args = {
            -- header = {type = "header", name = caption, order = 0},
            enabledDesc = {
                type = "description",
                name = "|cffFF0000NOTE|r: When the 'Enable Border' or 'Enable Shadow' checkboxes are grayed out, these settings are inherited from the default.",
                order = 1
            },
            headerBorder = {type = "header", name = "", order = 10},
            borderEnabled = CreateToggleOption(function()
                local text = L["Enable Border"]
                local isNil = GetOptionValue({"styling", key, "border", "enabled"}) == nil
                if isNil then
                    text = text .. " " ..
                               L["(Default: " ..
                                   (GetOptionValue({"styling", "default", "border", "enabled"}) and "Enabled" or "Disabled") ..
                                   ")"]
                end
                return text
            end, nil, 11, "double", {"styling", key, "border", "enabled"}, true),
            lineBreak1 = {type = "description", name = "", order = 12},
            borderStyle = CreateBorderStyleOption(L["Border Theme"], 13, {"styling", key, "border", "style"}, true),
            lineBreak2 = {type = "description", name = "", order = 14},
            overrideBorderScale = {
                type = "toggle",
                name = L["Override Border Scale"],
                order = 15,
                get = function(info)
                    return GetOptionValue({"styling", key, "border", "overrideScale"})
                end,
                set = function(info, value)
                    SetOptionValue({"styling", key, "border", "scale"}, value and 1 or nil)
                    Addon:OnSettingChanged({"styling", key, "border", "scale"})

                    SetOptionValue({"styling", key, "border", "overrideScale"}, value)
                    Addon:OnSettingChanged({"styling", key, "border", "overrideScale"})
                end,
                hidden = key == STYLE_CONFIG_KEYS.DEFAULT
            },
            borderScale = CreateRangeOption(L["Border Scale"], nil, 16, 0.5, 4, 0.1, {"styling", key, "border", "scale"}, nil,
                                            function()
                return not GetOptionValue({"styling", key, "border", "overrideScale"})
            end),
            headerShadow = {type = "header", name = "", order = 20},
            shadowEnabled = CreateToggleOption(function()
                local text = L["Enable Shadow"]
                local isNil = GetOptionValue({"styling", key, "shadow", "enabled"}) == nil
                if isNil then
                    text = text .. " " ..
                               L["(Default: " ..
                                   (GetOptionValue({"styling", "default", "shadow", "enabled"}) and "Enabled" or "Disabled") ..
                                   ")"]
                end
                return text
            end, nil, 21, "double", {"styling", key, "shadow", "enabled"}, true),
            lineBreak4 = {type = "description", name = "", order = 22},
            overrideShadowColor = {
                type = "toggle",
                name = L["Override Shadow Color"],
                order = 23,
                get = function(info)
                    return GetOptionValue({"styling", key, "shadow", "overrideShadowColor"})
                end,
                set = function(info, value)
                    SetOptionValue({"styling", key, "shadow", "color"}, value and {0, 0, 0, 0.7} or nil)
                    Addon:OnSettingChanged({"styling", key, "shadow", "color"})

                    SetOptionValue({"styling", key, "shadow", "overrideShadowColor"}, value)
                    Addon:OnSettingChanged({"styling", key, "shadow", "overrideShadowColor"})
                end
            },
            shadowColor = CreateColorOption(L["Shadow Color"], 24, {"styling", key, "shadow", "color"}, nil, nil, function()
                return not GetOptionValue({"styling", key, "shadow", "overrideShadowColor"})
            end),
            lineBreak5 = {type = "description", name = "", order = 25},
            overrideShadowSize = {
                type = "toggle",
                name = L["Override Shadow Size"],
                order = 26,
                get = function(info)
                    return GetOptionValue({"styling", key, "shadow", "overrideShadowSize"})
                end,
                set = function(info, value)
                    SetOptionValue({"styling", key, "shadow", "size"}, value and 5 or nil)
                    Addon:OnSettingChanged({"styling", key, "shadow", "size"})

                    SetOptionValue({"styling", key, "shadow", "overrideShadowSize"}, value)
                    Addon:OnSettingChanged({"styling", key, "shadow", "overrideShadowSize"})
                end
            },
            shadowSize = CreateRangeOption(L["Shadow Size"], nil, 27, 3, 30, 1, {"styling", key, "shadow", "size"}, nil,
                                           function()
                return not GetOptionValue({"styling", key, "shadow", "overrideShadowSize"})
            end)
        }
    }
end

function Addon:InsertOptions()
    local options = {
        order = 100,
        type = "group",
        name = Addon.title,
        childGroups = "tab",
        args = {
            name = {order = 1, type = "header", name = Addon.title},
            layout = {
                order = 10,
                type = "group",
                name = L["Layout"],
                args = {
                    frameCustomization = {
                        order = 10,
                        type = "group",
                        name = L["Frame Customization"],
                        inline = true,
                        args = {
                            characterFrame = CreateToggleOption(L["Retail-style Character Frame"], nil, 1, "full",
                                                                {"layout", "characterFrame", "enabled"}),
                            classTrainerFrame = CreateToggleOption(L["Larger Trainer Frame"], nil, 2, "full",
                                                                   {"layout", "classTrainerFrame", "enabled"}),
                            tradeSkillFrame = CreateToggleOption(L["Larger Profession Frame"], nil, 3, "full",
                                                                 {"layout", "tradeSkillFrame", "enabled"}),
                            questLogFrame = CreateToggleOption(L["Larger Quest Log"], nil, 4, "full",
                                                               {"layout", "questLogFrame", "enabled"}),
                            guildMemberDetailFrame = CreateToggleOption(L["Add Icons to Guild Member Frame"], nil, 5, "full",
                                                                        {"layout", "guildMemberDetailFrame", "enabled"})
                        }
                    },
                    minimapButtonFrame = {
                        order = 20,
                        type = "group",
                        name = L["Minimap Button Frame"],
                        inline = true,
                        args = {
                            enabled = CreateToggleOption(L["Enabled"], nil, 1, nil, {"layout", "minimapButtonFrame", "enabled"}),
                            lineBreak = {type = "header", name = "", order = 2},
                            iconSize = CreateRangeOption(L["Icon Size"], nil, 11, 4, 100, 1,
                                                         {"layout", "minimapButtonFrame", "iconSize"}),
                            buttonSpacing = CreateRangeOption(L["Button Spacing"], nil, 12, 0, 10, 1,
                                                              {"layout", "minimapButtonFrame", "buttonSpacing"}),
                            buttonsPerRow = CreateRangeOption(L["Buttons per Row"], nil, 13, 1, 50, 1,
                                                              {"layout", "minimapButtonFrame", "buttonsPerRow"})
                        }
                    },
                    tooltips = {
                        order = 40,
                        type = "group",
                        name = L["Tooltips"],
                        inline = true,
                        args = {
                            enabled = CreateToggleOption(L["Enabled"], nil, 1, nil, {"layout", "tooltips", "enabled"}),
                            lineBreak = {type = "header", name = "", order = 2},
                            showIcons = CreateToggleOption(L["Show Icons"], nil, 10, "full", {"layout", "tooltips", "showIcons"},
                                                           false, function()
                                return not GetOptionValue({"layout", "tooltips", "enabled"})
                            end),
                            showVendorPrice = CreateToggleOption(L["Show Vendor Price"], nil, 11, "full",
                                                                 {"layout", "tooltips", "showVendorPrice"}, false, function()
                                return not GetOptionValue({"layout", "tooltips", "enabled"})
                            end),
                            showItemLevel = CreateToggleOption(L["Show Item Level"], nil, 12, "full",
                                                               {"layout", "tooltips", "showItemLevel"}, false, function()
                                return not GetOptionValue({"layout", "tooltips", "enabled"})
                            end)
                        }
                    }
                }
            },
            styling = {
                order = 20,
                type = "group",
                name = L["Styling"],
                args = {
                    enabled = CreateToggleOption(L["Enabled"], nil, 0, nil, {"styling", "enabled"}),
                    defaultStyle = {
                        order = 2,
                        type = "group",
                        name = L["Default Style"],
                        inline = true,
                        args = {
                            borderEnabled = CreateToggleOption(L["Enable Border"], nil, 1, nil,
                                                               {"styling", "default", "border", "enabled"}),
                            lineBreak1 = {type = "description", name = "", order = 2},
                            borderStyle = CreateBorderStyleOption(L["Border Theme"], 3, {"styling", "default", "border", "style"}),
                            borderScale = CreateRangeOption(L["Border Scale"], nil, 4, 0.5, 4, 0.1,
                                                            {"styling", "default", "border", "scale"}),
                            shadowHeader = {type = "header", name = "", order = 10},
                            shadowEnabled = CreateToggleOption(L["Enable Shadow"], nil, 11, nil,
                                                               {"styling", "default", "shadow", "enabled"}),
                            lineBreak2 = {type = "description", name = "", order = 12},
                            shadowColor = CreateColorOption(L["Shadow Color"], 13, {"styling", "default", "shadow", "color"}),
                            shadowSize = CreateRangeOption(L["Shadow Size"], nil, 14, 3, 30, 1,
                                                           {"styling", "default", "shadow", "size"}),
                            lineBreak3 = {type = "description", name = "", order = 15},
                            shadowPerButton = CreateToggleOption(L["Shadow Per Button"], nil, 16, nil,
                                                                 {"styling", "default", "shadow", "shadowPerButton"})
                        }
                    },
                    lineBreak1 = {type = "header", name = "Style Overrides", order = 10},
                    bars = {
                        order = 11,
                        type = "group",
                        name = L["Bars"],
                        childGroups = "select",
                        args = {
                            actionBar = CreateStyleGroup(L["Action Bar Style"], 1, STYLE_CONFIG_KEYS.ACTION_BAR),
                            dataBar = CreateStyleGroup(L["Data Bar Style"], 1, STYLE_CONFIG_KEYS.DATA_BAR),
                            lootRollBar = CreateStyleGroup(L["Loot Roll Bar Style"], 4, STYLE_CONFIG_KEYS.LOOT_ROLL_BAR)
                        }
                    },
                    buttons = {
                        order = 12,
                        type = "group",
                        name = L["Buttons"],
                        childGroups = "select",
                        args = {
                            button = CreateStyleGroup(L["Button Style"], 1, STYLE_CONFIG_KEYS.BUTTON),
                            actionButton = CreateStyleGroup(L["Action Button Style"], 2, STYLE_CONFIG_KEYS.ACTION_BUTTON),
                            microButton = CreateStyleGroup(L["Micro Button Style"], 3, STYLE_CONFIG_KEYS.MICRO_BUTTON),
                            itemButton = CreateStyleGroup(L["Item Button Style"], 4, STYLE_CONFIG_KEYS.ITEM_BUTTON),
                            talentButton = CreateStyleGroup(L["Talent Button Style"], 5, STYLE_CONFIG_KEYS.TALENT_BUTTON),
                            raidUtilityButton = CreateStyleGroup(L["Raid Utility Button Style"], 6,
                                                                 STYLE_CONFIG_KEYS.RAID_UTILITY_BUTTON),
                            bagSlot = CreateStyleGroup(L["Bag Slot Style"], 7, STYLE_CONFIG_KEYS.BAG_SLOT),
                            bagBar = CreateStyleGroup(L["Bag Button Style"], 8, STYLE_CONFIG_KEYS.BAG_BAR),
                            icon = CreateStyleGroup(L["Icon Style"], 9, STYLE_CONFIG_KEYS.ICON),
                            aura = CreateStyleGroup(L["Aura Style"], 10, STYLE_CONFIG_KEYS.AURA)
                        }
                    },
                    controls = {
                        order = 13,
                        type = "group",
                        name = L["Controls"],
                        childGroups = "select",
                        args = {
                            checkBox = CreateStyleGroup(L["Checkbox Style"], 2, STYLE_CONFIG_KEYS.CHECK_BOX),
                            colorPicker = CreateStyleGroup(L["Color Picker Style"], 3, STYLE_CONFIG_KEYS.COLOR_PICKER),
                            dropDownBox = CreateStyleGroup(L["Dropdown Box Style"], 4, STYLE_CONFIG_KEYS.DROP_DOWN_BOX),
                            dropDownList = CreateStyleGroup(L["Dropdown List Style"], 5, STYLE_CONFIG_KEYS.DROP_DOWN_LIST),
                            dropDownListButton = CreateStyleGroup(L["Dropdown List Button Style"], 6,
                                                                  STYLE_CONFIG_KEYS.DROP_DOWN_LIST_BUTTON),
                            editBox = CreateStyleGroup(L["Editbox Style"], 7, STYLE_CONFIG_KEYS.EDIT_BOX),
                            radioButton = CreateStyleGroup(L["Radio Button Style"], 8, STYLE_CONFIG_KEYS.RADIO_BUTTON),
                            scrollBar = CreateStyleGroup(L["Scrollbar Style"], 9, STYLE_CONFIG_KEYS.SCROLL_BAR),
                            slider = CreateStyleGroup(L["Slider Style"], 10, STYLE_CONFIG_KEYS.SLIDER),
                            statusBar = CreateStyleGroup(L["Statusbar Style"], 11, STYLE_CONFIG_KEYS.STATUS_BAR)
                        }
                    },
                    frames = {
                        order = 14,
                        type = "group",
                        name = L["Frames"],
                        childGroups = "select",
                        args = {
                            frame = CreateStyleGroup(L["Frame Style"], 1, STYLE_CONFIG_KEYS.FRAME),
                            frameTab = CreateStyleGroup(L["Frame Tab Style"], 2, STYLE_CONFIG_KEYS.TAB),
                            insetFrame = CreateStyleGroup(L["Inset Frame Style"], 3, STYLE_CONFIG_KEYS.INSET_FRAME),
                            chatPanel = CreateStyleGroup(L["Chat Panel Style"], 4, STYLE_CONFIG_KEYS.CHAT_PANEL),
                            decorativePanel = CreateStyleGroup(L["Decorative Panel Style"], 5, STYLE_CONFIG_KEYS.DECORATIVE_PANEL),
                            dataPanel = CreateStyleGroup(L["Data Panel Style"], 6, STYLE_CONFIG_KEYS.DATA_PANEL),
                            minimap = CreateStyleGroup(L["Minimap Style"], 7, STYLE_CONFIG_KEYS.MINIMAP),
                            tooltip = CreateStyleGroup(L["Tooltip Style"], 8, STYLE_CONFIG_KEYS.TOOLTIP)
                        }
                    },
                    nameplates = {
                        order = 15,
                        type = "group",
                        name = L["Nameplates"],
                        childGroups = "select",
                        args = {
                            nameplateHealth = CreateStyleGroup(L["Health Bar Style"], 1, STYLE_CONFIG_KEYS.NAMEPLATE_HEALTH),
                            nameplatePower = CreateStyleGroup(L["Power Bar Style"], 2, STYLE_CONFIG_KEYS.NAMEPLATE_POWER),
                            nameplateCastBar = CreateStyleGroup(L["Cast Bar Style"], 3, STYLE_CONFIG_KEYS.NAMEPLATE_CASTBAR)
                        }
                    },
                    unitFrames = {
                        order = 16,
                        type = "group",
                        name = L["Unit Frames"],
                        childGroups = "select",
                        args = {
                            unitFrameHealth = CreateStyleGroup(L["Health Bar Style"], 1, STYLE_CONFIG_KEYS.UNITFRAME_HEALTH),
                            unitFramePower = CreateStyleGroup(L["Power Bar Style"], 2, STYLE_CONFIG_KEYS.UNITFRAME_POWER),
                            unitFrameCastBar = CreateStyleGroup(L["Cast Bar Style"], 3, STYLE_CONFIG_KEYS.UNITFRAME_CASTBAR),
                            unitFrameClassBar = CreateStyleGroup(L["Class Bar Style"], 4, STYLE_CONFIG_KEYS.UNITFRAME_CLASSBAR)
                        }
                    }
                }
            },
            installer = {
                order = 100,
                type = "group",
                name = L["Installer"],
                args = {
                    install = {
                        order = 10,
                        type = "execute",
                        name = "Install/Update",
                        desc = "Run the installation process.",
                        func = function()
                            Addon.Installer:Show()
                        end
                    }
                }
            }
        }
    }

    E.Options.args[addonName] = options
end

function Addon:GetStyleConfig(styleConfigKey)
    return E.db[addonName].styling[styleConfigKey] or E.db[addonName].styling.default
end

function Addon:GetBorderEnabled(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or config.border.enabled == nil then
        config = E.db[addonName].styling.default
    end
    return config and config.border.enabled
end

function Addon:GetBorderStyle(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or not config.border.style then
        config = E.db[addonName].styling.default
    end
    return config and config.border.style
end

function Addon:GetBorderScale(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or not config.border.scale then
        config = E.db[addonName].styling.default
    end
    return config and config.border.scale
end

function Addon:GetBorderOffset(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or not config.border.offset then
        config = E.db[addonName].styling.default
    end
    return config and config.border.offset
end

function Addon:GetShadowEnabled(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or config.shadow.enabled == nil then
        config = E.db[addonName].styling.default
    end
    return config and config.shadow.enabled
end

function Addon:GetShadowColor(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or config.shadow.color == nil then
        config = E.db[addonName].styling.default
    end
    return config and config.shadow.color
end

function Addon:GetShadowSize(styleConfigKey)
    local config = E.db[addonName].styling[styleConfigKey]
    if not config or config.shadow.size == nil then
        config = E.db[addonName].styling.default
    end
    return config and config.shadow.size
end
