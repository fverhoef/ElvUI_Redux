local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

local BACKGROUNDS = {
    "None",
    "Alliance",
    "Horde",
    "Neutral",
    "Marine",
    "Mechagon",
    "Kyrian",
    "Necrolord",
    "NightFae",
    "Oribos",
    "Venthyr"
}
local BORDERS = {
    [""] = "(Inherit from Default)",
    ["(ElvUI)"] = "(ElvUI)",
    ["BeautyCase"] = "BeautyCase",
    ["Cainyx"] = "Cainyx",
    ["Caith"] = "Caith",
    ["Diablo"] = "Diablo",
    ["Entropy"] = "Entropy",
    ["Goldpaw"] = "Goldpaw",
    ["Onyx"] = "Onyx",
    ["Retina"] = "Retina",
    ["Redux"] = "Redux"
}
local BORDER_CONFIG_KEYS = {
    DEFAULT = "style",

    -- Frames
    FRAME = "frameStyle",
    INSET_FRAME = "insetFrameStyle",
    CHAT_PANEL = "chatPanelStyle",
    DECORATIVE_PANEL = "decorativePanelStyle",
    TAB = "tabStyle",
    MINIMAP = "minimapStyle",

    -- Controls
    BUTTON = "buttonStyle",
    CHECK_BOX = "checkBoxStyle",
    COLOR_PICKER = "colorPickerStyle",
    DROP_DOWN_BOX = "dropDownBoxStyle",
    DROP_DOWN_LIST = "dropDownListStyle",
    DROP_DOWN_LIST_BUTTON = "dropDownListButtonStyle",
    EDIT_BOX = "editBoxStyle",
    RADIO_BUTTON = "radioButtonStyle",
    SCROLL_BAR = "scrollBarStyle",
    SLIDER = "sliderStyle",
    STATUS_BAR = "statusBarStyle",

    -- Action Bars
    ACTION_BAR = "actionBarStyle",
    ACTION_BUTTON = "actionButtonStyle",
    MICRO_BUTTON = "microButtonStyle",
    LOOT_ROLL_BAR = "lootRollBarStyle",

    -- Auras
    AURA = "auraStyle",

    -- Bags
    BAG_SLOT = "bagSlotStyle",
    BAG_BAR = "bagBarStyle",

    -- Buttons
    ITEM_BUTTON = "itemButtonStyle",
    TALENT_BUTTON = "talentButtonStyle",
    RAID_UTILITY_BUTTON = "raidUtilityButtonStyle",
    ICON = "iconStyle",

    -- Data Bars/Text
    DATA_BAR = "dataBarStyle",
    DATA_PANEL = "dataPanelStyle",

    -- Nameplates
    NAMEPLATE_HEALTH = "nameplateHealthStyle",
    NAMEPLATE_POWER = "nameplatePowerStyle",
    NAMEPLATE_CASTBAR = "nameplateCastBarStyle",

    -- Unit Frames
    UNITFRAME_HEALTH = "unitFrameHealthStyle",
    UNITFRAME_POWER = "unitFramePowerStyle",
    UNITFRAME_CASTBAR = "unitFrameCastBarStyle",
    UNITFRAME_CLASSBAR = "unitFrameClassBarStyle",

    -- Tooltips
    TOOLTIP = "tooltipStyle"
}
local FRAME_BORDERS = {
    "None",
    "Alliance",
    "Horde",
    "Neutral",
    "Metal",
    "Marine",
    "Mechagon",
    "Kyrian",
    "Necrolord",
    "NightFae",
    "Oribos",
    "Venthyr"
}

Addon.BACKGROUNDS = BACKGROUNDS
Addon.BORDERS = BORDERS
Addon.BORDER_CONFIG_KEYS = BORDER_CONFIG_KEYS
Addon.FRAME_BORDERS = FRAME_BORDERS

P[addonName] = {
    enabled = true,
    borders = {enabled = true, style = BORDERS["Redux"]},
    shadows = {enabled = true, color = {0, 0, 0, 0.7}, size = 5, shadowPerButton = true},
    layout = {
        characterFrame = {enabled = true},
        classTrainerFrame = {enabled = true},
        guildMemberDetailFrame = {enabled = true},
        questLogFrame = {enabled = true},
        tradeSkillFrame = {enabled = true}
    },
    tooltips = {
        enabled = true,
        showIcons = true,
        showItemCount = true,
        showVendorPrice = true,
        showItemLevel = false,
        colors = {itemLevel = {220 / 255, 195 / 255, 30 / 255}}
    }
}

if E.db[addonName] == nil then
    E.db[addonName] = P[addonName]
end

