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
        actionBars = {actionButtonBorder = "BeautyCase", actionButtonBorderColor = {60 / 255, 60 / 255, 60 / 255}},
        auras = {
            auraBorder = "BeautyCase",
            auraBorderColor = {60 / 255, 60 / 255, 60 / 255},
            tempEnchantBorder = "BeautyCase",
            tempEnchantBorderColor = {60 / 255, 60 / 255, 60 / 255}
        },
        bagsAndItems = {
            bagButtonBorder = "BeautyCase",
            bagButtonBorderColor = {60 / 255, 60 / 255, 60 / 255},
            itemButtonBorder = "BeautyCase",
            itemButtonBorderColor = {60 / 255, 60 / 255, 60 / 255}
        },
        dataBarsAndPanels = {
            dataBarBorder = "BeautyCase",
            dataBarBorderColor = {60 / 255, 60 / 255, 60 / 255},
            dataPanelBorder = "BeautyCase",
            dataPanelBorderColor = {60 / 255, 60 / 255, 60 / 255}
        },
        namePlates = {
            border = "None",
            borderColor = {60 / 255, 60 / 255, 60 / 255},
            healthBorder = "BeautyCase",
            healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
            powerBorder = "BeautyCase",
            powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
            castBarBorder = "BeautyCase",
            castBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
        },
        minimap = {border = "BeautyCase", borderColor = {60 / 255, 60 / 255, 60 / 255}},
        skins = {
            frameBorder = "Metal",
            frameBorderColor = {1, 1, 1},
            frameBackground = "Necrolord",
            frameBackgroundColor = {1, 1, 1, 1},
            frameTabBorder = "Shadowlands",
            frameTabBorderColor = {139 / 255, 129 / 255, 118 / 255},
            thinFrameBorder = "BeautyCase",
            thinFrameBorderColor = {60 / 255, 60 / 255, 60 / 255},
            useThinFrameEverywhere = false,
            buttonBorder = "BeautyCase",
            buttonBorderColor = {60 / 255, 60 / 255, 60 / 255},
            buttonBorderHighlightColor = {90 / 255, 90 / 255, 90 / 255}
        },
        tooltips = {tooltipBorder = "BeautyCase", tooltipBorderColor = {60 / 255, 60 / 255, 60 / 255}},
        unitFrames = {
            ["player"] = {
                border = "None",
                borderColor = {60 / 255, 60 / 255, 60 / 255},
                healthBorder = "BeautyCase",
                healthBorderColor = {60 / 255, 60 / 255, 60 / 255},
                powerBorder = "BeautyCase",
                powerBorderColor = {60 / 255, 60 / 255, 60 / 255},
                castBarBorder = "BeautyCase",
                castBarBorderColor = {60 / 255, 60 / 255, 60 / 255},
                classBarBorder = "BeautyCase",
                classBarBorderColor = {60 / 255, 60 / 255, 60 / 255}
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
    shadows = {enabled = true, color = {0, 0, 0, 0.7}, size = 5, shadowPerButton = true},
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
                    desc = Addon:CreateOptionDescription(L["The Artwork module adds borders, backgrounds, and other art to most ElvUI elements."], 0),
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, {"artwork", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    actionBars = {
                        order = 10,
                        type = "group",
                        name = L["Action Bars & Buttons"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Action Bars & Buttons"], 0),
                            border = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Action Buttons"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "actionBars",
                                        "actionButtonBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "actionBars",
                                        "actionButtonBorderColor"
                                    })
                                }
                            }
                        }
                    },
                    bags = {
                        order = 20,
                        type = "group",
                        name = L["Bags & Item Buttons"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Bags & Item Buttons"], 0),
                            bagSlots = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Bag Slots"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "bagsAndItems",
                                        "bagButtonBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "bagsAndItems",
                                        "bagButtonBorderColor"
                                    })
                                }
                            },
                            itemButtons = {
                                order = 2,
                                type = "group",
                                inline = true,
                                name = L["Item Buttons"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "bagsAndItems",
                                        "itemButtonBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "bagsAndItems",
                                        "itemButtonBorderColor"
                                    })
                                }
                            }
                        }
                    },
                    buffsDebuffs = {
                        order = 30,
                        type = "group",
                        name = L["Buffs & Debuffs"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Buffs & Debuffs"], 0),
                            auras = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Auras"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "auras",
                                        "auraBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "auras",
                                        "auraBorderColor"
                                    })
                                }
                            },
                            tempEnchants = {
                                order = 2,
                                type = "group",
                                inline = true,
                                name = L["Temp Enchants"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "auras",
                                        "tempEnchantBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "auras",
                                        "tempEnchantBorderColor"
                                    })
                                }
                            }
                        }
                    },
                    dataBarsAndPanels = {
                        order = 40,
                        type = "group",
                        name = L["Data Bars & Panels"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Data Bars & Panels"], 0),
                            dataBars = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Data Bars"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "dataBarsAndPanels",
                                        "dataBarBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "dataBarsAndPanels",
                                        "dataBarBorderColor"
                                    })
                                }
                            },
                            dataPanels = {
                                order = 2,
                                type = "group",
                                inline = true,
                                name = L["Data Panels"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "dataBarsAndPanels",
                                        "dataPanelBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "dataBarsAndPanels",
                                        "dataPanelBorderColor"
                                    })
                                }
                            }
                        }
                    },
                    minimap = {
                        order = 50,
                        type = "group",
                        name = L["Minimap"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Minimap"], 0),
                            border = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Border"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "minimap", "border"}),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "minimap",
                                        "borderColor"
                                    })
                                }
                            }
                        }
                    },
                    namePlates = {
                        order = 60,
                        type = "group",
                        name = L["Nameplates"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Nameplates"], 0),
                            border = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Border"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "namePlates",
                                        "border"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "namePlates",
                                        "borderColor"
                                    })
                                }
                            },
                            healthBorder = {
                                order = 2,
                                type = "group",
                                inline = true,
                                name = L["Health"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "namePlates",
                                        "healthBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "namePlates",
                                        "healthBorderColor"
                                    })
                                }
                            },
                            powerBorder = {
                                order = 3,
                                type = "group",
                                inline = true,
                                name = L["Power"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "namePlates",
                                        "powerBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "namePlates",
                                        "powerBorderColor"
                                    })
                                }
                            },
                            castBarBorder = {
                                order = 4,
                                type = "group",
                                inline = true,
                                name = L["Castbar"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "namePlates",
                                        "castBarBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "namePlates",
                                        "castBarBorderColor"
                                    })
                                }
                            }
                        }
                    },
                    skins = {
                        order = 70,
                        type = "group",
                        name = L["Skins"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Skins"], 0),
                            frameBorders = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Frame Borders"],
                                args = {
                                    desc = Addon:CreateOptionDescription(L["This controls the borders for larger UI frames (character screen etc)."], 0),
                                    border = Addon:CreateFrameBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "skins",
                                        "frameBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "frameBorderColor"
                                    })
                                }
                            },
                            thinFrameBorder = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Thin Frame Borders"],
                                args = {
                                    desc = Addon:CreateOptionDescription(L["This controls the borders for smaller UI frames (popups etc)."], 0),
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "skins",
                                        "thinFrameBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "thinFrameBorderColor"
                                    }),
                                    useThinFrameEverywhere = Addon:CreateToggleOption(L["Use Thin Frame Everywhere"], L["When checked, use the Thin Frame Border for all frames, ignoring the normal Frame Border."], 3, {
                                        "artwork",
                                        "skins",
                                        "useThinFrameEverywhere"
                                    })
                                }
                            },
                            tabs = {
                                order = 3,
                                type = "group",
                                inline = true,
                                name = L["Frame Tabs"],
                                args = {
                                    desc = Addon:CreateOptionDescription(L["This controls the borders for the tabs on e.g. the character screen."], 0),
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "skins",
                                        "frameTabBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "frameTabBorderColor"
                                    })
                                }
                            },
                            frameBackgrounds = {
                                order = 4,
                                type = "group",
                                inline = true,
                                name = L["Frame Background"],
                                args = {
                                    border = Addon:CreateFrameBackgroundOption(L["Background Theme"], 1, {
                                        "artwork",
                                        "skins",
                                        "frameBackground"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Background Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "frameBackgroundColor"
                                    })
                                }
                            },
                            buttons = {
                                order = 4,
                                type = "group",
                                inline = true,
                                name = L["Frame Buttons"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {
                                        "artwork",
                                        "skins",
                                        "buttonBorder"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "buttonBorderColor"
                                    }),
                                    borderColor = Addon:CreateColorOption(L["Border Highlight Color"], 2, {
                                        "artwork",
                                        "skins",
                                        "buttonBorderHighlightColor"
                                    })
                                }
                            }
                        }
                    },
                    tooltips = {
                        order = 80,
                        type = "group",
                        name = L["Tooltips"],
                        args = {
                            header = Addon:CreateOptionHeader(L["Tooltips"], 0),
                            border = {
                                order = 1,
                                type = "group",
                                inline = true,
                                name = L["Border"],
                                args = {
                                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "tooltips", "tooltipBorder"}),
                                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {"artwork", "tooltips", "tooltipBorderColor"})
                                }
                            }
                        }
                    },
                    unitFrames = {
                        order = 90,
                        type = "group",
                        name = L["Unit Frames"],
                        args = {
                            player = Addon:CreateUnitFrameOptions("player", L["Player"], 1),
                            pet = Addon:CreateUnitFrameOptions("pet", L["Pet"], 2),
                            target = Addon:CreateUnitFrameOptions("target", L["Target"], 3),
                            targettarget = Addon:CreateUnitFrameOptions("targettarget", L["Target's Target"], 4),
                            focus = Addon:CreateUnitFrameOptions("focus", L["Focus Target"], 5, Addon.isClassic),
                            focustarget = Addon:CreateUnitFrameOptions("focustarget", L["Focus Target's Target"], 6, Addon.isClassic)
                        }
                    }
                }
            },
            automation = {
                order = 20,
                type = "group",
                name = L["Automation"],
                args = {
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, {"automation", "enabled"}),
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
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, {"shadows", "enabled"}),
                    lineBreak = {type = "header", name = "", order = 2},
                    color = Addon:CreateColorOption(L["Shadow Color"], 10, {"shadows", "color"}),
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
                    },
                    shadowPerButton = {
                        order = 21,
                        type = "toggle",
                        name = L["Shadow Per Button"],
                        get = function(info)
                            return E.db[addonName].shadows.shadowPerButton
                        end,
                        set = function(info, value)
                            E.db[addonName].shadows.shadowPerButton = value
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
                    enabled = Addon:CreateToggleOption(L["Enabled"], nil, 1, {"tooltips", "enabled"}),
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

function Addon:CreateToggleOption(caption, desc, order, setting)
    return {
        order = order,
        type = "toggle",
        desc = desc,
        name = caption,
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
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                        "artwork",
                        "unitFrames",
                        unit,
                        "healthBorderColor"
                    })
                }
            },
            powerBar = {
                order = 3,
                type = "group",
                inline = true,
                name = L["Power Bar"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "powerBorder"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                        "artwork",
                        "unitFrames",
                        unit,
                        "powerBorderColor"
                    })
                }
            },
            castBar = {
                order = 4,
                type = "group",
                inline = true,
                name = L["Castbar"],
                args = {
                    border = Addon:CreateBorderThemeOption(L["Border Theme"], 1, {"artwork", "unitFrames", unit, "castBarBorder"}),
                    borderColor = Addon:CreateColorOption(L["Border Color"], 2, {
                        "artwork",
                        "unitFrames",
                        unit,
                        "castBarBorderColor"
                    })
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
