local addonName, addonTable = ...
local Addon = addonTable[1]
local Installer = Addon:NewModule(addonName .. "Installer", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Installer = Installer
local E, L, V, P, G = unpack(ElvUI)

local DEFAULT_FONT = "Expressway"
local DEFAULT_STATUSBAR = "Redux"

function Installer:Install()
    Installer:SetupGeneral()
    Installer:SetupActionBars()
    Installer:SetupAuras()
    Installer:SetupBags()
    Installer:SetupChat()
    Installer:SetupDatabars()
    Installer:SetupDatatexts()
    Installer:SetupNameplates()
    Installer:SetupTooltip()
    Installer:SetupUnitFrames()
    Installer:SetupMovers()
    Installer:SetupPlugins()
    Installer.reloadRequired = true
    E.db[addonName].version = Addon.version
end

function Installer:CreateProfile()
    E.PopupDialogs.ReduxUI_CreateProfileNameNew = {
        text = "Name for the new profile",
        hasEditBox = 1,
        whileDead = 1,
        hideOnEscape = 1,
        button1 = OKAY,
        button2 = CANCEL,
        OnShow = function(frame)
            frame.editBox:SetAutoFocus(false)
            frame.editBox.width = frame.editBox:GetWidth()
            frame.editBox:Width(220)
            frame.editBox:SetText("ElvUI Redux")
            frame.editBox:HighlightText()
        end,
        OnHide = function(frame)
            frame.editBox:Width(frame.editBox.width or 50)
            frame.editBox.width = nil
        end,
        OnAccept = function(frame)
            local text = frame.editBox:GetText()
            E.data:SetProfile(text)
            E:StaticPopup_Hide("INCOMPATIBLE_ADDON")
            -- Installer:ShowStepComplete("Profile created")
            _G.PluginInstallFrame.Desc3:SetText("Your currently active profile is: " .. E.data:GetCurrentProfile())
        end,
        EditBoxOnEnterPressed = function(frame)
            frame:GetParent():Hide()
        end,
        EditBoxOnEscapePressed = function(frame)
            frame:GetParent():Hide()
        end,
        EditBoxOnTextChanged = E.noop,
        OnEditFocusGained = function(frame)
            frame:HighlightText()
        end
    }

    E:StaticPopup_Show("ReduxUI_CreateProfileNameNew")
end

function Installer:SetupGeneral()
    E.db["v11NamePlateReset"] = true
    E.db["general"]["font"] = DEFAULT_FONT
    E.db["general"]["interruptAnnounce"] = "SAY"
    E.db["general"]["valuecolor"] = {["r"] = 0.25, ["g"] = 0.78, ["b"] = 0.92}
    E.db["general"]["backdropcolor"] = {["a"] = 1}
    E.db["general"]["backdropfadecolor"] = {["a"] = 0.8, ["r"] = 0.059, ["g"] = 0.059, ["b"] = 0.059}
    E.db["general"]["bordercolor"] = {["r"] = 0.28, ["g"] = 0.28, ["b"] = 0.28}
    E.db["general"]["autoRepair"] = true
    E.db["general"]["topPanel"] = true
    E.db["general"]["minimap"]["locationText"] = "SHOW"
    E.db["general"]["minimap"]["locationFont"] = DEFAULT_FONT
    E.db["general"]["minimap"]["locationFontSize"] = 14
    if Addon.isClassic then
        E.db["general"]["minimap"]["icons"]["tracking"]["scale"] = 0.75
    elseif Addon.isTbc then
        E.db["general"]["minimap"]["icons"]["tracking"]["scale"] = 0.6
        E.db["general"]["minimap"]["icons"]["tracking"]["xOffset"] = -8
        E.db["general"]["minimap"]["icons"]["tracking"]["yOffset"] = 6
    end

    E.private["general"]["dmgfont"] = "Adventure"
    E.private["general"]["normTex"] = DEFAULT_STATUSBAR
    E.private["general"]["namefont"] = DEFAULT_FONT
    E.private["general"]["glossTex"] = DEFAULT_STATUSBAR
    E.private["general"]["chatBubbles"] = "backdrop"
    E.private["general"]["chatBubbleFont"] = DEFAULT_FONT
    E.private["general"]["chatBubbleFontOutline"] = "OUTLINE"
    E.private["general"]["chatBubbleFontSize"] = 11

    E.global["general"]["smallerWorldMapScale"] = 0.75
end

function Installer:SetupActionBars()
    E.db["actionbar"]["font"] = DEFAULT_FONT
    E.db["actionbar"]["fontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar1"]["enabled"] = true
    E.db["actionbar"]["bar1"]["buttons"] = 12
    E.db["actionbar"]["bar1"]["buttonsPerRow"] = 6
    E.db["actionbar"]["bar1"]["buttonSize"] = 38
    E.db["actionbar"]["bar1"]["buttonSpacing"] = 2
    E.db["actionbar"]["bar1"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar1"]["backdrop"] = false
    E.db["actionbar"]["bar1"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar1"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar1"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar2"]["enabled"] = false
    E.db["actionbar"]["bar2"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar2"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar2"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar3"]["enabled"] = true
    E.db["actionbar"]["bar3"]["buttons"] = 12
    E.db["actionbar"]["bar3"]["buttonsPerRow"] = 1
    E.db["actionbar"]["bar3"]["mouseover"] = true
    E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar3"]["backdrop"] = false
    E.db["actionbar"]["bar3"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar3"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar3"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar4"]["enabled"] = true
    E.db["actionbar"]["bar4"]["buttons"] = 12
    E.db["actionbar"]["bar4"]["buttonsPerRow"] = 1
    E.db["actionbar"]["bar4"]["mouseover"] = true
    E.db["actionbar"]["bar4"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar4"]["backdrop"] = false
    E.db["actionbar"]["bar4"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar4"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar4"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar5"]["enabled"] = true
    E.db["actionbar"]["bar5"]["buttons"] = 12
    E.db["actionbar"]["bar5"]["buttonsPerRow"] = 12
    E.db["actionbar"]["bar5"]["mouseover"] = false
    E.db["actionbar"]["bar5"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar5"]["backdrop"] = false
    E.db["actionbar"]["bar5"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar5"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar5"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar6"]["enabled"] = true
    E.db["actionbar"]["bar6"]["buttons"] = 12
    E.db["actionbar"]["bar6"]["buttonsPerRow"] = 12
    E.db["actionbar"]["bar6"]["mouseover"] = false
    E.db["actionbar"]["bar6"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar6"]["backdrop"] = false
    E.db["actionbar"]["bar6"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar6"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar6"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar7"]["enabled"] = false
    E.db["actionbar"]["bar7"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar7"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar7"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar8"]["enabled"] = false
    E.db["actionbar"]["bar8"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar8"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar8"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar8"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["bar9"]["enabled"] = false
    E.db["actionbar"]["bar9"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar9"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["bar9"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["bar9"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
    E.db["actionbar"]["barPet"]["point"] = "TOPLEFT"
    E.db["actionbar"]["barPet"]["backdrop"] = false
    E.db["actionbar"]["barPet"]["countFont"] = DEFAULT_FONT
    E.db["actionbar"]["barPet"]["countFontOutline"] = "OUTLINE"
    E.db["actionbar"]["barPet"]["hotkeyFont"] = DEFAULT_FONT
    E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "OUTLINE"

    E.db["actionbar"]["microbar"]["buttons"] = 8
    E.db["actionbar"]["microbar"]["backdrop"] = true
    E.db["actionbar"]["microbar"]["mouseover"] = true
end

function Installer:SetupAuras()
    E.db["auras"]["font"] = DEFAULT_FONT
    E.db["auras"]["fontOutline"] = "OUTLINE"

    E.db["auras"]["buffs"]["countFont"] = DEFAULT_FONT
    E.db["auras"]["buffs"]["countFontOutline"] = "OUTLINE"
    E.db["auras"]["buffs"]["countFontSize"] = 12
    E.db["auras"]["buffs"]["timeFont"] = DEFAULT_FONT
    E.db["auras"]["buffs"]["timeFontOutline"] = "OUTLINE"
    E.db["auras"]["buffs"]["timeFontSize"] = 12
    E.db["auras"]["buffs"]["durationFontSize"] = 12

    E.db["auras"]["debuffs"]["countFont"] = DEFAULT_FONT
    E.db["auras"]["debuffs"]["countFontOutline"] = "OUTLINE"
    E.db["auras"]["debuffs"]["countFontSize"] = 12
    E.db["auras"]["debuffs"]["timeFont"] = DEFAULT_FONT
    E.db["auras"]["debuffs"]["timeFontOutline"] = "OUTLINE"
    E.db["auras"]["debuffs"]["timeFontSize"] = 12
    E.db["auras"]["debuffs"]["durationFontSize"] = 12
end

function Installer:SetupBags()
    E.db["bags"]["bagWidth"] = 411
    E.db["bags"]["bankWidth"] = 411
    E.db["bags"]["itemLevelFont"] = DEFAULT_FONT
    E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
    E.db["bags"]["itemLevelFontSize"] = 12
    E.db["bags"]["countFont"] = DEFAULT_FONT
    E.db["bags"]["countFontOutline"] = "OUTLINE"
    E.db["bags"]["countFontSize"] = 12
    E.db["bags"]["junkIcon"] = true
    E.db["bags"]["itemLevel"] = false
    E.db["bags"]["colorBackdrop"] = false
    E.db["bags"]["vendorGrays"]["enable"] = true
end

function Installer:SetupChat()
    E.db["chat"]["font"] = DEFAULT_FONT
    E.db["chat"]["fontOutline"] = "OUTLINE"
    E.db["chat"]["fontSize"] = 12
    E.db["chat"]["tabFont"] = DEFAULT_FONT
    E.db["chat"]["tabFontOutline"] = "OUTLINE"
    E.db["chat"]["timeStampFormat"] = "%H:%M:%S "
    E.db["chat"]["timeStampLocalTime"] = true
    E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
    E.db["chat"]["historySize"] = 500
end

function Installer:SetupDatabars()
    E.db["databars"]["experience"]["enable"] = true
    E.db["databars"]["experience"]["width"] = 222
    E.db["databars"]["reputation"]["enable"] = true
    E.db["databars"]["reputation"]["width"] = 222
    E.db["databars"]["threat"]["enable"] = true
    E.db["databars"]["threat"]["width"] = 234
end

function Installer:SetupDatatexts()
    E.db["datatexts"]["font"] = DEFAULT_FONT
    E.db["datatexts"]["fontOutline"] = "OUTLINE"
    E.db["datatexts"]["panels"] = {
        ["LeftChatDataPanel"] = {
            nil, -- [1]
            "System", -- [2]
            "Mail" -- [3]
        },
        ["RightChatDataPanel"] = {
            "Durability", -- [1]
            "Bags" -- [2]
        },
        ["MinimapPanel"] = {
            "Friends", -- [1]
            "Guild" -- [2]
        },
        ["Top Panel"] = {
            "Guild", -- [1]
            "", -- [2]
            "Friends", -- [3]
            ["enable"] = false
        },
        ["Top Panel (Center)"] = {
            "Time", -- [1]
            ["enable"] = true
        }
    }

    E.global["datatexts"]["customPanels"] = E.global["datatexts"]["customPanels"] or {}
    E.global["datatexts"]["customPanels"]["Top Panel"] = {
        ["enable"] = true,
        ["name"] = "Top Panel",
        ["width"] = 300,
        ["height"] = 22,
        ["panelTransparency"] = false,
        ["border"] = true,
        ["tooltipYOffset"] = 4,
        ["numPoints"] = 3,
        ["tooltipAnchor"] = "ANCHOR_TOPLEFT",
        ["frameLevel"] = 1,
        ["frameStrata"] = "LOW",
        ["mouseover"] = false,
        ["fonts"] = {["enable"] = false, ["font"] = "PT Sans Narrow", ["fontSize"] = 12, ["fontOutline"] = "OUTLINE"},
        ["growth"] = "HORIZONTAL",
        ["backdrop"] = true,
        ["tooltipXOffset"] = -17,
        ["visibility"] = "show"
    }
    E.global["datatexts"]["customPanels"]["Top Panel (Center)"] = {
        ["enable"] = true,
        ["name"] = "Top Panel (Center)",
        ["width"] = 100,
        ["height"] = 40,
        ["panelTransparency"] = false,
        ["border"] = true,
        ["tooltipYOffset"] = 4,
        ["numPoints"] = 1,
        ["tooltipAnchor"] = "ANCHOR_TOPLEFT",
        ["frameLevel"] = 10,
        ["frameStrata"] = "LOW",
        ["mouseover"] = false,
        ["fonts"] = {["enable"] = true, ["font"] = "Expressway", ["fontSize"] = 24, ["fontOutline"] = "OUTLINE"},
        ["growth"] = "HORIZONTAL",
        ["backdrop"] = false,
        ["tooltipXOffset"] = -17,
        ["visibility"] = "show"
    }
end

function Installer:SetupNameplates()
    E.db["nameplates"]["font"] = DEFAULT_FONT
    E.db["nameplates"]["statusbar"] = DEFAULT_STATUSBAR
    E.db["nameplates"]["units"] = {
        ["TARGET"] = {
            ["arrowScale"] = 0.5,
            ["arrow"] = "Arrow30",
            ["classpower"] = {["width"] = 105},
            ["glowStyle"] = "style8",
            ["arrowSpacing"] = 5
        },
        ["FRIENDLY_NPC"] = {["health"] = {["text"] = {["font"] = "Expressway"}}},
        ["FRIENDLY_PLAYER"] = {["health"] = {["text"] = {["font"] = "Expressway"}}},
        ["ENEMY_NPC"] = {
            ["debuffs"] = {["priority"] = "Blacklist,Personal,CCDebuffs,RaidDebuffs"},
            ["health"] = {["text"] = {["font"] = "Expressway", ["format"] = "[health:current:shortvalue]"}}
        },
        ["ENEMY_PLAYER"] = {["health"] = {["text"] = {["font"] = "Expressway"}}}
    }
end

function Installer:SetupTooltip()
    E.db["tooltip"]["font"] = DEFAULT_FONT
    E.db["tooltip"]["fontSize"] = 12
    E.db["tooltip"]["cursorAnchor"] = true
    E.db["tooltip"]["cursorAnchorType"] = "ANCHOR_CURSOR_RIGHT"
    E.db["tooltip"]["cursorAnchorX"] = 20
    E.db["tooltip"]["cursorAnchorY"] = 10
    E.db["tooltip"]["itemCount"] = "NONE"
    E.db["tooltip"]["itemQualityBorderColor"] = true
    E.db["tooltip"]["modifierID"] = "HIDE"
    E.db["tooltip"]["healthBar"]["statusPosition"] = "TOP"
    E.db["tooltip"]["healthBar"]["font"] = DEFAULT_FONT
end

function Installer:SetupUnitFrames()
    E.db["unitframe"]["targetSound"] = true
    E.db["unitframe"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["fontOutline"] = "OUTLINE"
    E.db["unitframe"]["statusbar"] = DEFAULT_STATUSBAR
    E.db["unitframe"]["smoothbars"] = true
    E.db["unitframe"]["colors"]["healthclass"] = true
    E.db["unitframe"]["colors"]["castClassColor"] = true
    E.db["unitframe"]["colors"]["borderColor"] = {["a"] = 1, ["r"] = 0.28, ["g"] = 0.28, ["b"] = 0.28}
    E.db["unitframe"]["colors"]["auraBarBuff"] = {["r"] = 0.25, ["g"] = 0.78, ["b"] = 0.92}

    E.db["unitframe"]["units"]["player"]["width"] = 240
    E.db["unitframe"]["units"]["player"]["height"] = 38
    E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
    E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = 10
    E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 234
    E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 25
    E.db["unitframe"]["units"]["player"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["power"]["height"] = 20
    E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
    E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 234
    E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["power"]["powerPrediction"] = true
    E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
    E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
    E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 234
    E.db["unitframe"]["units"]["player"]["raidRoleIcons"]["xOffset"] = 2
    E.db["unitframe"]["units"]["player"]["raidRoleIcons"]["yOffset"] = -18
    E.db["unitframe"]["units"]["player"]["RestIcon"]["yOffset"] = 3
    E.db["unitframe"]["units"]["player"]["customTexts"] = {
        ["CustomName"] = {
            ["attachTextTo"] = "Frame",
            ["xOffset"] = 2,
            ["text_format"] = "[difficultycolor][level]||r [namecolor][name]",
            ["yOffset"] = 20,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomPower"] = {
            ["attachTextTo"] = "Power",
            ["xOffset"] = 0,
            ["text_format"] = "[power:current]",
            ["yOffset"] = 0,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "CENTER",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomHealth"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = -5,
            ["text_format"] = "[health:current:shortvalue]",
            ["yOffset"] = 0,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "RIGHT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomHealthPercent"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 0,
            ["text_format"] = "[health:percent]",
            ["yOffset"] = 22,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "RIGHT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        }
    }

    E.db["unitframe"]["units"]["target"]["width"] = 240
    E.db["unitframe"]["units"]["target"]["height"] = 38
    E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
    E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = 10
    E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 240
    E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["target"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["target"]["raidRoleIcons"]["position"] = "TOPRIGHT"
    E.db["unitframe"]["units"]["target"]["raidRoleIcons"]["xOffset"] = 2
    E.db["unitframe"]["units"]["target"]["raidRoleIcons"]["yOffset"] = -18
    E.db["unitframe"]["units"]["target"]["customTexts"] = {
        ["CustomName"] = {
            ["attachTextTo"] = "Frame",
            ["xOffset"] = -2,
            ["text_format"] = "[namecolor][name:long] [difficultycolor][level][shortclassification]",
            ["yOffset"] = 20,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "RIGHT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomPower"] = {
            ["attachTextTo"] = "Power",
            ["xOffset"] = 0,
            ["text_format"] = "[power:current]",
            ["yOffset"] = 5,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "CENTER",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 10
        },
        ["CustomHealth"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 5,
            ["text_format"] = "[health:current:shortvalue]",
            ["yOffset"] = 0,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomHealthPercent"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 2,
            ["text_format"] = "[health:percent]",
            ["yOffset"] = 16,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        }
    }

    E.db["unitframe"]["units"]["targettarget"]["height"] = 30
    E.db["unitframe"]["units"]["targettarget"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] = false
    E.db["unitframe"]["units"]["targettarget"]["customTexts"] = {
        ["CustomName"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 0,
            ["text_format"] = "[name:medium]",
            ["yOffset"] = 0,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "CENTER",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        }
    }

    E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 130

    E.db["unitframe"]["units"]["focus"]["width"] = 240
    E.db["unitframe"]["units"]["focus"]["height"] = 38
    E.db["unitframe"]["units"]["focus"]["disableTargetGlow"] = true
    E.db["unitframe"]["units"]["focus"]["middleClickFocus"] = true
    E.db["unitframe"]["units"]["focus"]["orientation"] = "RIGHT"
    E.db["unitframe"]["units"]["focus"]["aurabar"]["enable"] = false
    E.db["unitframe"]["units"]["focus"]["buffs"] = {
        ["enable"] = true,
        ["anchorPoint"] = "TOPRIGHT",
        ["yOffset"] = 10,
        ["priority"] = "Blacklist,Personal,nonPersonal",
        ["perrow"] = 8,
        ["maxDuration"] = 0
    }
    E.db["unitframe"]["units"]["focus"]["debuffs"] = {
        ["priority"] = "Blacklist,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable",
        ["perrow"] = 8,
        ["attachTo"] = "BUFFS"
    }
    E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 240
    E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["focus"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["focus"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["focus"]["raidRoleIcons"] = E.db["unitframe"]["units"]["focus"]["raidRoleIcons"] or {}
    E.db["unitframe"]["units"]["focus"]["raidRoleIcons"]["enable"] = true
    E.db["unitframe"]["units"]["focus"]["raidRoleIcons"]["position"] = "TOPRIGHT"
    E.db["unitframe"]["units"]["focus"]["raidRoleIcons"]["xOffset"] = 2
    E.db["unitframe"]["units"]["focus"]["raidRoleIcons"]["yOffset"] = -18
    E.db["unitframe"]["units"]["focus"]["resurrectIcon"] = {
        ["enable"] = true,
        ["attachTo"] = "CENTER",
        ["attachToObject"] = "Frame",
        ["xOffset"] = 0,
        ["yOffset"] = 0,
        ["size"] = 30
    }
    E.db["unitframe"]["units"]["focus"]["pvpIcon"] = {["enable"] = false}
    E.db["unitframe"]["units"]["focus"]["customTexts"] = {
        ["CustomName"] = {
            ["attachTextTo"] = "Frame",
            ["xOffset"] = -2,
            ["text_format"] = "[namecolor][name:long] [difficultycolor][level][shortclassification]",
            ["yOffset"] = 20,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "RIGHT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomPower"] = {
            ["attachTextTo"] = "Power",
            ["xOffset"] = 0,
            ["text_format"] = "[power:current]",
            ["yOffset"] = 5,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "CENTER",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 10
        },
        ["CustomHealth"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 5,
            ["text_format"] = "[health:current:shortvalue]",
            ["yOffset"] = 0,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 14
        },
        ["CustomHealthPercent"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 2,
            ["text_format"] = "[health:percent]",
            ["yOffset"] = 16,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        }
    }

    E.db["unitframe"]["units"]["party"]["height"] = 34
    E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 10
    E.db["unitframe"]["units"]["party"]["showPlayer"] = false
    E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 0
    E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 5
    E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["units"]["party"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["xOffset"] = 2
    E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["yOffset"] = -17
    E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["units"]["party"]["customTexts"] = {
        ["CustomName"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 2,
            ["text_format"] = "[difficultycolor][level] [namecolor][name:medium]",
            ["yOffset"] = 15,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        },
        ["CustomPower"] = {
            ["attachTextTo"] = "Power",
            ["xOffset"] = 0,
            ["text_format"] = "[power:current]",
            ["yOffset"] = 5,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "CENTER",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 10
        },
        ["CustomHealth"] = {
            ["attachTextTo"] = "Health",
            ["xOffset"] = 0,
            ["text_format"] = "[health:current-percent]",
            ["yOffset"] = 16,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "RIGHT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 10
        }
    }

    E.db["unitframe"]["units"]["arena"]["width"] = 184
    E.db["unitframe"]["units"]["arena"]["height"] = 34
    E.db["unitframe"]["units"]["arena"]["spacing"] = 30
    E.db["unitframe"]["units"]["arena"]["power"]["height"] = 7
    E.db["unitframe"]["units"]["arena"]["pvpTrinket"]["size"] = 34

    E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = DEFAULT_FONT
end

function Installer:SetupMovers()
    E.db["movers"] = E.db["movers"] or {}
    E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,30"
    E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,30"
    E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,245"
    E.db["movers"]["ElvAB_3"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-401"
    E.db["movers"]["ElvAB_4"] = "TOPRIGHT,ElvAB_3,TOPLEFT,-4,0"
    E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,0,4"
    E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvAB_5,TOP,0,2"
    E.db["movers"]["VehicleLeaveButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,73"
    E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,38"
    E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,73"
    E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,346"
    E.db["movers"]["MicrobarMover"] = "TOP,ElvUIParent,TOP,0,-4"
    E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-290,284"
    E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,218"
    E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,324"
    E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,290,284"
    E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,290,264"
    E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,235,233"
    E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-345,247"
    E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-345,227"
    E.db["movers"]["ElvUF_FocusMover"] = "TOP,ElvUIParent,TOP,0,-168"
    E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,460,363"
    E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,269"
    E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,269"
    E.db["movers"]["ElvUF_ArenaMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,460,363"
    E.db["movers"]["ArenaHeaderMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-400,363"
    E.db["movers"]["ExperienceBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,465,4"
    E.db["movers"]["ReputationBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,528,16"
    E.db["movers"]["ThreatBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,207"
    E.db["movers"]["DTPanelTop Panel (Center)Mover"] = "TOP,ElvUIParent,TOP,0,0"
    E.db["movers"]["DTPanelTop PanelMover"] = "TOP,ElvUIParent,TOP,0,-12"
end

function Installer:SetupPlugins()
    if E.db["ElvUI_FlyoutBars"] then
        E.db["ElvUI_FlyoutBars"]["bars"]["Mage Bar"]["backdrop"] = false
        E.db["ElvUI_FlyoutBars"]["bars"]["Mage Bar"]["backdropSpacing"] = 2
        E.db["ElvUI_FlyoutBars"]["bars"]["Mage Bar"]["buttonSpacing"] = 2
        E.db["movers"]["ElvUI_FlyoutBars_Mage BarMover"] = "BOTTOM,ElvUIParent,BOTTOM,450,4"

        E.db["ElvUI_FlyoutBars"]["bars"]["Shaman Bar"]["backdrop"] = false
        E.db["ElvUI_FlyoutBars"]["bars"]["Shaman Bar"]["backdropSpacing"] = 2
        E.db["ElvUI_FlyoutBars"]["bars"]["Shaman Bar"]["buttonSpacing"] = 2
        E.db["movers"]["ElvUI_FlyoutBars_Shaman BarMover"] = "BOTTOM,ElvUIParent,BOTTOM,450,4"
    end
end

function Installer:Show()
    E.private.install_complete = E.version
    if _G.ElvUIInstallFrame and _G.ElvUIInstallFrame:IsShown() then
        _G.ElvUIInstallFrame:Hide()
    end

    local installer = E:GetModule("PluginInstaller")
    installer:CloseInstall()

    _G.PluginInstallFrame:SetScript("OnHide", function()
        if Installer.reloadRequired then
            ReloadUI()
        else
            installer:CloseInstall()
        end
    end)

    installer:Queue(Installer.InstallerData)
    E:ToggleOptionsUI()
end

Installer.InstallerData = {
    Title = format("%s %s", Addon.title, "Profile Installation"),
    Name = Addon.name,
    Pages = {
        -- Welcome Page
        [1] = function()
            _G.PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s.", Addon.title)
            _G.PluginInstallFrame.Desc1:SetText("This installation process will guide you through a few steps and apply the " ..
                                                    Addon.title .. " profile.")
            _G.PluginInstallFrame.Desc2:SetText(
                "NOTE: This installation process is totally optional, the separate modules of the addon will work fine with existing profiles!")
            _G.PluginInstallFrame.Option1:Show()
            _G.PluginInstallFrame.Option1:SetText("Install")
            _G.PluginInstallFrame.Option1:SetScript("OnClick", function()
                _G.PluginInstallFrame.Next:Click()
            end)
            _G.PluginInstallFrame.Option2:Show()
            _G.PluginInstallFrame.Option2:SetText("Cancel")
            _G.PluginInstallFrame.Option2:SetScript("OnClick", function()
                _G.PluginInstallFrame:Hide()
            end)
        end,

        -- Profile
        [2] = function()
            _G.PluginInstallFrame.SubTitle:SetText("Profile")
            _G.PluginInstallFrame.Desc1:SetText("You can either create a new profile for " .. Addon.title ..
                                                    " or you can use your current profile (NOTE: using existing profiles might give unexpected results!).")
            _G.PluginInstallFrame.Desc2:SetText("Importance: " .. "High")
            _G.PluginInstallFrame.Desc3:SetText("Your currently active profile is: " .. E.data:GetCurrentProfile())
            _G.PluginInstallFrame.Option1:Show()
            _G.PluginInstallFrame.Option1:SetText("Create New")
            _G.PluginInstallFrame.Option1:SetScript("OnClick", function()
                Installer:CreateProfile()
            end)
        end,

        -- Layout Page
        [3] = function()
            _G.PluginInstallFrame.SubTitle:SetText("Core Settings")
            _G.PluginInstallFrame.Desc1:SetText("This will install the " .. Addon.title ..
                                                    " layout to the previously selected profile.")
            _G.PluginInstallFrame.Desc2:SetText("Importance: " .. "Medium")
            _G.PluginInstallFrame.Option1:Show()
            _G.PluginInstallFrame.Option1:SetText("Install")
            _G.PluginInstallFrame.Option1:SetScript("OnClick", function()
                Installer:Install()
                -- Installer:ShowStepComplete("Core profile")
                _G.PluginInstallFrame.Next:Click()
            end)
        end,

        -- Details Page
        [4] = function()
            _G.PluginInstallFrame.SubTitle:SetText("Details!")

            if E:IsAddOnEnabled("Details") then
                _G.PluginInstallFrame.Desc1:SetText("This will import the " .. Addon.title .. " Details profile.")
                _G.PluginInstallFrame.Desc2:SetText("Importance: " .. "Medium")
                _G.PluginInstallFrame.Desc3:SetText("Details is an AddOn that displays information like damage & healing meters.")
                _G.PluginInstallFrame.Option1:Show()
                _G.PluginInstallFrame.Option1:SetText("Setup Details")
                _G.PluginInstallFrame.Option1:SetScript("OnClick", function()
                    Installer:SetupDetails()
                    -- Installer:ShowStepComplete("'Details' profile")
                    _G.PluginInstallFrame.Next:Click()
                end)
            else
                _G.PluginInstallFrame.Desc1:SetText("Details! is not installed, press the 'Next' button to continue.")
            end
        end,

        -- Completed Page
        [5] = function()
            _G.PluginInstallFrame.SubTitle:SetText("Installation Complete")
            _G.PluginInstallFrame.Desc1:SetText("You have completed the installation process.")
            _G.PluginInstallFrame.Desc2:SetText(
                "Please click the button below in order to finalize the process and automatically reload your UI.")
            _G.PluginInstallFrame.Option1:Show()
            _G.PluginInstallFrame.Option1:SetText("Finish")
            _G.PluginInstallFrame.Option1:SetScript("OnClick", function()
                _G.PluginInstallFrame:Hide()
            end)
        end
    },
    StepTitles = {[1] = "Welcome", [2] = "Profile", [3] = "Layout", [4] = "Details!", [5] = "Installation Complete"},
    StepTitlesColor = {1, 1, 1},
    StepTitlesColorSelected = {0.921, 0.321, 0.321},
    StepTitleWidth = 200,
    StepTitleButtonWidth = 180,
    StepTitleTextJustification = "RIGHT"
}
