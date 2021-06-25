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
local MINIMAP_ICON_STYLES = {Square = "Square", Round = "Round"}

Addon.BACKGROUNDS = BACKGROUNDS
Addon.BORDERS = BORDERS
Addon.BORDER_CONFIG_KEYS = BORDER_CONFIG_KEYS
Addon.FRAME_BORDERS = FRAME_BORDERS
Addon.MINIMAP_ICON_STYLES = MINIMAP_ICON_STYLES

P[addonName] = {
    automation = {
        enabled = true,
        fastLoot = true,
        standDismount = true,
        acceptSummon = false,
        acceptResurrection = true,
        disableLootRollConfirmation = true,
        disableLootBindConfirmation = false,
        disableVendorRefundWarning = true,
        disableMailRefundWarning = true,
        autoInvite = true,
        autoInvitePassword = "safari"
    },
    minimapButtonFrame = {
        enabled = true,
        iconStyle = MINIMAP_ICON_STYLES.Square,
        iconSize = 22,
        buttonsPerRow = 6,
        buttonSpacing = 2,
        collapsed = true
    },
    skins = {
        enabled = true,
        borders = {enabled = true, style = BORDERS["Redux"]},
        shadows = {enabled = true, color = {0, 0, 0, 0.7}, size = 5, shadowPerButton = true},
        layout = {
            characterFrame = {enabled = true},
            classTrainerFrame = {enabled = true},
            guildMemberDetailFrame = {enabled = true},
            questLogFrame = {enabled = true},
            tradeSkillFrame = {enabled = true}
        }
    },
    tooltips = {
        enabled = true,
        showIcons = true,
        showItemCount = true,
        showVendorPrice = true,
        showItemLevel = true,
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
            name = {order = 1, type = "header", name = Addon.title},
            automation = {
                order = 10,
                type = "group",
                name = L["Automation"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"automation", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    fastLoot = Addon:CreateToggleOption(L["Faster Auto-Loot"], nil, 10, "full", {"automation", "fastLoot"}),
                    standDismount = Addon:CreateToggleOption(L["Auto Stand/Dismount"], nil, 11, "full",
                                                             {"automation", "standDismount"}),
                    acceptSummon = Addon:CreateToggleOption(L["Accept Summons"], nil, 12, "full", {"automation", "acceptSummon"}),
                    acceptResurrection = Addon:CreateToggleOption(L["Accept Resurrection"], nil, 13, "full",
                                                                  {"automation", "acceptResurrection"}),
                    disableLootBindConfirmation = Addon:CreateToggleOption(L["Disable Bind on Pickup Confirmation"], nil, 14,
                                                                           "full", {"automation", "disableLootBindConfirmation"}),
                    disableLootRollConfirmation = Addon:CreateToggleOption(L["Disable Loot Roll Confirmation"], nil, 15, "full",
                                                                           {"automation", "disableLootRollConfirmation"}),
                    disableVendorRefundWarning = Addon:CreateToggleOption(L["Disable Vendor Refund Warning"], nil, 16, "full",
                                                                          {"automation", "disableVendorRefundWarning"}),
                    disableMailRefundWarning = Addon:CreateToggleOption(L["Disable Mail Refund Warning"], nil, 17, "full",
                                                                        {"automation", "disableMailRefundWarning"}),
                    autoInvite = Addon:CreateToggleOption(L["Auto Invite"], nil, 18, "full", {"automation", "autoInvite"}),
                    autoInvitePassword = {
                        type = "input",
                        name = L["Auto Invite Password"],
                        order = 22,
                        width = "full",
                        disabled = function()
                            return not E.db[addonName].automation.autoInvite
                        end,
                        get = function()
                            return E.db[addonName].automation.autoInvitePassword
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.autoInvitePassword = val
                        end
                    }
                }
            },
            minimapButtonFrame = {
                order = 20,
                type = "group",
                name = L["Minimap Button Frame"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"minimapButtonFrame", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    iconStyle = {
                        order = 10,
                        type = "select",
                        name = L["Icon Style"],
                        values = Addon.MINIMAP_ICON_STYLES,
                        get = function()
                            for key, val in pairs(Addon.MINIMAP_ICON_STYLES) do
                                if E.db[addonName].minimapButtonFrame.iconStyle == val then
                                    return val
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].minimapButtonFrame.iconStyle = Addon.MINIMAP_ICON_STYLES[key]
                            Addon.MinimapButtonFrame:UpdateButtonFrame()
                        end
                    },
                    iconSize = Addon:CreateRangeOption(L["Icon Size"], nil, 11, 4, 100, 1, {"minimapButtonFrame", "iconSize"}),
                    buttonSpacing = Addon:CreateRangeOption(L["Button Spacing"], nil, 12, 0, 10, 1,
                                                            {"minimapButtonFrame", "buttonSpacing"}),
                    buttonsPerRow = Addon:CreateRangeOption(L["Buttons per Row"], nil, 13, 1, 50, 1,
                                                            {"minimapButtonFrame", "buttonsPerRow"})
                }
            },
            skins = {
                order = 30,
                type = "group",
                name = L["Skins"],
                args = {
                    borders = {
                        order = 1,
                        type = "group",
                        name = L["Borders"],
                        args = {
                            enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"skins", "borders", "enabled"}),
                            lineBreak = {type = "header", name = "", order = 2},
                            style = Addon:CreateBorderStyleOption(L["Default Border Theme"], 3, "style"),
                            frames = {
                                order = 10,
                                type = "group",
                                name = L["Frames"],
                                inline = true,
                                args = {
                                    frameStyle = Addon:CreateBorderStyleOption(L["Frame Theme"], 1, BORDER_CONFIG_KEYS.FRAME),
                                    insetFrameStyle = Addon:CreateBorderStyleOption(L["Inset Frame Theme"], 2, BORDER_CONFIG_KEYS.INSET_FRAME),
                                    chatPanelStyle = Addon:CreateBorderStyleOption(L["Chat Panel Theme"], 3, BORDER_CONFIG_KEYS.CHAT_PANEL),
                                    decorativePanelStyle = Addon:CreateBorderStyleOption(L["Top/Bottom Panel Theme"], 4, BORDER_CONFIG_KEYS.DECORATIVE_PANEL),
                                    tabStyle = Addon:CreateBorderStyleOption(L["Tab Theme"], 5, BORDER_CONFIG_KEYS.TAB),
                                    minimapStyle = Addon:CreateBorderStyleOption(L["Minimap Theme"], 5,BORDER_CONFIG_KEYS.MINIMAP)
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
                                    colorPickerStyle = Addon:CreateBorderStyleOption(L["Color Picker Theme"], 3, BORDER_CONFIG_KEYS.COLOR_PICKER),
                                    dropdownBoxStyle = Addon:CreateBorderStyleOption(L["Dropdown Theme"], 4, BORDER_CONFIG_KEYS.DROP_DOWN_BOX),
                                    dropdownListStyle = Addon:CreateBorderStyleOption(L["Dropdown List Theme"], 5, BORDER_CONFIG_KEYS.DROP_DOWN_LIST),
                                    dropdownListButtonStyle = Addon:CreateBorderStyleOption(L["Dropdown List Button Theme"], 6, BORDER_CONFIG_KEYS.DROP_DOWN_LIST_BUTTON),
                                    editBoxStyle = Addon:CreateBorderStyleOption(L["Edit Box Theme"], 7, BORDER_CONFIG_KEYS.EDIT_BOX),
                                    radioButtonStyle = Addon:CreateBorderStyleOption(L["Radio Button Theme"], 8, BORDER_CONFIG_KEYS.RADIO_BUTTON),
                                    scrollBarStyle = Addon:CreateBorderStyleOption(L["Scroll Bar Theme"], 9, BORDER_CONFIG_KEYS.SCROLL_BAR),
                                    sliderStyle = Addon:CreateBorderStyleOption(L["Slider Theme"], 10, BORDER_CONFIG_KEYS.SLIDER),
                                    statusBarStyle = Addon:CreateBorderStyleOption(L["Status Bar Theme"], 11, BORDER_CONFIG_KEYS.STATUS_BAR)
                                }
                            }
                        }
                    },
                    shadows = {
                        order = 10,
                        type = "group",
                        name = L["Shadows"],
                        args = {
                            enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"skins", "shadows", "enabled"}),
                            lineBreak = {type = "header", name = "", order = 2},
                            color = Addon:CreateColorOption(L["Shadow Color"], 10, {"skins", "shadows", "color"}),
                            size = Addon:CreateRangeOption(L["Shadow Size"], nil, 11, 3, 30, 1, {"skins", "shadows", "size"}),
                            shadowPerButton = Addon:CreateToggleOption(L["Shadow Per Button"], nil, 12, nil,
                                                                       {"skins", "shadows", "shadowPerButton"})
                        }
                    },
                    layout = {
                        order = 20,
                        type = "group",
                        name = L["Layout"],
                        args = {
                            characterFrame = Addon:CreateToggleOption(L["Retail-style Character Frame"], nil, 1, "full",
                                                                      {"skins", "layout", "characterFrame", "enabled"}),
                            classTrainerFrame = Addon:CreateToggleOption(L["Larger Trainer Frame"], nil, 2, "full",
                                                                         {"skins", "layout", "classTrainerFrame", "enabled"}),
                            tradeSkillFrame = Addon:CreateToggleOption(L["Larger Profession Frame"], nil, 3, "full",
                                                                       {"skins", "layout", "tradeSkillFrame", "enabled"}),
                            questLogFrame = Addon:CreateToggleOption(L["Larger Quest Log"], nil, 4, "full",
                                                                     {"skins", "layout", "questLogFrame", "enabled"}),
                            guildMemberDetailFrame = Addon:CreateToggleOption(L["Add Icons to Guild Member Frame"], nil, 5,
                                                                              "full", {
                                "skins",
                                "layout",
                                "guildMemberDetailFrame",
                                "enabled"
                            })
                        }
                    }
                }
            },
            tooltips = {
                order = 40,
                type = "group",
                name = L["Tooltips"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"tooltips", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    showIcons = Addon:CreateToggleOption(L["Show Icons"], nil, 10, "full", {"tooltips", "showIcons"}),
                    showItemCount = Addon:CreateToggleOption(L["Show Item Count"], nil, 11, "full", {"tooltips", "showItemCount"}),
                    showVendorPrice = Addon:CreateToggleOption(L["Show Vendor Price"], nil, 12, "full",
                                                               {"tooltips", "showVendorPrice"}),
                    showItemLevel = Addon:CreateToggleOption(L["Show Item Level"], nil, 13, "full", {"tooltips", "showItemLevel"})
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
    local setting = {"skins", "borders", configKey}
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
