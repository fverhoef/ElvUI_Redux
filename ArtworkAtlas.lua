local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

Artwork.atlas = {
    buttons = {
        ["Red"] = {
            offset = {-3, 3},
            leftWidth = 73,
            rightWidth = 28,

            left = {Addon.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.254395, 0.316895},
            right = {Addon.media.textures.buttons.redButton, 0.25390625, 0.474609375, 0.444824, 0.507324},
            center = {Addon.media.textures.buttons.redButton, 0, 0.125, 0.000488281, 0.0629883},

            leftDisabled = {Addon.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.317871, 0.380371},
            rightDisabled = {Addon.media.textures.buttons.redButton, 0.48140900, 0.701171875, 0.444824, 0.507324},
            centerDisabled = {Addon.media.textures.buttons.redButton, 0, 0.125, 0.0639648, 0.126465},

            leftPressed = {Addon.media.textures.buttons.redButton, 0.00195312, 0.572266, 0.381348, 0.443848},
            rightPressed = {Addon.media.textures.buttons.redButton, 0.255859, 0.478516, 0.444824, 0.507324},
            centerPressed = {Addon.media.textures.buttons.redButton, 0, 0.125, 0.127441, 0.189941}
        },
        ["Silver"] = {
            offset = {-1, 1},
            leftWidth = 10,
            rightWidth = 10,

            left = {Addon.media.textures.buttons.silverButton_Left_Up, 0, 12 / 32, 0, 0.734375},
            right = {Addon.media.textures.buttons.silverButton_Right_Up, 20 / 32, 1, 0, 0.734375},
            center = {Addon.media.textures.buttons.silverButton_Mid_Up, 0, 1, 0, 0.734375},

            leftPressed = {Addon.media.textures.buttons.silverButton_Left_Down, 0, 12 / 32, 0, 0.734375},
            rightPressed = {Addon.media.textures.buttons.silverButton_Right_Down, 20 / 32, 1, 0, 0.734375},
            centerPressed = {Addon.media.textures.buttons.silverButton_Mid_Down, 0, 1, 0, 0.734375},

            leftHighlight = {Addon.media.textures.buttons.silverButton_Left_Hi, 0, 12 / 32, 0, 0.734375},
            rightHighlight = {Addon.media.textures.buttons.silverButton_Right_Hi, 20 / 32, 1, 0, 0.734375},
            centerHighlight = {Addon.media.textures.buttons.silverButton_Mid_Hi, 0, 1, 0, 0.734375}
        }
    },
    backgrounds = {
        ["Alliance"] = Addon.media.textures.backgrounds.alliance,
        ["Horde"] = Addon.media.textures.backgrounds.horde,
        ["Marine"] = Addon.media.textures.backgrounds.marine,
        ["Mechagon"] = Addon.media.textures.backgrounds.mechagon,
        ["Neutral"] = Addon.media.textures.backgrounds.neutral,
        ["Kyrian"] = Addon.media.textures.backgrounds.kyrian,
        ["Necrolord"] = Addon.media.textures.backgrounds.necrolord,
        ["NightFae"] = Addon.media.textures.backgrounds.nightFae,
        ["Oribos"] = Addon.media.textures.backgrounds.oribos,
        ["Venthyr"] = Addon.media.textures.backgrounds.venthyr
    },
    borders = {
        ["Alliance"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.allianceTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.allianceTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.allianceTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.allianceTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.allianceTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.allianceTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.allianceLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.allianceLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Horde"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.hordeTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.hordeTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.hordeTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.hordeTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.hordeTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.hordeTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.hordeLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.hordeLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Kyrian"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.kyrianTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.kyrianTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.kyrianTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.kyrianTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.kyrianTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.kyrianTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.kyrianLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.kyrianLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Marine"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.marineTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.marineTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.marineTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.marineTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.marineTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.marineTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.marineLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.marineLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Mechagon"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.mechagonTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.mechagonTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.mechagonTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.mechagonTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.mechagonTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.mechagonTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.mechagonLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.mechagonLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Necrolord"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.necrolordTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.necrolordTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.necrolordTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.necrolordTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.necrolordTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.necrolordTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.necrolordLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.necrolordLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Neutral"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.neutralTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.neutralTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.neutralTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.neutralTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.neutralTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.neutralTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.neutralLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.neutralLeft, 16, 256, 1, 0, 0, 1}
        },
        ["NightFae"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.nightFaeTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.nightFaeTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.nightFaeTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.nightFaeTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.nightFaeTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.nightFaeTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.nightFaeLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.nightFaeLeft, 16, 256, 1, 0, 0, 1}
        },
        ["Venthyr"] = {
            scale = 0.5,
            offset = {-8, 8},
            topLeft = {Addon.media.textures.borders.venthyrTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.venthyrTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.venthyrTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.venthyrTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.venthyrTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.venthyrTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.venthyrLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.venthyrLeft, 16, 256, 1, 0, 0, 1}
        },
    },
    frameBorders = {
        ["Alliance"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 0 / 256, 166 / 256, 166 / 256, 0 / 256},
            bottomRight = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 166 / 256, 0 / 256, 166 / 256, 0 / 256},
            top = {Addon.media.textures.frameBorders.allianceHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.allianceHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.allianceVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.allianceVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.alliance, 32, 32, 0, 1, 0, 1}
        },
        ["Horde"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 0 / 256, 166 / 256, 166 / 256, 0 / 256},
            bottomRight = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 166 / 256, 0 / 256, 166 / 256, 0 / 256},
            top = {Addon.media.textures.frameBorders.hordeHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.hordeHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.hordeVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.hordeVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.horde, 32, 32, 0, 1, 0, 1}
        },
        ["Metal"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 0 / 256, 166 / 256, 166 / 256, 0 / 256},
            bottomRight = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 166 / 256, 0 / 256, 166 / 256, 0 / 256},
            top = {Addon.media.textures.frameBorders.metalHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.metalHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.metalVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.metalVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.metal, 32, 32, 0, 1, 0, 1}
        },
        ["Kyrian"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.kyrianTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.kyrianTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.kyrianBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.kyrianBottomLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            top = {Addon.media.textures.frameBorders.kyrianHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.kyrianHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.kyrianVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.kyrianVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.kyrian, 32, 32, 0, 1, 0, 1}
        },
        ["Marine"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.marineTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.marineTopRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.marineBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.marineBottomRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            top = {Addon.media.textures.frameBorders.marineHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.marineHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.marineVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.marineVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.marine, 32, 32, 0, 1, 0, 1}
        },
        ["Mechagon"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 0 / 256, 166 / 256, 166 / 255, 0 / 256},
            bottomRight = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 166 / 256, 0 / 256, 166 / 256, 0 / 256},
            top = {Addon.media.textures.frameBorders.mechagonHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.mechagonHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.mechagonVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.mechagonVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.mechagon, 32, 32, 0, 1, 0, 1}
        },
        ["Necrolord"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.necrolordTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.necrolordTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.necrolordBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.necrolordBottomLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            top = {Addon.media.textures.frameBorders.necrolordHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.necrolordHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.necrolordVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.necrolordVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.necrolord, 32, 32, 0, 1, 0, 1}
        },
        ["Neutral"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 0 / 256, 166 / 256, 166 / 255, 0 / 256},
            bottomRight = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 166 / 256, 0 / 256, 166 / 256, 0 / 256},
            top = {Addon.media.textures.frameBorders.neutralHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.neutralHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.neutralVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.neutralVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.neutral, 32, 32, 0, 1, 0, 1}
        },
        ["NightFae"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.nightFaeTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.nightFaeTopLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.nightFaeBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.nightFaeBottomLeft, 166, 166, 166 / 256, 0 / 256, 0 / 256, 166 / 256},
            top = {Addon.media.textures.frameBorders.nightFaeHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.nightFaeHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.nightFaeVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.nightFaeVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.nightFae, 32, 32, 0, 1, 0, 1}
        },
        ["Oribos"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.oribosTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.oribosTopRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.oribosBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.oribosBottomRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            top = {Addon.media.textures.frameBorders.oribosHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.oribosHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.oribosVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.oribosVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.oribos, 32, 32, 0, 1, 0, 1}
        },
        ["Venthyr"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frameBorders.venthyrTopLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            topRight = {Addon.media.textures.frameBorders.venthyrTopRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomLeft = {Addon.media.textures.frameBorders.venthyrBottomLeft, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            bottomRight = {Addon.media.textures.frameBorders.venthyrBottomRight, 166, 166, 0 / 256, 166 / 256, 0 / 255, 166 / 256},
            top = {Addon.media.textures.frameBorders.venthyrHorizontal, 256, 32, 0, 1, 0 / 64, 32 / 64},
            bottom = {Addon.media.textures.frameBorders.venthyrHorizontal, 256, 32, 0, 1, 32 / 64, 64 / 64},
            left = {Addon.media.textures.frameBorders.venthyrVertical, 32, 256, 0 / 64, 32 / 64, 0, 1},
            right = {Addon.media.textures.frameBorders.venthyrVertical, 32, 256, 32 / 64, 64 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.closeButtons.venthyr, 32, 32, 0, 1, 0, 1}
        },
    }
}

function Artwork:GetNormalBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.border]
end

function Artwork:GetFrameBorderAtlas()
    return Artwork.atlas.frameBorders[E.db[addonName].artwork.frameBorder]
end

function Artwork:GetCloseButtonBackgroundAtlas()
    local frameBorderAtlas = Artwork:GetFrameBorderAtlas()
    return frameBorderAtlas and frameBorderAtlas.closeButtonBackground
end

function Artwork:GetFrameBackground()
    return Artwork.atlas.backgrounds[E.db[addonName].artwork.frameBackground]
end
