local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.minimapIconStyles = {Square = "Square", Round = "Round"}
Addon.borders = {"None", "BeautyCase", "Clean", "Goldpaw", "Onyx", "Renaitre (Square)", "Retina", "Shadowlands"}
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

table.insert(Addon.frameBorders, "")
for _, border in ipairs(Addon.borders) do
    if border ~= "None" then
        table.insert(Addon.frameBorders, border)
    end
end

if E.db[addonName] == nil then
    E.db[addonName] = {}
end
P[addonName] = {
    artwork = {
        enabled = true,
        frameBorder = "Metal",
        frameBorderColor = {1, 1, 1},
        frameBackground = "Necrolord",
        frameBackgroundColor = {1, 1, 1, 1},
        frameTabBorder = "Shadowlands",
        frameTabBorderColor = {139 / 255, 129 / 255, 118 / 255},
        thinFrameBorder = "BeautyCase",
        thinFrameBorderColor = {60 / 255, 60 / 255, 60 / 255},
        buttonBorder = "BeautyCase",
        buttonBorderColor = {60 / 255, 60 / 255, 60 / 255},
        buttonBorderHighlightColor = {90 / 255, 90 / 255, 90 / 255},
        actionButtonBorder = "BeautyCase",
        actionButtonBorderColor = {60 / 255, 60 / 255, 60 / 255},
        bagButtonBorder = "BeautyCase",
        bagButtonBorderColor = {60 / 255, 60 / 255, 60 / 255},
        itemButtonBorder = "BeautyCase",
        itemButtonBorderColor = {60 / 255, 60 / 255, 60 / 255},
        auraBorder = "BeautyCase",
        auraBorderColor = {60 / 255, 60 / 255, 60 / 255},
        tempEnchantBorder = "BeautyCase",
        tempEnchantBorderColor = {60 / 255, 60 / 255, 60 / 255},
        tooltipBorder = "BeautyCase",
        tooltipBorderColor = {60 / 255, 60 / 255, 60 / 255},
        unitFrames = {
            ["player"] = {
                border = "None",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "BeautyCase",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "BeautyCase",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["pet"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["pettarget"] = {
                border = "None",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "BeautyCase",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["target"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["targettarget"] = {
                border = "None",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "BeautyCase",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["targettargettarget"] = {
                border = "None",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "BeautyCase",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["focus"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["arena"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["assist"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["boss"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["party"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["raid"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["raid40"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["raidpet"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            },
            ["tank"] = {
                border = "BeautyCase",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "None",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "None",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
            }
        }
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
    shadows = {enabled = true, color = {0, 0, 0, 0.5}, size = 3, shadowPerButton = true},
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
                    lineBreak = {type = "header", name = "", order = 2},
                    actionBars = {
                        order = 10,
                        type = "group",
                        name = L["Action Bars & Buttons"],
                        args = {
                            actionButtonBorder = {
                                order = 1,
                                type = "select",
                                name = L["Action Button Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.actionButtonBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.actionButtonBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            actionButtonBorderColor = {
                                order = 2,
                                type = "color",
                                name = L["Action Button Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.actionButtonBorderColor
                                    local d = P[addonName].artwork.actionButtonBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.actionButtonBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            }
                        }
                    },
                    bags = {
                        order = 20,
                        type = "group",
                        name = L["Bags & Item Buttons"],
                        args = {
                            bagButtonBorder = {
                                order = 1,
                                type = "select",
                                name = L["Bag Slot Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.bagButtonBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.bagButtonBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            bagButtonBorderColor = {
                                order = 2,
                                type = "color",
                                name = L["Bag Slot Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.bagButtonBorderColor
                                    local d = P[addonName].artwork.bagButtonBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.bagButtonBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            itemButtonBorder = {
                                order = 3,
                                type = "select",
                                name = L["Item Button Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.itemButtonBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.itemButtonBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            itemButtonBorderColor = {
                                order = 4,
                                type = "color",
                                name = L["Item Button Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.itemButtonBorderColor
                                    local d = P[addonName].artwork.itemButtonBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.itemButtonBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            }
                        }
                    },
                    buffsDebuffs = {
                        order = 30,
                        type = "group",
                        name = L["Buffs & Debuffs"],
                        args = {
                            auraBorder = {
                                order = 1,
                                type = "select",
                                name = L["Aura Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.auraBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.auraBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            auraBorderColor = {
                                order = 2,
                                type = "color",
                                name = L["Aura Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.auraBorderColor
                                    local d = P[addonName].artwork.auraBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.auraBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            tempEnchantBorder = {
                                order = 3,
                                type = "select",
                                name = L["Temp Enchant Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.tempEnchantBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.tempEnchantBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            tempEnchantBorderColor = {
                                order = 4,
                                type = "color",
                                name = L["Temp Enchant Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.tempEnchantBorderColor
                                    local d = P[addonName].artwork.tempEnchantBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.tempEnchantBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            }
                        }
                    },
                    skins = {
                        order = 40,
                        type = "group",
                        name = L["Skins"],
                        args = {
                            frameBorder = {
                                order = 1,
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
                            frameBorderColor = {
                                order = 2,
                                type = "color",
                                name = L["Frame Border Color"],
                                hasAlpha = true,
                                get = function(info)
                                    local t = E.db[addonName].artwork.frameBorderColor
                                    local d = P[addonName].artwork.frameBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b, a)
                                    local t = E.db[addonName].artwork.frameBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            frameTabBorder = {
                                order = 3,
                                type = "select",
                                name = L["Frame Tab Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.frameTabBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.frameTabBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            frameTabBorderColor = {
                                order = 4,
                                type = "color",
                                name = L["Frame Tab Border Color"],
                                hasAlpha = true,
                                get = function(info)
                                    local t = E.db[addonName].artwork.frameTabBorderColor
                                    local d = P[addonName].artwork.frameTabBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b, a)
                                    local t = E.db[addonName].artwork.frameTabBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            thinFrameBorder = {
                                order = 5,
                                type = "select",
                                name = L["Thin Frame Border Theme"],
                                values = Addon.borders,
                                get = function()
                                    for key, val in pairs(Addon.borders) do
                                        if E.db[addonName].artwork.thinFrameBorder == val then
                                            return key
                                        end
                                    end
                                end,
                                set = function(_, key)
                                    E.db[addonName].artwork.thinFrameBorder = Addon.borders[key]
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            thinFrameBorderColor = {
                                order = 6,
                                type = "color",
                                name = L["Thin Frame Border Color"],
                                hasAlpha = true,
                                get = function(info)
                                    local t = E.db[addonName].artwork.thinFrameBorderColor
                                    local d = P[addonName].artwork.thinFrameBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b, a)
                                    local t = E.db[addonName].artwork.thinFrameBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            frameBackground = {
                                order = 7,
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
                                order = 8,
                                type = "color",
                                name = L["Frame Background Color"],
                                hasAlpha = true,
                                get = function(info)
                                    local t = E.db[addonName].artwork.frameBackgroundColor
                                    local d = P[addonName].artwork.frameBackgroundColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b, a)
                                    local t = E.db[addonName].artwork.frameBackgroundColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            buttonBorder = {
                                order = 20,
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
                                order = 21,
                                type = "color",
                                name = L["Button Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.buttonBorderColor
                                    local d = P[addonName].artwork.buttonBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.buttonBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            },
                            buttonBorderHighlightColor = {
                                order = 22,
                                type = "color",
                                name = L["Button Border Highlight Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.buttonBorderHighlightColor
                                    local d = P[addonName].artwork.buttonBorderHighlightColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.buttonBorderHighlightColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            }
                        }
                    },
                    tooltips = {
                        order = 50,
                        type = "group",
                        name = L["Tooltips"],
                        args = {
                            tooltipBorder = {
                                order = 1,
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
                                order = 2,
                                type = "color",
                                name = L["Tooltip Border Color"],
                                get = function(info)
                                    local t = E.db[addonName].artwork.tooltipBorderColor
                                    local d = P[addonName].artwork.tooltipBorderColor
                                    return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                end,
                                set = function(info, r, g, b)
                                    local t = E.db[addonName].artwork.tooltipBorderColor
                                    t[1], t[2], t[3], t[4] = r, g, b, a
                                    Addon.Artwork:UpdateArtwork()
                                end
                            }
                        }
                    },
                    unitFrames = {
                        order = 60,
                        type = "group",
                        name = L["Unit Frames"],
                        args = {
                            player = {
                                order = 1,
                                type = "group",
                                name = L["Player"],
                                args = {
                                    border = {
                                        order = 1,
                                        type = "select",
                                        name = L["Border Theme"],
                                        values = Addon.borders,
                                        get = function()
                                            for key, val in pairs(Addon.borders) do
                                                if E.db[addonName].artwork.unitFrames.player.border == val then
                                                    return key
                                                end
                                            end
                                        end,
                                        set = function(_, key)
                                            E.db[addonName].artwork.unitFrames.player.border = Addon.borders[key]
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    borderColor = {
                                        order = 2,
                                        type = "color",
                                        name = L["Border Color"],
                                        get = function(info)
                                            local t = E.db[addonName].artwork.unitFrames.player.borderColor
                                            local d = P[addonName].artwork.unitFrames.player.borderColor
                                            return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                        end,
                                        set = function(info, r, g, b)
                                            local t = E.db[addonName].artwork.unitFrames.player.borderColor
                                            t[1], t[2], t[3], t[4] = r, g, b, a
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    healthBorder = {
                                        order = 3,
                                        type = "select",
                                        name = L["Health Border Theme"],
                                        values = Addon.borders,
                                        get = function()
                                            for key, val in pairs(Addon.borders) do
                                                if E.db[addonName].artwork.unitFrames.player.healthBorder == val then
                                                    return key
                                                end
                                            end
                                        end,
                                        set = function(_, key)
                                            E.db[addonName].artwork.unitFrames.player.healthBorder = Addon.borders[key]
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    healthBorderColor = {
                                        order = 4,
                                        type = "color",
                                        name = L["Health Border Color"],
                                        get = function(info)
                                            local t = E.db[addonName].artwork.unitFrames.player.healthBorderColor
                                            local d = P[addonName].artwork.unitFrames.player.healthBorderColor
                                            return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                        end,
                                        set = function(info, r, g, b)
                                            local t = E.db[addonName].artwork.unitFrames.player.healthBorderColor
                                            t[1], t[2], t[3], t[4] = r, g, b, a
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    powerBorder = {
                                        order = 5,
                                        type = "select",
                                        name = L["Power Border Theme"],
                                        values = Addon.borders,
                                        get = function()
                                            for key, val in pairs(Addon.borders) do
                                                if E.db[addonName].artwork.unitFrames.player.powerBorder == val then
                                                    return key
                                                end
                                            end
                                        end,
                                        set = function(_, key)
                                            E.db[addonName].artwork.unitFrames.player.powerBorder = Addon.borders[key]
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    powerBorderColor = {
                                        order = 6,
                                        type = "color",
                                        name = L["Power Border Color"],
                                        get = function(info)
                                            local t = E.db[addonName].artwork.unitFrames.player.powerBorderColor
                                            local d = P[addonName].artwork.unitFrames.player.powerBorderColor
                                            return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                        end,
                                        set = function(info, r, g, b)
                                            local t = E.db[addonName].artwork.unitFrames.player.powerBorderColor
                                            t[1], t[2], t[3], t[4] = r, g, b, a
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    castBarBorder = {
                                        order = 7,
                                        type = "select",
                                        name = L["Castbar Border Theme"],
                                        values = Addon.borders,
                                        get = function()
                                            for key, val in pairs(Addon.borders) do
                                                if E.db[addonName].artwork.unitFrames.player.castBarBorder == val then
                                                    return key
                                                end
                                            end
                                        end,
                                        set = function(_, key)
                                            E.db[addonName].artwork.unitFrames.player.castBarBorder = Addon.borders[key]
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    },
                                    castBarBorderColor = {
                                        order = 8,
                                        type = "color",
                                        name = L["Castbar Border Color"],
                                        get = function(info)
                                            local t = E.db[addonName].artwork.unitFrames.player.castBarBorderColor
                                            local d = P[addonName].artwork.unitFrames.player.castBarBorderColor
                                            return t[1], t[2], t[3], t[4], d[1], d[2], d[3], d[4] or 1
                                        end,
                                        set = function(info, r, g, b)
                                            local t = E.db[addonName].artwork.unitFrames.player.castBarBorderColor
                                            t[1], t[2], t[3], t[4] = r, g, b, a
                                            Addon.Artwork:UpdateArtwork()
                                        end
                                    }
                                }
                            }
                        }
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
