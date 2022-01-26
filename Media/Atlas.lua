local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)

Addon.atlas = {
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
        ["BeautyCase"] = {
            topLeft = {Addon.media.textures.borders.beautycase, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.beautycase, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.beautycase, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.beautycase, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.beautycase, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.beautycase, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.beautycase, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.beautycase, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Cainyx"] = {
            topLeft = {Addon.media.textures.borders.cainyx, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.cainyx, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.cainyx, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.cainyx, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.cainyx, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.cainyx, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.cainyx, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.cainyx, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Caith"] = {
            topLeft = {Addon.media.textures.borders.caith, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.caith, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.caith, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.caith, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.caith, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.caith, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.caith, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.caith, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Diablo"] = {
            topLeft = {Addon.media.textures.borders.diablo, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.diablo, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.diablo, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.diablo, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.diablo, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.diablo, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.diablo, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.diablo, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Entropy"] = {
            topLeft = {Addon.media.textures.borders.entropy, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.entropy, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.entropy, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.entropy, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.entropy, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.entropy, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.entropy, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.entropy, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Goldpaw"] = {
            topLeft = {Addon.media.textures.borders.goldpaw, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.goldpaw, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.goldpaw, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.goldpaw, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.goldpaw, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.goldpaw, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.goldpaw, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.goldpaw, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Onyx"] = {
            topLeft = {Addon.media.textures.borders.onyx, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.onyx, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.onyx, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.onyx, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.onyx, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.onyx, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.onyx, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.onyx, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Redux"] = {
            topLeft = {Addon.media.textures.borders.redux, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.redux, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.redux, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.redux, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.redux, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.redux, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.redux, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.redux, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Retina"] = {
            topLeft = {Addon.media.textures.borders.retina, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.retina, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.retina, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.retina, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.retina, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.retina, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.retina, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.retina, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
    },
    inlay = {
        ["Diamond"] = {
            topLeft = {Addon.media.textures.inlays.diamond, 8, 8, 0, 16 / 128, 0, 16 / 128},
            topRight = {Addon.media.textures.inlays.diamond, 8, 8, 112 / 128, 1, 0, 16 / 128},
            bottomLeft = {Addon.media.textures.inlays.diamond, 8, 8, 0, 16 / 128, 112 / 128, 1},
            bottomRight = {Addon.media.textures.inlays.diamond, 8, 8, 112 / 128, 1, 112 / 128, 1},
            top = {Addon.media.textures.inlays.diamond, 32, 8, 16 / 128, 112 / 128, 0, 16 / 128},
            bottom = {Addon.media.textures.inlays.diamond, 32, 8, 16 / 128, 112 / 128, 112 / 128, 1},
            left = {Addon.media.textures.inlays.diamond, 8, 32, 0, 16 / 128, 16 / 128, 112 / 128},
            right = {Addon.media.textures.inlays.diamond, 8, 32, 112 / 128, 1, 16 / 128, 112 / 128},
            center = {Addon.media.textures.inlays.diamond, 32, 32, 16 / 128, 112 / 128, 16 / 128, 112 / 128}
        }
    },
    frames = {
        ["Alliance"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.allianceTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.allianceTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.allianceTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frames.allianceTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frames.allianceHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.allianceHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.allianceVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.allianceVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.alliance, 32, 32, 0, 1, 0, 1}
        },
        ["Horde"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.hordeTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.hordeTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.hordeTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frames.hordeTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frames.hordeHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.hordeHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.hordeVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.hordeVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.horde, 32, 32, 0, 1, 0, 1}
        },
        ["Metal"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.metalTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.metalTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.metalTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frames.metalTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frames.metalHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.metalHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.metalVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.metalVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.metal, 32, 32, 0, 1, 0, 1}
        },
        ["Kyrian"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.kyrianTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.kyrianTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.kyrianBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.kyrianBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frames.kyrianHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.kyrianHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.kyrianVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.kyrianVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.kyrian, 32, 32, 0, 1, 0, 1}
        },
        ["Marine"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.marineTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.marineTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.marineBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.marineBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frames.marineHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.marineHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.marineVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.marineVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.marine, 32, 32, 0, 1, 0, 1}
        },
        ["Mechagon"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.mechagonTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.mechagonTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.mechagonTopLeft, 166, 166, 0, 166 / 256, 166 / 255, 0},
                bottomRight = {Addon.media.textures.frames.mechagonTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frames.mechagonHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.mechagonHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.mechagonVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.mechagonVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.mechagon, 32, 32, 0, 1, 0, 1}
        },
        ["Necrolord"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.necrolordTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.necrolordTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.necrolordBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.necrolordBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frames.necrolordHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.necrolordHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.necrolordVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.necrolordVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.necrolord, 32, 32, 0, 1, 0, 1}
        },
        ["Neutral"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.neutralTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.neutralTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.neutralTopLeft, 166, 166, 0, 166 / 256, 166 / 255, 0},
                bottomRight = {Addon.media.textures.frames.neutralTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frames.neutralHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.neutralHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.neutralVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.neutralVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.neutral, 32, 32, 0, 1, 0, 1}
        },
        ["NightFae"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.nightFaeTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.nightFaeTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.nightFaeBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.nightFaeBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frames.nightFaeHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.nightFaeHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.nightFaeVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.nightFaeVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.nightFae, 32, 32, 0, 1, 0, 1}
        },
        ["Oribos"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.oribosTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.oribosTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.oribosBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.oribosBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frames.oribosHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.oribosHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.oribosVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.oribosVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.oribos, 32, 32, 0, 1, 0, 1}
        },
        ["Venthyr"] = {
            border = {
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frames.venthyrTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frames.venthyrTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frames.venthyrBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frames.venthyrBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frames.venthyrHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frames.venthyrHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frames.venthyrVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frames.venthyrVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.venthyr, 32, 32, 0, 1, 0, 1}
        }
    }
}

function Addon:GetBorderAtlas(styleConfigKey)
    return Addon.atlas.borders[Addon:GetBorderStyle(styleConfigKey)]
end

function Addon:GetInlayAtlas(styleConfigKey)
    return Addon.atlas.inlay[Addon:GetInlayStyle(styleConfigKey)]
end
