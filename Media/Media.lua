local addonName, addonTable = ...
local Module = addonTable[1]
local LSM = LibStub("LibSharedMedia-3.0")

Module.media = {
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
            redux = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\StatusBars\\Redux",
        },
        
        arrowUp_ElvUI = "Interface\\Addons\\ElvUI\\Media\\Textures\\ArrowUp",
        minimapButtonBorder1 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\MinimapButtonBorder1",
        minimapButtonBorder2 = "Interface\\AddOns\\" .. addonName .. "\\Media\\Textures\\MinimapButtonBorder2",
        portraitAlphaMask = "Interface\\CharacterFrame\\TempPortraitAlphaMask"
    }
}

LSM:Register("font", "Adventure", Module.media.fonts.adventure )
LSM:Register("statusbar", "Kait1", Module.media.textures.statusBars.kait1)
LSM:Register("statusbar", "Kait2", Module.media.textures.statusBars.kait2)
LSM:Register("statusbar", "Melli", Module.media.textures.statusBars.melli)
LSM:Register("statusbar", "MelliDark", Module.media.textures.statusBars.melliDark)
LSM:Register("statusbar", "One Pixel", Module.media.textures.statusBars.onePixel)
LSM:Register("statusbar", "Redux", Module.media.textures.statusBars.redux)