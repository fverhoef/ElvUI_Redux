local addonName, addonTable = ...
local Addon = addonTable[1]
local LSM = LibStub("LibSharedMedia-3.0")

Addon.media = {
    fonts = {adventure = "Interface\\AddOns\\" .. addonName .. "\\Media\\Fonts\\Adventure.ttf"},
    textures = {
        statusBars = {
            kait1 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Kait1",
            kait2 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Kait2",
            melli = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Melli",
            melliDark = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\MelliDark",
            onePixel = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\OnePixel",
            redux = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Redux"
        },
        frames = {
            alliance = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameAlliance",
            allianceVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameAllianceVertical",
            horde = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameHorde",
            hordeVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameHordeVertical",
            kyrian = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameKyrian",
            kyrianVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameKyrianVertical",
            marine = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameMarine",
            marineVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameMarineVertical",
            metal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameGenericMetal",
            metalVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameGenericMetalVertical",
            mechagon = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameMechagon",
            mechagonVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameMechagonVertical",
            neutral = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNeutral",
            neutralVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNeutralVertical",
            necrolord = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNecrolord",
            necrolordVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNecrolordVertical",
            nightFae = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNightFae",
            nightFaeVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameNightFaeVertical",
            oribos = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameOribos",
            oribosVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameOribosVertical",
            venthyr = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameVenthyr",
            venthyrVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Frame\\UIFrameVenthyrVertical",
        },
        buttons = {
            redButton = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\128RedButton",
            goldRedButton = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\128GoldRedButton",
            silverButton_Left_Down = "Interface\\Buttons\\UI-SilverButtonLG-Left-Down",
            silverButton_Left_Hi = "Interface\\Buttons\\UI-SilverButtonLG-Left-Hi",
            silverButton_Left_Up = "Interface\\Buttons\\UI-SilverButtonLG-Left-Up",
            silverButton_Mid_Down = "Interface\\Buttons\\UI-SilverButtonLG-Mid-Down",
            silverButton_Mid_Hi = "Interface\\Buttons\\UI-SilverButtonLG-Mid-Hi",
            silverButton_Mid_Up = "Interface\\Buttons\\UI-SilverButtonLG-Mid-Up",
            silverButton_Right_Down = "Interface\\Buttons\\UI-SilverButtonLG-Right-Down",
            silverButton_Right_Hi = "Interface\\Buttons\\UI-SilverButtonLG-Right-Hi",
            silverButton_Right_Up = "Interface\\Buttons\\UI-SilverButtonLG-Right-Up",
        },

        arrowUp_ElvUI = "Interface\\Addons\\ElvUI\\Media\\Textures\\ArrowUp",
        minimapButtonBorder1 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\MinimapButtonBorder1",
        minimapButtonBorder2 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\MinimapButtonBorder2",
        portraitAlphaMask = "Interface\\CharacterFrame\\TempPortraitAlphaMask"
    }
}

LSM:Register("font", "Adventure", Addon.media.fonts.adventure)
LSM:Register("statusbar", "Kait1", Addon.media.textures.statusBars.kait1)
LSM:Register("statusbar", "Kait2", Addon.media.textures.statusBars.kait2)
LSM:Register("statusbar", "Melli", Addon.media.textures.statusBars.melli)
LSM:Register("statusbar", "MelliDark", Addon.media.textures.statusBars.melliDark)
LSM:Register("statusbar", "One Pixel", Addon.media.textures.statusBars.onePixel)
LSM:Register("statusbar", "Redux", Addon.media.textures.statusBars.redux)
