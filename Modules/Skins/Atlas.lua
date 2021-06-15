local addonName, addonTable = ...
local Addon = addonTable[1]
local Skins = Addon.Skins
local E, L, V, P, G = unpack(ElvUI)

Skins.atlas = {
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
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
            scale = 1,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.onyx, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.onyx, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.onyx, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.onyx, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.onyx, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.onyx, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.onyx, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.onyx, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Retina"] = {
            scale = 1,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.retina, 4, 4, 0, 8 / 64, 0, 8 / 64},
            topRight = {Addon.media.textures.borders.retina, 4, 4, 56 / 64, 1, 0, 8 / 64},
            bottomLeft = {Addon.media.textures.borders.retina, 4, 4, 0, 8 / 64, 56 / 64, 1},
            bottomRight = {Addon.media.textures.borders.retina, 4, 4, 56 / 64, 1, 56 / 64, 1},
            top = {Addon.media.textures.borders.retina, 32, 4, 8 / 64, 56 / 64, 0, 8 / 64},
            bottom = {Addon.media.textures.borders.retina, 32, 4, 8 / 64, 56 / 64, 56 / 64, 1},
            left = {Addon.media.textures.borders.retina, 4, 32, 0, 8 / 64, 8 / 64, 56 / 64},
            right = {Addon.media.textures.borders.retina, 4, 32, 56 / 64, 1, 8 / 64, 56 / 64}
        },
        ["Shadowlands"] = {
            scale = 1,
            offset = {-4, 4},
            verticalTiling = true,
            horizontalTiling = true,
            topLeft = {Addon.media.textures.borders.shadowlandsTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.shadowlandsTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.shadowlandsTopLeft, 8, 8, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.shadowlandsTopLeft, 8, 8, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.shadowlandsTop, 256, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.shadowlandsTop, 256, 8, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.shadowlandsLeft, 8, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.shadowlandsLeft, 8, 256, 1, 0, 0, 1}
        }
    },
    frames = {
        ["Alliance"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frameBorders.allianceTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frameBorders.allianceHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.allianceHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.allianceVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.allianceVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.alliance, 32, 32, 0, 1, 0, 1},
            title = {
                scale = 0.30,
                horizontalTiling = true,
                left = {Addon.media.textures.frameTitles.allianceLeft, 202, 85, 0, 202 / 256, 0, 85 / 128},
                middle = {Addon.media.textures.frameTitles.allianceMiddle, 256, 75, 0, 1, 10 / 128, 85 / 128},
                right = {Addon.media.textures.frameTitles.allianceLeft, 202, 85, 202 / 256, 0, 0, 85 / 128}
            }
        },
        ["Horde"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frameBorders.hordeTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frameBorders.hordeHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.hordeHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.hordeVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.hordeVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.horde, 32, 32, 0, 1, 0, 1},
            title = {
                scale = 0.30,
                horizontalTiling = true,
                left = {Addon.media.textures.frameTitles.hordeLeft, 202, 85, 0, 202 / 256, 0, 85 / 128},
                middle = {Addon.media.textures.frameTitles.hordeMiddle, 256, 75, 0, 1, 10 / 128, 85 / 128},
                right = {Addon.media.textures.frameTitles.hordeLeft, 202, 85, 202 / 256, 0, 0, 85 / 128}
            }
        },
        ["Metal"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 0, 166 / 256, 166 / 256, 0},
                bottomRight = {Addon.media.textures.frameBorders.metalTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frameBorders.metalHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.metalHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.metalVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.metalVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.metal, 32, 32, 0, 1, 0, 1}
        },
        ["Kyrian"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.kyrianTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.kyrianTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.kyrianBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.kyrianBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.kyrianHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.kyrianHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.kyrianVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.kyrianVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.kyrian, 32, 32, 0, 1, 0, 1}
        },
        ["Marine"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.marineTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.marineTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.marineBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.marineBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.marineHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.marineHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.marineVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.marineVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.marine, 32, 32, 0, 1, 0, 1}
        },
        ["Mechagon"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 0, 166 / 256, 166 / 255, 0},
                bottomRight = {Addon.media.textures.frameBorders.mechagonTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frameBorders.mechagonHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.mechagonHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.mechagonVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.mechagonVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.mechagon, 32, 32, 0, 1, 0, 1}
        },
        ["Necrolord"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.necrolordTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.necrolordTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.necrolordBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.necrolordBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.necrolordHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.necrolordHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.necrolordVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.necrolordVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.necrolord, 32, 32, 0, 1, 0, 1}
        },
        ["Neutral"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 0, 166 / 256, 166 / 255, 0},
                bottomRight = {Addon.media.textures.frameBorders.neutralTopLeft, 166, 166, 166 / 256, 0, 166 / 256, 0},
                top = {Addon.media.textures.frameBorders.neutralHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.neutralHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.neutralVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.neutralVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.neutral, 32, 32, 0, 1, 0, 1}
        },
        ["NightFae"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.nightFaeTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.nightFaeTopLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.nightFaeBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.nightFaeBottomLeft, 166, 166, 166 / 256, 0, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.nightFaeHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.nightFaeHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.nightFaeVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.nightFaeVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.nightFae, 32, 32, 0, 1, 0, 1}
        },
        ["Oribos"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.oribosTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.oribosTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.oribosBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.oribosBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.oribosHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.oribosHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.oribosVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.oribosVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.oribos, 32, 32, 0, 1, 0, 1}
        },
        ["Venthyr"] = {
            border = {
                scale = 0.5,
                offset = {-20, 20},
                verticalTiling = true,
                horizontalTiling = true,
                topLeft = {Addon.media.textures.frameBorders.venthyrTopLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                topRight = {Addon.media.textures.frameBorders.venthyrTopRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomLeft = {Addon.media.textures.frameBorders.venthyrBottomLeft, 166, 166, 0, 166 / 256, 0, 166 / 256},
                bottomRight = {Addon.media.textures.frameBorders.venthyrBottomRight, 166, 166, 0, 166 / 256, 0, 166 / 256},
                top = {Addon.media.textures.frameBorders.venthyrHorizontal, 256, 32, 0, 1, 0, 32 / 64},
                bottom = {Addon.media.textures.frameBorders.venthyrHorizontal, 256, 32, 0, 1, 32 / 64, 1},
                left = {Addon.media.textures.frameBorders.venthyrVertical, 32, 256, 0, 32 / 64, 0, 1},
                right = {Addon.media.textures.frameBorders.venthyrVertical, 32, 256, 32 / 64, 1, 0, 1}
            },
            closeButtonBackground = {Addon.media.textures.closeButtons.venthyr, 32, 32, 0, 1, 0, 1}
        }
    }
}

function Skins:GetFrameBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetTooltipBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetUnitFrameBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetButtonBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetActionButtonBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetItemButtonBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetBagSlotButtonBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetBagBarButtonBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetAuraBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end

function Skins:GetTempEnchantBorderAtlas()
    return Skins.atlas.borders[E.db[addonName].skins.borders.style]
end