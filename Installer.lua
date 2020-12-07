local addonName, addonTable = ...
local Module = addonTable[1]
local Installer = Module:NewModule(addonName .. "Installer", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.Installer = Installer
local E, L, V, P, G = unpack(ElvUI)

local DEFAULT_FONT = "Expressway"
local DEFAULT_STATUSBAR = "Redux"

function Installer:Setup()
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
end

function Installer:NewProfile()
    StaticPopupDialogs["CreateProfileNameNew"] = {
        text = L["Name for the new profile"],
        button1 = L["Accept"],
        button2 = L["Cancel"],
        hasEditBox = 1,
        whileDead = 1,
        hideOnEscape = 1,
        timeout = 0,
        OnShow = function(self, data)
            self.editBox:SetText(Module.name)
        end,
        OnAccept = function(self, data, data2)
            local text = self.editBox:GetText()
            ElvUI[1].data:SetProfile(text)
            Installer:Setup()
        end
    }
    StaticPopup_Show("CreateProfileNameNew", "test")
end

function Installer:SetupGeneral()
    E.db["v11NamePlateReset"] = true
    E.db["general"]["font"] = DEFAULT_FONT
    E.db["general"]["interruptAnnounce"] = "SAY"
    E.db["general"]["valuecolor"] = {["r"] = 0.25, ["g"] = 0.78, ["b"] = 0.92}
    E.db["general"]["bordercolor"] = {["r"] = 0, ["g"] = 0, ["b"] = 0}
    E.db["general"]["minimap"]["locationText"] = "SHOW"
    E.db["general"]["minimap"]["locationFont"] = DEFAULT_FONT
    E.db["general"]["minimap"]["locationFontSize"] = 14
    E.db["general"]["minimap"]["icons"]["tracking"]["scale"] = 0.75

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
    E.db["actionbar"]["bar1"]["buttons"] = 8
    E.db["actionbar"]["bar1"]["buttonsPerRow"] = 10
    E.db["actionbar"]["bar1"]["buttonsize"] = 38
    E.db["actionbar"]["bar1"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar2"]["enabled"] = true
    E.db["actionbar"]["bar3"]["buttons"] = 8
    E.db["actionbar"]["bar3"]["buttonsPerRow"] = 10
    E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar4"]["buttons"] = 8
    E.db["actionbar"]["bar4"]["buttonsPerRow"] = 10
    E.db["actionbar"]["bar4"]["point"] = "TOPLEFT"
    E.db["actionbar"]["bar4"]["backdrop"] = false
    E.db["actionbar"]["bar5"]["buttons"] = 12
    E.db["actionbar"]["bar5"]["buttonsPerRow"] = 1
    E.db["actionbar"]["bar5"]["mouseover"] = true
    E.db["actionbar"]["bar5"]["point"] = "TOPRIGHT"
    E.db["actionbar"]["barPet"]["buttonsPerRow"] = 10
    E.db["actionbar"]["barPet"]["point"] = "TOPLEFT"
    E.db["actionbar"]["barPet"]["backdrop"] = false
end

function Installer:SetupAuras()
    E.db["auras"]["font"] = DEFAULT_FONT
    E.db["auras"]["fontOutline"] = "OUTLINE"
    E.db["auras"]["debuffs"]["countFontSize"] = 12
    E.db["auras"]["debuffs"]["durationFontSize"] = 12
    E.db["auras"]["buffs"]["countFontSize"] = 12
    E.db["auras"]["buffs"]["durationFontSize"] = 12
end

function Installer:SetupBags()
    E.db["bags"]["bagWidth"] = 412
    E.db["bags"]["bankWidth"] = 412
    E.db["bags"]["itemLevelFont"] = DEFAULT_FONT
    E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
    E.db["bags"]["itemLevelFontSize"] = 12
    E.db["bags"]["countFont"] = DEFAULT_FONT
    E.db["bags"]["countFontOutline"] = "OUTLINE"
    E.db["bags"]["countFontSize"] = 12
    E.db["bags"]["junkIcon"] = true
end

function Installer:SetupChat()
    E.db["chat"]["font"] = DEFAULT_FONT
    E.db["chat"]["fontOutline"] = "OUTLINE"
    E.db["chat"]["fontSize"] = 12
    E.db["chat"]["tabFont"] = DEFAULT_FONT
    E.db["chat"]["tabFontOutline"] = "OUTLINE"
    E.db["chat"]["timeStampFormat"] = "%H:%M:%S "
    E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
end

function Installer:SetupDatabars()
    E.db["databars"]["experience"]["enable"] = true
    E.db["databars"]["reputation"]["enable"] = true
    E.db["databars"]["threat"]["enable"] = false
end

function Installer:SetupDatatexts()
    E.db["datatexts"]["font"] = DEFAULT_FONT
    E.db["datatexts"]["fontOutline"] = "OUTLINE"
end

function Installer:SetupNameplates()
    E.db["nameplates"]["font"] = DEFAULT_FONT
    E.db["nameplates"]["statusbar"] = DEFAULT_STATUSBAR
end

function Installer:SetupTooltip()
    E.db["tooltip"]["cursorAnchor"] = true
    E.db["tooltip"]["cursorAnchorType"] = "ANCHOR_CURSOR_RIGHT"
    E.db["tooltip"]["cursorAnchorX"] = 20
    E.db["tooltip"]["cursorAnchorY"] = 10
    E.db["tooltip"]["font"] = DEFAULT_FONT
    E.db["tooltip"]["fontSize"] = 12
    E.db["tooltip"]["healthBar"]["font"] = DEFAULT_FONT
    E.db["tooltip"]["modifierID"] = "HIDE"
    E.db["tooltip"]["itemCount"] = "NONE"
end

function Installer:SetupUnitFrames()
    E.db["unitframe"]["targetSound"] = true
    E.db["unitframe"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["fontOutline"] = "OUTLINE"
    E.db["unitframe"]["statusbar"] = DEFAULT_STATUSBAR
    E.db["unitframe"]["smoothbars"] = true
    E.db["unitframe"]["colors"]["healthclass"] = true
    E.db["unitframe"]["colors"]["castClassColor"] = true
    E.db["unitframe"]["colors"]["auraBarBuff"] = {["r"] = 0.25, ["g"] = 0.78, ["b"] = 0.92}

    E.db["unitframe"]["units"]["player"]["width"] = 240
    E.db["unitframe"]["units"]["player"]["height"] = 38
    E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
    E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = 10
    E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 265
    E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 25
    E.db["unitframe"]["units"]["player"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["power"]["height"] = 20
    E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
    E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 318
    E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["player"]["power"]["powerPrediction"] = true
    E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
    E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
    E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 318
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
            ["xOffset"] = 0,
            ["text_format"] = "[health:current-percent]",
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
            ["text_format"] = "[namecolor][name:medium] [difficultycolor][level][shortclassification]",
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
            ["xOffset"] = 2,
            ["text_format"] = "[health:current-percent]",
            ["yOffset"] = 16,
            ["font"] = DEFAULT_FONT,
            ["justifyH"] = "LEFT",
            ["fontOutline"] = "OUTLINE",
            ["enable"] = true,
            ["size"] = 12
        }
    }

    E.db["unitframe"]["units"]["targettarget"]["height"] = 30
    E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] = false
    E.db["unitframe"]["units"]["targettarget"]["name"]["text_format"] = ""
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

    E.db["unitframe"]["units"]["party"]["height"] = 34
    E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 10
    E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 0
    E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 5
    E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["units"]["party"]["name"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
    E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["xOffset"] = 2
    E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["yOffset"] = -17
    E.db["unitframe"]["units"]["party"]["showPlayer"] = false
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

    E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = DEFAULT_FONT
    E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = DEFAULT_FONT
end

function Installer:SetupMovers()
    E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,30"
    E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,31"
    E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,38"
    E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,284"
    E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,218"
    E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,251"
    E.db["movers"]["ElvAB_5"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-401"
    E.db["movers"]["VehicleLeaveButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,73"
    E.db["movers"]["ShiftAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,1018,39"
    E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-290,284"
    E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,191"
    E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,324"
    E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,346"
    E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,290,284"
    E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,290,264"
    E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,235,241"
    E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-345,247"
    E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-345,227"
    E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,460,363"
    E.db["movers"]["ExperienceBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,465,4"
    E.db["movers"]["ReputationBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,528,16"
    E.db["movers"]["MageBar"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-560,4"
    E.db["movers"]["ShamanBar"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-580,4"
end

function Installer:SetupPlugins()
    if E.db["ElvUI_ClassicClassBars"] then
        E.db["ElvUI_ClassicClassBars"]["mageBar"]["backdrop"] = false
        E.db["ElvUI_ClassicClassBars"]["mageBar"]["backdropSpacing"] = 2
        E.db["ElvUI_ClassicClassBars"]["mageBar"]["buttonSpacing"] = 2
        E.db["ElvUI_ClassicClassBars"]["shamanBar"]["backdrop"] = false
        E.db["ElvUI_ClassicClassBars"]["shamanBar"]["backdropSpacing"] = 2
        E.db["ElvUI_ClassicClassBars"]["shamanBar"]["buttonSpacing"] = 2
    end
end

Installer.InstallerData = {
    Title = format("%s %s", Module.title, "Installation"),
    Name = Module.name,
    -- tutorialImage = "Interface\\AddOns\\" .. addonName .. "\\Media\\logo.tga",
    Pages = {
        [1] = function()
            PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s.", Module.title)
            PluginInstallFrame.Desc1:SetText("Please press the 'Create Profile' button if you wish to create a new profile, otherwise click the 'Cancel' button.")
            
            PluginInstallFrame.Option1:Show()
            PluginInstallFrame.Option1:SetScript("OnClick", function()
                Installer:NewProfile()
            end)
            PluginInstallFrame.Option1:SetText("Create Profile")

            PluginInstallFrame.Option2:Show()
            PluginInstallFrame.Option2:SetScript("OnClick", function()
            end)
            PluginInstallFrame.Option2:SetText("Cancel")
        end,
    },
    StepTitles = {
        [1] = "Profile Setup",
    },
    StepTitlesColor = {1, 1, 1},
    StepTitlesColorSelected = {0.921, 0.321, 0.321},
    StepTitleWidth = 200,
    StepTitleButtonWidth = 180,
    StepTitleTextJustification = "RIGHT"
}

function Installer:InstallNewProfile()
    E:GetModule("PluginInstaller"):Queue(Installer.InstallerData)
end
