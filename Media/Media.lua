local addonName, addonTable = ...
local Addon = addonTable[1]
local LSM = LibStub("LibSharedMedia-3.0")

Addon.media = {
    fonts = {
        adventure = "Interface\\AddOns\\" .. addonName .. "\\Media\\Fonts\\Adventure.ttf"
    },
    textures = {
        statusBars = {
            kait1 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Kait1",
            kait2 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Kait2",
            melli = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Melli",
            melliDark = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\MelliDark",
            onePixel = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\OnePixel",
            redux = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Redux"
        },
        borders = {
            allianceTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Alliance_TopLeft",
            allianceTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Alliance_Top",
            allianceLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Alliance_Left",
            hordeTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Horde_TopLeft",
            hordeTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Horde_Top",
            hordeLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Horde_Left",
            kyrianTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Kyrian_TopLeft",
            kyrianTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Kyrian_Top",
            kyrianLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Kyrian_Left",
            marineTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Marine_TopLeft",
            marineTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Marine_Top",
            marineLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Marine_Left",
            mechagonTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Mechagon_TopLeft",
            mechagonTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Mechagon_Top",
            mechagonLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Mechagon_Left",
            necrolordTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Necrolord_TopLeft",
            necrolordTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Necrolord_Top",
            necrolordLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Necrolord_Left",
            neutralTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Neutral_TopLeft",
            neutralTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Neutral_Top",
            neutralLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Neutral_Left",
            nightFaeTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_NightFae_TopLeft",
            nightFaeTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_NightFae_Top",
            nightFaeLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_NightFae_Left",
            venthyrTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Venthyr_TopLeft",
            venthyrTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Venthyr_Top",
            venthyrLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Venthyr_Left",
            retinaTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Retina_TopLeft",
            retinaTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Retina_Top",
            retinaLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Retina_Left",
            beautyCaseTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_BeautyCase_TopLeft",
            beautyCaseTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_BeautyCase_Top",
            beautyCaseBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_BeautyCase_BottomLeft",
            beautyCaseBottom = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_BeautyCase_Bottom",
            beautyCaseLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_BeautyCase_Left",
            goldpawTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Goldpaw_TopLeft",
            goldpawTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Goldpaw_Top",
            goldpawBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Goldpaw_BottomLeft",
            goldpawBottom = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Goldpaw_Bottom",
            goldpawLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Goldpaw_Left",
            onyxTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Onyx_TopLeft",
            onyxTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Onyx_Top",
            onyxBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Onyx_BottomLeft",
            onyxBottom = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Onyx_Bottom",
            onyxLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Onyx_Left",
            renaitreSquareThinTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_RenaitreSquareThin_TopLeft",
            renaitreSquareThinTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_RenaitreSquareThin_Top",
            renaitreSquareThinBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_RenaitreSquareThin_BottomLeft",
            renaitreSquareThinBottom = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_RenaitreSquareThin_Bottom",
            renaitreSquareThinLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_RenaitreSquareThin_Left",
            cleanTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_TopLeft",
            cleanTop = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_Top",
            cleanTopRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_TopRight",
            cleanRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_Right",
            cleanBottomRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_BottomRight",
            cleanBottom = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_Bottom",
            cleanBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_BottomLeft",
            cleanLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\Border_Clean_Left"
        },
        backgrounds = {
            alliance = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameAllianceBackground",
            horde = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameHordeBackground",
            kyrian = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameKyrianBackground",
            marine = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameMarineBackground",
            mechagon = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameMechagonBackground",
            neutral = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameNeutralBackground",
            necrolord = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameNecrolordBackground",
            nightFae = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameNightFaeBackground",
            oribos = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameOribosBackground",
            venthyr = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Backgrounds\\UIFrameVenthyrBackground"
        },
        closeButtons = {
            alliance = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Alliance_CloseButton",
            horde = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Horde_CloseButton",
            metal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Metal_CloseButton",
            kyrian = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Kyrian_CloseButton",
            marine = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_CloseButton",
            mechagon = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Mechagon_CloseButton",
            necrolord = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Necrolord_CloseButton",
            neutral = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Neutral_CloseButton",
            nightFae = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_NightFae_CloseButton",
            oribos = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_CloseButton",
            venthyr = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_CloseButton"
        },
        frameBorders = {
            allianceTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Alliance_TopLeft",
            allianceHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Alliance_Horizontal",
            allianceVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Alliance_Vertical",
            hordeTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Horde_TopLeft",
            hordeHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Horde_Horizontal",
            hordeVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Horde_Vertical",
            metalTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Metal_TopLeft",
            metalHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Metal_Horizontal",
            metalVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Metal_Vertical",
            kyrianTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Kyrian_TopLeft",
            kyrianBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Kyrian_BottomLeft",
            kyrianHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Kyrian_Horizontal",
            kyrianVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Kyrian_Vertical",
            marineTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_TopLeft",
            marineTopRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_TopRight",
            marineBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_BottomLeft",
            marineBottomRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_BottomRight",
            marineHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_Horizontal",
            marineVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Marine_Vertical",
            mechagonTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Mechagon_TopLeft",
            mechagonHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Mechagon_Horizontal",
            mechagonVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Mechagon_Vertical",
            necrolordTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Necrolord_TopLeft",
            necrolordBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Necrolord_BottomLeft",
            necrolordHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Necrolord_Horizontal",
            necrolordVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Necrolord_Vertical",
            neutralTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Neutral_TopLeft",
            neutralHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Neutral_Horizontal",
            neutralVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Neutral_Vertical",
            nightFaeTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_NightFae_TopLeft",
            nightFaeBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_NightFae_BottomLeft",
            nightFaeHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_NightFae_Horizontal",
            nightFaeVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_NightFae_Vertical",
            oribosTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_TopLeft",
            oribosTopRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_TopRight",
            oribosBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_BottomLeft",
            oribosBottomRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_BottomRight",
            oribosHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_Horizontal",
            oribosVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Oribos_Vertical",
            venthyrTopLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_TopLeft",
            venthyrTopRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_TopRight",
            venthyrBottomLeft = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_BottomLeft",
            venthyrBottomRight = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_BottomRight",
            venthyrHorizontal = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_Horizontal",
            venthyrVertical = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Borders\\FrameBorder_Venthyr_Vertical"
        },
        buttons = {
            redButton = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\128RedButton",
            goldRedButton = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\128GoldRedButton",
            soulBinds_ScrollBar_Down = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\Soulbinds_ScrollBar_Down",
            soulBinds_ScrollBar_Thumb = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\Soulbinds_ScrollBar_Thumb",
            soulBinds_ScrollBar_Track = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\Soulbinds_ScrollBar_Track",
            soulBinds_ScrollBar_Background = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\Buttons\\Soulbinds_ScrollBar_Background"
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
