local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon.Artwork
local E, L, V, P, G = unpack(ElvUI)

Artwork.atlas = {
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
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.beautyCaseTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.beautyCaseTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.beautyCaseBottomLeft, 8, 8, 0, 1, 0, 1},
            bottomRight = {Addon.media.textures.borders.beautyCaseBottomLeft, 8, 8, 1, 0, 0, 1},
            top = {Addon.media.textures.borders.beautyCaseTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.beautyCaseBottom, 32, 8, 0, 1, 0, 1},
            left = {Addon.media.textures.borders.beautyCaseLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.beautyCaseLeft, 8, 32, 1, 0, 0, 1}
        },
        ["Clean"] = {
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.cleanTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.cleanTopRight, 8, 8, 0, 1, 0, 1},
            bottomLeft = {Addon.media.textures.borders.cleanBottomLeft, 8, 8, 0, 1, 0, 1},
            bottomRight = {Addon.media.textures.borders.cleanBottomRight, 8, 8, 0, 1, 0, 1},
            top = {Addon.media.textures.borders.cleanTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.cleanBottom, 32, 8, 0, 1, 0, 1},
            left = {Addon.media.textures.borders.cleanLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.cleanRight, 8, 32, 0, 1, 0, 1}
        },
        ["Goldpaw"] = {
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.goldpawTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.goldpawTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.goldpawBottomLeft, 8, 8, 0, 1, 0, 1},
            bottomRight = {Addon.media.textures.borders.goldpawBottomLeft, 8, 8, 1, 0, 0, 1},
            top = {Addon.media.textures.borders.goldpawTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.goldpawBottom, 32, 8, 0, 1, 0, 1},
            left = {Addon.media.textures.borders.goldpawLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.goldpawLeft, 8, 32, 1, 0, 0, 1}
        },
        ["Onyx"] = {
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.onyxTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.onyxTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.onyxBottomLeft, 8, 8, 0, 1, 0, 1},
            bottomRight = {Addon.media.textures.borders.onyxBottomLeft, 8, 8, 1, 0, 0, 1},
            top = {Addon.media.textures.borders.onyxTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.onyxBottom, 32, 8, 0, 1, 0, 1},
            left = {Addon.media.textures.borders.onyxLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.onyxLeft, 8, 32, 1, 0, 0, 1}
        },
        ["Renaitre (Square)"] = {
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.renaitreSquareThinTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.renaitreSquareThinTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.renaitreSquareThinBottomLeft, 8, 8, 0, 1, 0, 1},
            bottomRight = {Addon.media.textures.borders.renaitreSquareThinBottomLeft, 8, 8, 1, 0, 0, 1},
            top = {Addon.media.textures.borders.renaitreSquareThinTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.renaitreSquareThinBottom, 32, 8, 0, 1, 0, 1},
            left = {Addon.media.textures.borders.renaitreSquareThinLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.renaitreSquareThinLeft, 8, 32, 1, 0, 0, 1}
        },
        ["Retina"] = {
            scale = 0.5,
            offset = {0, 0},
            topLeft = {Addon.media.textures.borders.retinaTopLeft, 8, 8, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.retinaTopLeft, 8, 8, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.retinaTopLeft, 8, 8, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.retinaTopLeft, 8, 8, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.retinaTop, 32, 8, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.retinaTop, 32, 8, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.retinaLeft, 8, 32, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.retinaLeft, 8, 32, 1, 0, 0, 1}
        },
        ["Shadowlands"] = {
            scale = 0.5,
            offset = {-4, 4},
            verticalTiling = true,
            horizontalTiling = true,
            topLeft = {Addon.media.textures.borders.shadowlandsTopLeft, 16, 16, 0, 1, 0, 1},
            topRight = {Addon.media.textures.borders.shadowlandsTopLeft, 16, 16, 1, 0, 0, 1},
            bottomLeft = {Addon.media.textures.borders.shadowlandsTopLeft, 16, 16, 0, 1, 1, 0},
            bottomRight = {Addon.media.textures.borders.shadowlandsTopLeft, 16, 16, 1, 0, 1, 0},
            top = {Addon.media.textures.borders.shadowlandsTop, 256, 16, 0, 1, 0, 1},
            bottom = {Addon.media.textures.borders.shadowlandsTop, 256, 16, 0, 1, 1, 0},
            left = {Addon.media.textures.borders.shadowlandsLeft, 16, 256, 0, 1, 0, 1},
            right = {Addon.media.textures.borders.shadowlandsLeft, 16, 256, 1, 0, 0, 1}
        }
    },
    frames = {
        ["Alliance"] = {
            border = {
                scale = 0.5,
                offset = {-24, 24},
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
            titleLeft = {Addon.media.textures.frameTitles.allianceLeft, 202, 85, 0, 202 / 256, 0, 85 / 128},
            titleMiddle = {Addon.media.textures.frameTitles.allianceMiddle, 202, 85, 0, 1, 0, 85 / 128}
        },
        ["Horde"] = {
            border = {
                scale = 0.5,
                offset = {-24, 24},
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
            closeButtonBackground = {Addon.media.textures.closeButtons.horde, 32, 32, 0, 1, 0, 1}
        },
        ["Metal"] = {
            border = {
                scale = 0.5,
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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
                offset = {-24, 24},
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

function Artwork:GetFrameAtlas()
    return Artwork.atlas.frames[E.db[addonName].artwork.skins.frameBorder]
end

function Artwork:GetFrameTabBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.skins.frameTabBorder]
end

function Artwork:GetThinFrameBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.skins.thinFrameBorder]
end

function Artwork:GetCloseButtonBackgroundAtlas()
    local frameAtlas = Artwork:GetFrameAtlas()
    return frameAtlas and frameAtlas.closeButtonBackground
end

function Artwork:GetFrameBackgroundAtlas()
    return Artwork.atlas.backgrounds[E.db[addonName].artwork.skins.frameBackground]
end

function Artwork:GetButtonBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.skins.buttonBorder]
end

function Artwork:GetActionButtonBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.actionBars.actionButtonBorder]
end

function Artwork:GetBagButtonBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.bagsAndItems.bagButtonBorder]
end

