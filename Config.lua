local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.minimapIconStyles = {Square = "Square", Round = "Round"}
Addon.borders = {"None", "BeautyCase", "Clean", "Goldpaw", "Onyx", "Renaitre (Square)", "Retina"}
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
Addon.thinFrameBorders = {
    "None",
    "Alliance",
    "Horde",
    "Neutral",
    "Marine",
    "Mechagon",
    "Kyrian",
    "Necrolord",
    "NightFae",
    "Venthyr"
}

if E.db[addonName] == nil then
    E.db[addonName] = {}
end
P[addonName] = {
    artwork = {
        enabled = true,
        frameBackground = "Marine",
        frameBackgroundColor = {1, 1, 1, 1},
        frameBorder = "Metal",
        buttonBorder = "BeautyCase",
        buttonBorderColor = {20 / 255, 20 / 255, 20 / 255},
        buttonBorderHighlightColor = {80 / 255, 80 / 255, 80 / 255},
        tooltipBorder = "BeautyCase",
        tooltipBorderColor = {20 / 255, 20 / 255, 20 / 255},
    },
    automation = {
        enabled = true,
        fastLoot = true,
        standDismount = true,
        vendorGrays = true,
        repair = true,
        acceptSummon = false,
        acceptResurrection = true,
        disableLootRollConfirmation = true,
        disableLootBindConfirmation = false,
        disableVendorRefundWarning = true,
        disableMailRefundWarning = true
    },
    minimapButtonFrame = {
        enabled = true,
        iconStyle = Addon.minimapIconStyles.Square,
        iconSize = 22,
        buttonsPerRow = 6,
        buttonSpacing = 2,
        collapsed = true
    },
    shadows = {enabled = true, color = {0, 0, 0, 0.5}, size = 3},
    tooltips = {
        enabled = true,
        showIcons = true,
        showItemCount = true,
        showVendorPrice = true,
        showItemLevel = true,
        colors = {itemLevel = {220 / 255, 195 / 255, 30 / 255}}
    }
}

