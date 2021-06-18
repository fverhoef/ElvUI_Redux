local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.minimapIconStyles = {Square = "Square", Round = "Round"}
Addon.borders = {
    "None",
    "BeautyCase",
    "Cainyx",
    "Caith",
    "Diablo",
    "Entropy",
    "Goldpaw",
    "Onyx",
    "Retina",
    "Redux",
    "Shadowlands"
}
Addon.frameBackgrounds = {
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
Addon.frameBorders = {
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
        iconStyle = Addon.minimapIconStyles.Square,
        iconSize = 22,
        buttonsPerRow = 6,
        buttonSpacing = 2,
        collapsed = true
    },
    skins = {
        enabled = true,
        borders = {enabled = true, style = "BeautyCase", color = {89 / 255, 89 / 255, 89 / 255, 1}},
        shadows = {enabled = true, color = {0, 0, 0, 0.7}, size = 5, shadowPerButton = true},
        characterStats = {
            colors = {
                guild = {0 / 255, 230 / 255, 0 / 255}
            },
            itemLevels = {poor = 0, common = 15, uncommon = 45, rare = 80, epic = 110, legendary = 150}
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
                    fastLoot = {
                        type = "toggle",
                        name = L["Faster Auto-Loot"],
                        order = 10,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.fastLoot
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.fastLoot = val
                        end
                    },
                    standDismount = {
                        type = "toggle",
                        name = L["Auto Stand/Dismount"],
                        order = 11,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.standDismount
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.standDismount = val
                        end
                    },
                    acceptSummon = {
                        type = "toggle",
                        name = L["Accept Summons"],
                        order = 14,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.acceptSummon
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.acceptSummon = val
                        end
                    },
                    acceptResurrection = {
                        type = "toggle",
                        name = L["Accept Resurrection"],
                        order = 15,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.acceptResurrection
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.acceptResurrection = val
                        end
                    },
                    disableLootBindConfirmation = {
                        type = "toggle",
                        name = L["Disable Bind on Pickup Confirmation"],
                        order = 16,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.disableLootBindConfirmation
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.disableLootBindConfirmation = val
                        end
                    },
                    disableLootRollConfirmation = {
                        type = "toggle",
                        name = L["Disable Loot Roll Confirmation"],
                        order = 17,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.disableLootRollConfirmation
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.disableLootRollConfirmation = val
                        end
                    },
                    disableVendorRefundWarning = {
                        type = "toggle",
                        name = L["Disable Vendor Refund Warning"],
                        order = 18,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.disableVendorRefundWarning
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.disableVendorRefundWarning = val
                        end
                    },
                    disableMailRefundWarning = {
                        type = "toggle",
                        name = L["Disable Mail Refund Warning"],
                        order = 19,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.disableMailRefundWarning
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.disableMailRefundWarning = val
                        end
                    },
                    autoInvite = {
                        type = "toggle",
                        name = L["Auto Invite"],
                        order = 21,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.autoInvite
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.autoInvite = val
                        end
                    },
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
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = L["Enabled"],
                        get = function(info)
                            return E.db[addonName].minimapButtonFrame.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].minimapButtonFrame.enabled = value
                            if value then
                                Addon.MinimapButtonFrame:Initialize()
                            else
                                ReloadUI()
                            end
                        end
                    },
                    lineBreak = {type = "header", name = "", order = 2},
                    iconStyle = {
                        order = 10,
                        type = "select",
                        name = L["Icon Style"],
                        values = Addon.minimapIconStyles,
                        get = function()
                            for key, val in pairs(Addon.minimapIconStyles) do
                                if E.db[addonName].minimapButtonFrame.iconStyle == val then
                                    return val
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].minimapButtonFrame.iconStyle = Addon.minimapIconStyles[key]
                            Addon.MinimapButtonFrame:UpdateButtonFrame()
                        end
                    },
                    iconSize = {
                        order = 11,
                        type = "range",
                        name = L["Icon Size"],
                        min = 4,
                        max = 100,
                        step = 1,
                        get = function(info)
                            return E.db[addonName].minimapButtonFrame.iconSize
                        end,
                        set = function(info, value)
                            E.db[addonName].minimapButtonFrame.iconSize = value
                            Addon.MinimapButtonFrame:UpdateButtonFrame()
                        end
                    },
                    buttonSpacing = {
                        order = 12,
                        type = "range",
                        name = L["Buttons Spacing"],
                        min = 0,
                        max = 10,
                        step = 1,
                        get = function(info)
                            return E.db[addonName].minimapButtonFrame.buttonSpacing
                        end,
                        set = function(info, value)
                            E.db[addonName].minimapButtonFrame.buttonSpacing = value
                            Addon.MinimapButtonFrame:UpdateButtonFrame()
                        end
                    },
                    buttonsPerRow = {
                        order = 13,
                        type = "range",
                        name = L["Buttons per Row"],
                        min = 1,
                        max = 50,
                        step = 1,
                        get = function(info)
                            return E.db[addonName].minimapButtonFrame.buttonsPerRow
                        end,
                        set = function(info, value)
                            E.db[addonName].minimapButtonFrame.buttonsPerRow = value
                            Addon.MinimapButtonFrame:UpdateButtonFrame()
                        end
                    }
                }
            },
            skins = {
                order = 30,
                type = "group",
                name = L["Skins"],
                args = {
                    shadows = {
                        order = 10,
                        type = "group",
                        name = L["Shadows"],
                        args = {
                            enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, nil, {"skins", "shadows", "enabled"}),
                            lineBreak = {type = "header", name = "", order = 2},
                            color = Addon:CreateColorOption(L["Shadow Color"], 10, {"skins", "shadows", "color"}),
                            size = {
                                order = 11,
                                type = "range",
                                name = L["Shadow Size"],
                                min = 3,
                                max = 30,
                                step = 1,
                                get = function(info)
                                    return E.db[addonName].skins.shadows.size
                                end,
                                set = function(info, value)
                                    E.db[addonName].skins.shadows.size = value
                                    Addon.Skins:Update()
                                end
                            },
                            shadowPerButton = {
                                order = 21,
                                type = "toggle",
                                name = L["Shadow Per Button"],
                                get = function(info)
                                    return E.db[addonName].skins.shadows.shadowPerButton
                                end,
                                set = function(info, value)
                                    E.db[addonName].skins.shadows.shadowPerButton = value
                                    Addon.Skins:Update()
                                end
                            }
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
                    showIcons = {
                        type = "toggle",
                        name = L["Show Icons"],
                        order = 10,
                        width = "full",
                        get = function()
                            return E.db[addonName].tooltips.showIcons
                        end,
                        set = function(_, val)
                            E.db[addonName].tooltips.showIcons = val
                        end
                    },
                    showItemCount = {
                        type = "toggle",
                        name = L["Show Item Count"],
                        order = 11,
                        width = "full",
                        get = function()
                            return E.db[addonName].tooltips.showItemCount
                        end,
                        set = function(_, val)
                            E.db[addonName].tooltips.showItemCount = val
                            if val then
                                -- disable built-in item counts
                                E.db.tooltip.itemCount = "NONE"
                            end
                        end
                    },
                    showVendorPrice = {
                        type = "toggle",
                        name = L["Show Vendor Price"],
                        order = 12,
                        width = "full",
                        get = function()
                            return E.db[addonName].tooltips.showVendorPrice
                        end,
                        set = function(_, val)
                            E.db[addonName].tooltips.showVendorPrice = val
                        end
                    },
                    showItemLevel = {
                        type = "toggle",
                        name = L["Show Item Level"],
                        order = 13,
                        width = "full",
                        get = function()
                            return E.db[addonName].tooltips.showItemLevel
                        end,
                        set = function(_, val)
                            E.db[addonName].tooltips.showItemLevel = val
                        end
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
                            E:GetModule("PluginInstaller"):Queue(Addon.Installer.InstallerData)
                            E:ToggleOptionsUI()
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
            Addon:Update()
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
            Addon:Update()
        end
    }
end

function Addon:CreateBorderThemeOption(caption, order, setting)
    return {
        order = order,
        type = "select",
        name = caption,
        values = Addon.borders,
        get = function()
            for key, val in pairs(Addon.borders) do
                if Addon:GetOptionValue(setting) == val then
                    return key
                end
            end
        end,
        set = function(_, key)
            Addon:SetOptionValue(setting, Addon.borders[key])
            Addon:Update()
        end
    }
end

function Addon:CreateFrameBorderThemeOption(caption, order, setting)
    return {
        order = order,
        type = "select",
        name = caption,
        values = Addon.frameBorders,
        get = function()
            for key, val in pairs(Addon.frameBorders) do
                if Addon:GetOptionValue(setting) == val then
                    return key
                end
            end
        end,
        set = function(_, key)
            Addon:SetOptionValue(setting, Addon.frameBorders[key])
            Addon:Update()
        end
    }
end

function Addon:CreateFrameBackgroundOption(caption, order, setting)
    return {
        order = order,
        type = "select",
        name = caption,
        values = Addon.frameBackgrounds,
        get = function()
            for key, val in pairs(Addon.frameBackgrounds) do
                if Addon:GetOptionValue(setting) == val then
                    return key
                end
            end
        end,
        set = function(_, key)
            Addon:SetOptionValue(setting, Addon.frameBackgrounds[key])
            Addon:Update()
        end
    }
end

function Addon:CreateUnitFrameOptions(unit, caption, order, hidden, additionalArgs)
    local options = {
        order = order,
        type = "group",
        name = caption,
        hidden = hidden,
        args = {
            header = Addon:CreateOptionHeader(caption, 0),
            border = {
                order = 1,
                type = "group",
                inline = true,
                name = L["Frame Border"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "border"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {"artwork", "unitFrames", unit, "borderColor"})
                }
            },
            healthBar = {
                order = 2,
                type = "group",
                inline = true,
                name = L["Health Bar"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "healthBorder"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2,
                                                          {"artwork", "unitFrames", unit, "healthBorderColor"})
                }
            },
            powerBar = {
                order = 3,
                type = "group",
                inline = true,
                name = L["Power Bar"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "powerBorder"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2,
                                                          {"artwork", "unitFrames", unit, "powerBorderColor"})
                }
            },
            castBar = {
                order = 4,
                type = "group",
                inline = true,
                name = L["Castbar"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "castBarBorder"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2,
                                                          {"artwork", "unitFrames", unit, "castBarBorderColor"})
                }
            }
        }
    }

    if additionalArgs then
        for key, value in pairs(additionalArgs) do
            if not options.args[key] then
                options.args[key] = value
            end
        end
    end

    return options
end
