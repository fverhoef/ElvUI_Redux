local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.minimapIconStyles = {
    Square = "Square",
    Round = "Round"
}
Addon.frameThemes = {"None", "Alliance", "Horde", "Metal", "Neutral"}
Addon.buttonThemes = {"None", "Red", "GoldRed", "Silver"}

if E.db[addonName] == nil then
    E.db[addonName] = {}
end
P[addonName] = {
    artwork = {enabled = true, frameTheme = "Metal", buttonTheme = "Silver"},
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
    minimapButtonFrame = {enabled = true, iconStyle = Addon.minimapIconStyles.Square, iconSize = 22, buttonsPerRow = 6, buttonSpacing = 2, collapsed = true},
    shadows = {enabled = true, color = {r = 0, g = 0, b = 0, a = 0.5}, size = 3},
    tooltips = {enabled = true, showIcons = true, showItemCount = true, showVendorPrice = true, showItemLevel = true, colors = {itemLevel = {220 / 255, 195 / 255, 30 / 255}}}
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
                    lineBreak = {type = "header", name = "", order = 2},
                    frameTheme = {
                        order = 10,
                        type = "select",
                        name = L["Frame Theme"],
                        values = Addon.frameThemes,
                        get = function()
                            for key, val in pairs(Addon.frameThemes) do
                                if E.db[addonName].artwork.frameTheme == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.frameTheme = Addon.frameThemes[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    },
                    buttonTheme = {
                        order = 10,
                        type = "select",
                        name = L["Button Theme"],
                        values = Addon.buttonThemes,
                        get = function()
                            for key, val in pairs(Addon.buttonThemes) do
                                if E.db[addonName].artwork.buttonTheme == val then
                                    return key
                                end
                            end
                        end,
                        set = function(_, key)
                            E.db[addonName].artwork.buttonTheme = Addon.buttonThemes[key]
                            Addon.Artwork:UpdateArtwork()
                        end
                    }
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
                    },
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
            profiles = {
                order = 100,
                type = "group",
                name = L["Profiles"],
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