function Artwork:GetItemButtonBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.bagsAndItems.itemButtonBorder]
end

function Artwork:GetDataBarBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.dataBarsAndPanels.dataBarBorder]
end

function Artwork:GetDataPanelBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.dataBarsAndPanels.dataPanelBorder]
end

function Artwork:GetMinimapBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.minimap.border]
end

function Artwork:GetNamePlateHealthBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.namePlates.healthBorder]
end

function Artwork:GetNamePlatePowerBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.namePlates.powerBorder]
end

function Artwork:GetNamePlateCastBarBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.namePlates.castBarBorder]
end

function Artwork:GetTooltipBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.tooltips.tooltipBorder]
end

function Artwork:GetAuraBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.auras.auraBorder]
end

function Artwork:GetTempEnchantBorderAtlas()
    return Artwork.atlas.borders[E.db[addonName].artwork.auras.tempEnchantBorder]
end

function Artwork:GetUnitFrameBorderAtlas(unit)
    local value = E.db[addonName].artwork.unitFrames[unit]
    if not value then
        return
    end

    return Artwork.atlas.borders[value.border]
end

function Artwork:GetUnitFrameHealthBorderAtlas(unit)
    local value = E.db[addonName].artwork.unitFrames[unit]
    if not value then
        return
    end

    return Artwork.atlas.borders[value.healthBorder]
end

function Artwork:GetUnitFramePowerBorderAtlas(unit)
    local value = E.db[addonName].artwork.unitFrames[unit]
    if not value then
        return
    end

    return Artwork.atlas.borders[value.powerBorder]
end

function Artwork:GetUnitFrameCastBarBorderAtlas(unit)
    local value = E.db[addonName].artwork.unitFrames[unit]
    if not value then
        return
    end

    return Artwork.atlas.borders[value.castBarBorder]
end

function Artwork:GetUnitFrameClassBarBorderAtlas(unit)
    local value = E.db[addonName].artwork.unitFrames[unit]
    if not value then
        return
    end

    return Artwork.atlas.borders[value.classBarBorder]
end