function Addon:InsertOptions()
    E.Options.args[addonName] = {
        order = 100,
        type = "group",
        name = Addon.title,
        childGroups = "tab",
        args = {
            name = {order = 1, type = "header", name = Addon.title},
            artwork = {
                order = 10,
                type = "group",
                name = L["Artwork"],
                args = {
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = L["Enabled"],
                        get = function(info)
                            return E.db[addonName].artwork.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].artwork.enabled = value
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    lineBreak1 = {type = "header", name = "Frames", order = 20},
                    frameBorder = {
                        order = 21,
                        type = "select",
                        name = L["Frame Border Theme"],
                        values = Addon.frameBorders,
                        get = function()
                            for key, val in pairs(Addon.frameBorders) do
                                if E.db[addonName].artwork.frameBorder == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.frameBorder = Addon.frameBorders[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    border = {
                        order = 22,
                        type = "select",
                        name = L["Frame Border Theme (Thin)"],
                        values = Addon.thinFrameBorders,
                        get = function()
                            for key, val in pairs(Addon.thinFrameBorders) do
                                if E.db[addonName].artwork.thinFrameBorder == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.thinFrameBorder = Addon.thinFrameBorders[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    frameBackground = {
                        order = 30,
                        type = "select",
                        name = L["Frame Background"],
                        values = Addon.frameBackgrounds,
                        get = function()
                            for key, val in pairs(Addon.frameBackgrounds) do
                                if E.db[addonName].artwork.frameBackground == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.frameBackground = Addon.frameBackgrounds[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    frameBackgroundColor = {
                        order = 31,
                        type = "color",
                        name = L["Frame Background Color"],
                        hasAlpha = true,
                        get = function(info)
                            local t = E.db[addonName].artwork.frameBackgroundColor
                            return t[1], t[2], t[3], t[4]
                        end,
                        set = function(info, r, g, b, a)
                            local t = E.db[addonName].artwork.frameBackgroundColor
                            t[1], t[2], t[3], t[4] = r, g, b, a
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    lineBreak2 = {type = "header", name = L["Buttons"], order = 50},
                    buttonBorder = {
                        order = 51,
                        type = "select",
                        name = L["Button Border Theme"],
                        values = Addon.borders,
                        get = function()
                            for key, val in pairs(Addon.borders) do
                                if E.db[addonName].artwork.buttonBorder == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.buttonBorder = Addon.borders[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    buttonBorderColor = {
                        order = 52,
                        type = "color",
                        name = L["Button Border Color"],
                        get = function(info)
                            local t = E.db[addonName].artwork.buttonBorderColor
                            return t[1], t[2], t[3], t[4]
                        end,
                        set = function(info, r, g, b)
                            local t = E.db[addonName].artwork.buttonBorderColor
                            t[1], t[2], t[3], t[4] = r, g, b, a
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    buttonBorderHighlightColor = {
                        order = 53,
                        type = "color",
                        name = L["Button Border Highlight Color"],
                        get = function(info)
                            local t = E.db[addonName].artwork.buttonBorderHighlightColor
                            return t[1], t[2], t[3], t[4]
                        end,
                        set = function(info, r, g, b)
                            local t = E.db[addonName].artwork.buttonBorderHighlightColor
                            t[1], t[2], t[3], t[4] = r, g, b, a
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    lineBreak3 = {type = "header", name = L["Tooltips"], order = 60},
                    tooltipBorder = {
                        order = 61,
                        type = "select",
                        name = L["Tooltip Border Theme"],
                        values = Addon.borders,
                        get = function()
                            for key, val in pairs(Addon.borders) do
                                if E.db[addonName].artwork.tooltipBorder == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.tooltipBorder = Addon.borders[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    tooltipBorderColor = {
                        order = 62,
                        type = "color",
                        name = L["Tooltip Border Color"],
                        get = function(info)
                            local t = E.db[addonName].artwork.tooltipBorderColor
                            return t[1], t[2], t[3], t[4]
                        end,
                        set = function(info, r, g, b)
                            local t = E.db[addonName].artwork.tooltipBorderColor
                            t[1], t[2], t[3], t[4] = r, g, b, a
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                }
            },
            automation = {
                order = 20,
                type = "group",
                name = L["Automation"],
                args = {
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = L["Enabled"],
                        get = function(info)
                            return E.db[addonName].automation.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].automation.enabled = value
                        end
                    },
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
                    vendorGrays = {
                        type = "toggle",
                        name = L["Vendor Trash"],
                        order = 12,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.vendorGrays
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.vendorGrays = val
                        end
                    },
                    repair = {
                        type = "toggle",
                        name = L["Auto Repair"],
                        order = 13,
                        width = "full",
                        get = function()
                            return E.db[addonName].automation.repair
                        end,
                        set = function(_, val)
                            E.db[addonName].automation.repair = val
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
                    }
                }
            },
            minimapButtonFrame = {
                order = 30,
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
            shadows = {
                order = 40,
                type = "group",
                name = L["Shadows"],
                args = {
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = L["Enabled"],
                        get = function(info)
                            return E.db[addonName].shadows.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].shadows.enabled = value
                            Addon.Shadows:UpdateShadows()
                        end
                    },
                    lineBreak = {type = "header", name = "", order = 2},
                    color = {
                        order = 10,
                        type = "color",
                        name = L["Shadow Color"],
                        hasAlpha = true,
                        get = function(info)
                            local t = E.db[addonName].shadows.color
                            return t.r, t.g, t.b, t.a
                        end,
                        set = function(info, r, g, b, a)
                            local t = E.db[addonName].shadows.color
                            t.r, t.g, t.b, t.a = r, g, b, a
                            Addon.Shadows:UpdateShadows()
                        end
                    },
                    size = {
                        order = 11,
                        type = "range",
                        name = L["Shadow Size"],
                        min = 3,
                        max = 30,
                        step = 1,
                        get = function(info)
                            return E.db[addonName].shadows.size
                        end,
                        set = function(info, value)
                            E.db[addonName].shadows.size = value
                            Addon.Shadows:UpdateShadows()
                        end
                    }
                }
            },
            tooltips = {
                order = 50,
                type = "group",
                name = L["Tooltips"],
                args = {
                    enabled = {
                        order = 1,
                        type = "toggle",
                        name = L["Enabled"],
                        get = function(info)
                            return E.db[addonName].tooltips.enabled
                        end,
                        set = function(info, value)
                            E.db[addonName].tooltips.enabled = value
                        end
                    },
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