function Addon:InsertOptions()
    E.Options.args[addonName] = {
        order = 100,
        type = "group",
        name = Addon.title,
        childGroups = "tab",
        args = {
            name = {order = 0, type = "header", name = Addon.title},
            borders = {
                order = 1,
                type = "group",
                name = L["Borders"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"borders", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    style = Addon:CreateBorderStyleOption(L["Default Border Theme"], 3, "style"),
                    frames = {
                        order = 10,
                        type = "group",
                        name = L["Frames"],
                        inline = true,
                        args = {
                            frameStyle = Addon:CreateBorderStyleOption(L["Frame Theme"], 1, BORDER_CONFIG_KEYS.FRAME),
                            insetFrameStyle = Addon:CreateBorderStyleOption(L["Inset Frame Theme"], 2,
                                                                            BORDER_CONFIG_KEYS.INSET_FRAME),
                            chatPanelStyle = Addon:CreateBorderStyleOption(L["Chat Panel Theme"], 3, BORDER_CONFIG_KEYS.CHAT_PANEL),
                            decorativePanelStyle = Addon:CreateBorderStyleOption(L["Top/Bottom Panel Theme"], 4,
                                                                                 BORDER_CONFIG_KEYS.DECORATIVE_PANEL),
                            tabStyle = Addon:CreateBorderStyleOption(L["Tab Theme"], 5, BORDER_CONFIG_KEYS.TAB),
                            minimapStyle = Addon:CreateBorderStyleOption(L["Minimap Theme"], 5, BORDER_CONFIG_KEYS.MINIMAP)
                        }
                    },
                    controls = {
                        order = 11,
                        type = "group",
                        name = L["Controls"],
                        inline = true,
                        args = {
                            buttonStyle = Addon:CreateBorderStyleOption(L["Button Theme"], 1, BORDER_CONFIG_KEYS.BUTTON),
                            checkBoxStyle = Addon:CreateBorderStyleOption(L["Checkbox Theme"], 2, BORDER_CONFIG_KEYS.CHECK_BOX),
                            colorPickerStyle = Addon:CreateBorderStyleOption(L["Color Picker Theme"], 3,
                                                                             BORDER_CONFIG_KEYS.COLOR_PICKER),
                            dropdownBoxStyle = Addon:CreateBorderStyleOption(L["Dropdown Theme"], 4,
                                                                             BORDER_CONFIG_KEYS.DROP_DOWN_BOX),
                            dropdownListStyle = Addon:CreateBorderStyleOption(L["Dropdown List Theme"], 5,
                                                                              BORDER_CONFIG_KEYS.DROP_DOWN_LIST),
                            dropdownListButtonStyle = Addon:CreateBorderStyleOption(L["Dropdown List Button Theme"], 6,
                                                                                    BORDER_CONFIG_KEYS.DROP_DOWN_LIST_BUTTON),
                            editBoxStyle = Addon:CreateBorderStyleOption(L["Edit Box Theme"], 7, BORDER_CONFIG_KEYS.EDIT_BOX),
                            radioButtonStyle = Addon:CreateBorderStyleOption(L["Radio Button Theme"], 8,
                                                                             BORDER_CONFIG_KEYS.RADIO_BUTTON),
                            scrollBarStyle = Addon:CreateBorderStyleOption(L["Scroll Bar Theme"], 9, BORDER_CONFIG_KEYS.SCROLL_BAR),
                            sliderStyle = Addon:CreateBorderStyleOption(L["Slider Theme"], 10, BORDER_CONFIG_KEYS.SLIDER),
                            statusBarStyle = Addon:CreateBorderStyleOption(L["Status Bar Theme"], 11,
                                                                           BORDER_CONFIG_KEYS.STATUS_BAR)
                        }
                    }
                }
            },
            shadows = {
                order = 10,
                type = "group",
                name = L["Shadows"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"shadows", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    color = Addon:CreateColorOption(L["Shadow Color"], 10, {"shadows", "color"}),
                    size = Addon:CreateRangeOption(L["Shadow Size"], nil, 11, 3, 30, 1, {"shadows", "size"}),
                    shadowPerButton = Addon:CreateToggleOption(L["Shadow Per Button"], nil, 12, nil,
                                                               {"shadows", "shadowPerButton"})
                }
            },
            layout = {
                order = 20,
                type = "group",
                name = L["Layout"],
                args = {
                    characterFrame = Addon:CreateToggleOption(L["Retail-style Character Frame"], nil, 1, "full",
                                                              {"layout", "characterFrame", "enabled"}),
                    classTrainerFrame = Addon:CreateToggleOption(L["Larger Trainer Frame"], nil, 2, "full",
                                                                 {"layout", "classTrainerFrame", "enabled"}),
                    tradeSkillFrame = Addon:CreateToggleOption(L["Larger Profession Frame"], nil, 3, "full",
                                                               {"layout", "tradeSkillFrame", "enabled"}),
                    questLogFrame = Addon:CreateToggleOption(L["Larger Quest Log"], nil, 4, "full",
                                                             {"layout", "questLogFrame", "enabled"}),
                    guildMemberDetailFrame = Addon:CreateToggleOption(L["Add Icons to Guild Member Frame"], nil, 5, "full",
                                                                      {"layout", "guildMemberDetailFrame", "enabled"})
                }
            },
            tooltips = {
                order = 30,
                type = "group",
                name = L["Tooltips"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"tooltips", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    showIcons = Addon:CreateToggleOption(L["Show Icons"], nil, 10, "full", {"tooltips", "showIcons"}),
                    showVendorPrice = Addon:CreateToggleOption(L["Show Vendor Price"], nil, 12, "full",
                                                               {"tooltips", "showVendorPrice"}),
                    showItemLevel = Addon:CreateToggleOption(L["Show Item Level"], nil, 13, "full", {"tooltips", "showItemLevel"})
                }
            },
            installer = {
                order = 100,
                type = "group",
                name = L["Profile Installer"],
                args = {
                    install = {
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
end

function Addon:GetOptionValue(setting)
    local value = E.db[addonName]
    for i, name in ipairs(setting) do
        value = value[name]
    end

    return value
end

function Addon:GetDefaultOptionValue(setting)
    local value = P[addonName]
    for i, name in ipairs(setting) do
        value = value[name]
    end

    return value
end

function Addon:SetOptionValue(setting, val)
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

function Addon:CreateOptionDescription(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)
    return {
        type = "description",
        name = name,
        order = order,
        fontSize = fontSize,
        image = image,
        imageCoords = imageCoords,
        imageWidth = imageWidth,
        imageHeight = imageHeight,
        width = width,
        hidden = hidden
    }
end

function Addon:CreateOptionHeader(caption, order)
    return {type = "header", order = order, name = caption}
end

function Addon:CreateToggleOption(caption, desc, order, width, setting)
    return {
        type = "toggle",
        name = caption,
        desc = desc,
        order = order,
        width = width,
        get = function(info)
            return Addon:GetOptionValue(setting)
        end,
        set = function(info, value)
            Addon:SetOptionValue(setting, value)
            Addon:OnSettingChanged(setting)
        end
    }
end

function Addon:CreateRangeOption(caption, desc, order, min, max, step, setting)
    return {
        type = "range",
        name = caption,
        desc = desc,
        order = order,
        min = min,
        max = max,
        step = step,
        get = function(info)
            return Addon:GetOptionValue(setting)
        end,
        set = function(info, value)
            Addon:SetOptionValue(setting, value)
            Addon:OnSettingChanged(setting)
        end
    }
end

function Addon:CreateColorOption(caption, order, setting, noAlpha)
    return {
        order = order,
        type = "color",
        name = caption,
        hasAlpha = not noAlpha,
        get = function(info)
            local t = Addon:GetOptionValue(setting)
            local d = Addon:GetDefaultOptionValue(setting)
            return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
        end,
        set = function(info, r, g, b, a)
            local t = Addon:GetOptionValue(setting)
            t[1], t[2], t[3], t[4] = r, g, b, a
            Addon:OnSettingChanged(setting)
        end
    }
end

function Addon:CreateBorderStyleOption(caption, order, configKey)
    local setting = {"borders", configKey}
    return {
        order = order,
        type = "select",
        name = caption,
        values = BORDERS,
        get = function()
            local optionValue = Addon:GetOptionValue(setting)
            for key, val in pairs(BORDERS) do
                if (optionValue or "") == key then
                    return key
                end
            end
        end,
        set = function(_, key)
            if key == "" then
                key = nil
            end
            Addon:SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end

function Addon:CreateFrameBorderThemeOption(caption, order, setting)
    return {
        order = order,
        type = "select",
        name = caption,
        values = FRAME_BORDERS,
        get = function()
            local optionValue = Addon:GetOptionValue(setting)
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
            Addon:SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end

function Addon:CreateFrameBackgroundOption(caption, order, setting)
    return {
        order = order,
        type = "select",
        name = caption,
        values = BACKGROUNDS,
        get = function()
            local optionValue = Addon:GetOptionValue(setting)
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
            Addon:SetOptionValue(setting, key)
            Addon:OnSettingChanged(setting)
        end
    }
end
