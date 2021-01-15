local addonName, addonTable = ...
local Addon = addonTable[1]
local Artwork = Addon:NewModule(addonName .. "Artwork", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Artwork = Artwork
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

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
    frames = {
        ["Alliance"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.alliance, 166, 166, 1 / 1024, 167 / 1024, 593 / 1024, 759 / 1024},
            topRight = {Addon.media.textures.frames.alliance, 166, 166, 167 / 1024, 1 / 1024, 593 / 1024, 759 / 1024},
            bottomLeft = {Addon.media.textures.frames.alliance, 166, 166, 1 / 1024, 167 / 1024, 759 / 1024, 593 / 1024},
            bottomRight = {Addon.media.textures.frames.alliance, 166, 166, 167 / 1024, 1 / 1024, 759 / 1024, 593 / 1024},
            top = {Addon.media.textures.frames.alliance, 256, 30, 0, 256 / 1024, 33 / 1024, 63 / 1024},
            bottom = {Addon.media.textures.frames.alliance, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.allianceVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.allianceVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.alliance, 33, 32, 169 / 1024, 202 / 1024, 593 / 1024, 625 / 1024}
        },
        ["Horde"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.horde, 166, 166, 1 / 1024, 167 / 1024, 802 / 1024, 968 / 1024},
            topRight = {Addon.media.textures.frames.horde, 166, 166, 167 / 1024, 1 / 1024, 802 / 1024, 968 / 1024},
            bottomLeft = {Addon.media.textures.frames.horde, 166, 166, 1 / 1024, 167 / 1024, 968 / 1024, 802 / 1024},
            bottomRight = {Addon.media.textures.frames.horde, 166, 166, 167 / 1024, 1 / 1024, 968 / 1024, 802 / 1024},
            top = {Addon.media.textures.frames.horde, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.horde, 256, 30, 0, 256 / 1024, 88 / 1024, 118 / 1024},
            left = {Addon.media.textures.frames.hordeVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.hordeVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.horde, 33, 32, 854 / 1024, 887 / 1024, 152 / 1024, 184 / 1024}
        },
        ["Kyrian"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.kyrian, 166, 166, 1 / 1024, 167 / 1024, 152 / 1024, 318 / 1024},
            topRight = {Addon.media.textures.frames.kyrian, 166, 166, 167 / 1024, 1 / 1024, 152 / 1024, 318 / 1024},
            bottomLeft = {Addon.media.textures.frames.kyrian, 166, 166, 1 / 1024, 167 / 1024, 320 / 1024, 486 / 1024},
            bottomRight = {Addon.media.textures.frames.kyrian, 166, 166, 167 / 1024, 1 / 1024, 320 / 1024, 486 / 1024},
            top = {Addon.media.textures.frames.kyrian, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.kyrian, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.kyrianVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.kyrianVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.kyrian, 33, 32, 1 / 1024, 34 / 1024, 824 / 1024, 856 / 1024}
        },
        ["Marine"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.marine, 166, 166, 167 / 1024, 1 / 1024, 593 / 1024, 759 / 1024},
            topRight = {Addon.media.textures.frames.marine, 166, 166, 1 / 1024, 167 / 1024, 593 / 1024, 759 / 1024},
            bottomLeft = {Addon.media.textures.frames.marine, 166, 166, 167 / 1024, 1 / 1024, 759 / 1024, 593 / 1024},
            bottomRight = {Addon.media.textures.frames.marine, 166, 166, 1 / 1024, 167 / 1024, 759 / 1024, 593 / 1024},
            top = {Addon.media.textures.frames.marine, 256, 30, 0, 256 / 1024, 33 / 1024, 63 / 1024},
            bottom = {Addon.media.textures.frames.marine, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.marineVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.marineVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.marine, 33, 32, 169 / 1024, 202 / 1024, 593 / 1024, 625 / 1024}
        },
        ["Mechagon"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.mechagon, 166, 166, 1 / 1024, 167 / 1024, 593 / 1024, 759 / 1024},
            topRight = {Addon.media.textures.frames.mechagon, 166, 166, 167 / 1024, 1 / 1024, 593 / 1024, 759 / 1024},
            bottomLeft = {Addon.media.textures.frames.mechagon, 166, 166, 1 / 1024, 167 / 1024, 759 / 1024, 593 / 1024},
            bottomRight = {Addon.media.textures.frames.mechagon, 166, 166, 167 / 1024, 1 / 1024, 759 / 1024, 593 / 1024},
            top = {Addon.media.textures.frames.mechagon, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.mechagon, 256, 30, 0, 256 / 1024, 88 / 1024, 118 / 1024},
            left = {Addon.media.textures.frames.mechagonVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.mechagonVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.mechagon, 33, 32, 169 / 1024, 202 / 1024, 593 / 1024, 625 / 1024}
        },
        ["Metal"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.metal, 166, 166, 1 / 256, 167 / 256, 65 / 256, 231 / 256},
            topRight = {Addon.media.textures.frames.metal, 166, 166, 167 / 256, 1 / 256, 65 / 256, 231 / 256},
            bottomLeft = {Addon.media.textures.frames.metal, 166, 166, 1 / 256, 167 / 256, 231 / 256, 65 / 256},
            bottomRight = {Addon.media.textures.frames.metal, 166, 166, 167 / 256, 1 / 256, 231 / 256, 65 / 256},
            top = {Addon.media.textures.frames.metal, 256, 30, 0, 1, 33 / 256, 63 / 256},
            bottom = {Addon.media.textures.frames.metal, 256, 30, 0, 1, 1 / 256, 31 / 256},
            left = {Addon.media.textures.frames.metalVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.metalVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.metal, 33, 32, 169 / 256, 202 / 256, 65 / 256, 97 / 256}
        },
        ["Necrolord"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.necrolord, 166, 166, 1 / 1024, 167 / 1024, 318 / 1024, 152 / 1024},
            topRight = {Addon.media.textures.frames.necrolord, 166, 166, 167 / 1024, 1 / 1024, 318 / 1024, 152 / 1024},
            bottomLeft = {Addon.media.textures.frames.necrolord, 166, 166, 1 / 1024, 167 / 1024, 152 / 1024, 318 / 1024},
            bottomRight = {Addon.media.textures.frames.necrolord, 166, 166, 167 / 1024, 1 / 1024, 152 / 1024, 318 / 1024},
            top = {Addon.media.textures.frames.necrolord, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.necrolord, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.necrolordVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.necrolordVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.necrolord, 33, 32, 1 / 1024, 34 / 1024, 824 / 1024, 856 / 1024}
        },
        ["Neutral"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.neutral, 166, 166, 1 / 1024, 167 / 1024, 738 / 1024, 904 / 1024},
            topRight = {Addon.media.textures.frames.neutral, 166, 166, 167 / 1024, 1 / 1024, 738 / 1024, 904 / 1024},
            bottomLeft = {Addon.media.textures.frames.neutral, 166, 166, 1 / 1024, 167 / 1024, 904 / 1024, 738 / 1024},
            bottomRight = {Addon.media.textures.frames.neutral, 166, 166, 167 / 1024, 1 / 1024, 904 / 1024, 738 / 1024},
            top = {Addon.media.textures.frames.neutral, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            bottom = {Addon.media.textures.frames.neutral, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            left = {Addon.media.textures.frames.neutralVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.neutralVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.neutral, 33, 32, 1 / 1024, 34 / 1024, 593 / 1024, 625 / 1024}
        },
        ["NightFae"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.nightFae, 166, 166, 1 / 1024, 167 / 1024, 489 / 1024, 655 / 1024},
            topRight = {Addon.media.textures.frames.nightFae, 166, 166, 167 / 1024, 1 / 1024, 489 / 1024, 655 / 1024},
            bottomLeft = {Addon.media.textures.frames.nightFae, 166, 166, 167 / 1024, 1 / 1024, 689 / 1024, 855 / 1024},
            bottomRight = {Addon.media.textures.frames.nightFae, 166, 166, 1 / 1024, 167 / 1024, 689 / 1024, 855 / 1024},
            top = {Addon.media.textures.frames.nightFae, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.nightFae, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.nightFaeVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.nightFaeVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.nightFae, 33, 32, 1 / 1024, 34 / 1024, 657 / 1024, 689 / 1024}
        },
        ["Oribos"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.oribos, 166, 166, 1 / 256, 167 / 256, 488 / 1024, 654 / 1024},
            topRight = {Addon.media.textures.frames.oribos, 166, 166, 167 / 256, 1 / 256, 488 / 1024, 654 / 1024},
            bottomLeft = {Addon.media.textures.frames.oribos, 166, 166, 1 / 256, 167 / 256, 654 / 1024, 488 / 1024},
            bottomRight = {Addon.media.textures.frames.oribos, 166, 166, 167 / 256, 1 / 256, 654 / 1024, 488 / 1024},
            top = {Addon.media.textures.frames.oribos, 256, 30, 0, 1, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.oribos, 256, 30, 0, 1, 88 / 1024, 118 / 1024},
            left = {Addon.media.textures.frames.oribosVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.oribosVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.oribos, 33, 32, 169 / 256, 202 / 256, 152 / 1024, 184 / 1024}
        },
        ["Venthyr"] = {
            scale = 0.5,
            offset = {-24, 24},
            topLeft = {Addon.media.textures.frames.venthyr, 166, 166, 1 / 1024, 167 / 1024, 152 / 1024, 318 / 1024},
            topRight = {Addon.media.textures.frames.venthyr, 166, 166, 167 / 1024, 1 / 1024, 152 / 1024, 318 / 1024},
            bottomLeft = {Addon.media.textures.frames.venthyr, 166, 166, 1 / 1024, 167 / 1024, 318 / 1024, 152 / 1024},
            bottomRight = {Addon.media.textures.frames.venthyr, 166, 166, 167 / 1024, 1 / 1024, 318 / 1024, 152 / 1024},
            top = {Addon.media.textures.frames.venthyr, 256, 30, 0, 256 / 1024, 120 / 1024, 150 / 1024},
            bottom = {Addon.media.textures.frames.venthyr, 256, 30, 0, 256 / 1024, 1 / 1024, 31 / 1024},
            left = {Addon.media.textures.frames.venthyrVertical, 30, 256, 1 / 64, 31 / 64, 0, 1},
            right = {Addon.media.textures.frames.venthyrVertical, 30, 256, 33 / 64, 63 / 64, 0, 1},
            closeButtonBackground = {Addon.media.textures.frames.venthyr, 33, 32, 1 / 1024, 34 / 1024, 824 / 1024, 856 / 1024}
        }
    },
    nestedFrames = {}
}

-- Registry
Artwork.registry = {frames = {}, nestedFrames = {}, buttons = {}}

function Artwork:IsFrameRegistered(frame)
    return Artwork.registry.frames[frame] or Artwork.registry.nestedFrames[frame] or false
end

function Artwork:IsParentFrameRegistered(frame)
    local parent = frame:GetParent()
    while parent do
        if Artwork.registry.frames[parent] then
            return true
        end

        parent = parent:GetParent()
    end

    return false
end

function Artwork:IsButtonRegistered(button)
    return Artwork.registry.buttons[button] or false
end

-- Init/Update
function Artwork:Initialize()
    Artwork:ScheduleTimer("UpdateArtwork", 1)

    -- skin any frame that isn't handled by overriding Skins.HandleFrame
    Artwork:SkinFrame(_G.GameMenuFrame)
    Artwork:SkinFrame(_G.InterfaceOptionsFrame)
    Artwork:SkinFrame(_G.VideoOptionsFrame)
    Artwork:SkinFrame(_G.ScriptErrorsFrame)
    Artwork:SkinFrame(_G.StackSplitFrame)
    Artwork:SkinFrame(_G.LootFrame)
    Artwork:SkinFrame(_G.LootHistoryFrame)
    Artwork:SkinFrame(_G.MasterLooterFrame)
    Artwork:SkinFrame(_G.ReadyCheckFrame)
    Artwork:SkinFrame(_G.WorldMapFrame)
    for i = 1, 4 do
        Artwork:SkinFrame(_G["StaticPopup" .. i])
    end
    for i = 1, 4 do
        Artwork:SkinFrame(_G["ElvUI_StaticPopup" .. i])
    end
end

function Artwork:UpdateArtwork()
    for frame, _ in pairs(Artwork.registry.frames) do
        Artwork:UpdateFrame(frame)
    end

    for frame, _ in pairs(Artwork.registry.nestedFrames) do
        Artwork:UpdateNestedFrame(frame)
    end

    for button, _ in pairs(Artwork.registry.buttons) do
        Artwork:UpdateButton(button)
    end
end

-- Frames
function Artwork:SkinFrame(frame)
    if not frame then
        return
    end
    if Artwork:IsFrameRegistered(frame) then
        Artwork:UpdateFrame(frame)
        return
    end

    local atlas = Artwork.atlas.frames[E.db[addonName].artwork.frameTheme]

    Artwork:CreateBorder(frame, atlas)
    Artwork:SkinCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], atlas)

    Artwork.registry.frames[frame] = true
end

function Artwork:UpdateFrame(frame)
    if not frame then
        return
    end

    local atlas = Artwork.atlas.frames[E.db[addonName].artwork.frameTheme]

    Artwork:UpdateBorder(frame.Border, atlas)
    Artwork:UpdateCloseButton(frame.closeButton or frame.CloseButton or _G[(frame:GetName() or "?") .. "CloseButton"], atlas)
end

function Artwork:SkinNestedFrame(frame)
    if not frame and not Artwork:IsFrameRegistered(frame) then
        return
    end

    local atlas = Artwork.atlas.nestedFrames[E.db[addonName].artwork.frameTheme]

    Artwork.registry.nestedFrames[frame] = true
end

function Artwork:UpdateNestedFrame(frame)
    if not frame then
        return
    end

    local atlas = Artwork.atlas.nestedFrames[E.db[addonName].artwork.frameTheme]
end

-- Frame Close Buttons
function Artwork:SkinCloseButton(closeButton, atlas)
    if closeButton and not closeButton.Background then
        closeButton.Background = closeButton:CreateTexture(nil, "ARTWORK")
        closeButton.Background:SetAllPoints(closeButton)
        Artwork:UpdateCloseButton(closeButton, atlas)
    end
end

function Artwork:UpdateCloseButton(closeButton, atlas)
    local background = closeButton and closeButton.Background
    if background then
        if not E.db[addonName].artwork.enabled or not atlas then
            background:Hide()
        else
            background:Show()

            local texture = atlas.closeButtonBackground and atlas.closeButtonBackground[1]
            background:SetTexture(texture)
            if texture then
                background:SetTexCoord(atlas.closeButtonBackground[4], atlas.closeButtonBackground[5], atlas.closeButtonBackground[6], atlas.closeButtonBackground[7])
            end
        end
    end
end

-- Borders
function Artwork:CreateBorder(frame, atlas)
    if frame.Border then
        return
    end

    local parent = frame.backdrop or frame
    border = CreateFrame("Frame", nil, parent)

    border.TopLeft = border:CreateTexture(nil, "ARTWORK")
    border.TopRight = border:CreateTexture(nil, "ARTWORK")
    border.BottomLeft = border:CreateTexture(nil, "ARTWORK")
    border.BottomRight = border:CreateTexture(nil, "ARTWORK")
    border.Top = border:CreateTexture(nil, "ARTWORK")
    border.Bottom = border:CreateTexture(nil, "ARTWORK")
    border.Left = border:CreateTexture(nil, "ARTWORK")
    border.Right = border:CreateTexture(nil, "ARTWORK")

    border.Top:SetHorizTile(true)
    border.Bottom:SetHorizTile(true)
    border.Left:SetVertTile(true)
    border.Right:SetVertTile(true)

    border.TopLeft:SetPoint("TOPLEFT", border, "TOPLEFT")
    border.TopRight:SetPoint("TOPRIGHT", border, "TOPRIGHT")
    border.BottomLeft:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT")
    border.BottomRight:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT")
    border.Top:SetPoint("TOPLEFT", border.TopLeft, "TOPRIGHT")
    border.Top:SetPoint("TOPRIGHT", border.TopRight, "TOPLEFT")
    border.Bottom:SetPoint("BOTTOMLEFT", border.BottomLeft, "BOTTOMRIGHT")
    border.Bottom:SetPoint("BOTTOMRIGHT", border.BottomRight, "BOTTOMLEFT")
    border.Left:SetPoint("TOPLEFT", border.TopLeft, "BOTTOMLEFT")
    border.Left:SetPoint("BOTTOMLEFT", border.BottomLeft, "TOPLEFT")
    border.Right:SetPoint("TOPRIGHT", border.TopRight, "BOTTOMRIGHT")
    border.Right:SetPoint("BOTTOMRIGHT", border.BottomRight, "TOPRIGHT")

    border:SetScript("OnShow", function(self)
        Artwork:UpdateBorderScale(self)
    end)

    frame.Border = border

    Artwork:UpdateBorder(frame.Border, atlas)
end

function Artwork:UpdateBorder(border, atlas)
    if not border then
        return
    end

    if not E.db[addonName].artwork.enabled or not atlas then
        border:Hide()
    else
        border:Show()
        local parent = border:GetParent()
        local offsetX, offsetY = atlas.offset[1], atlas.offset[2]
        border:SetPoint("TOPLEFT", parent, "TOPLEFT", offsetX, offsetY)
        border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -offsetX, -offsetY)

        border.TopLeft:SetSize(atlas.topLeft[2], atlas.topLeft[3])
        border.TopLeft:SetTexture(atlas.topLeft[1])
        border.TopLeft:SetTexCoord(atlas.topLeft[4], atlas.topLeft[5], atlas.topLeft[6], atlas.topLeft[7])

        border.TopRight:SetSize(atlas.topRight[2], atlas.topRight[3])
        border.TopRight:SetTexture(atlas.topRight[1])
        border.TopRight:SetTexCoord(atlas.topRight[4], atlas.topRight[5], atlas.topRight[6], atlas.topRight[7])

        border.BottomLeft:SetSize(atlas.bottomLeft[2], atlas.bottomLeft[3])
        border.BottomLeft:SetTexture(atlas.bottomLeft[1])
        border.BottomLeft:SetTexCoord(atlas.bottomLeft[4], atlas.bottomLeft[5], atlas.bottomLeft[6], atlas.bottomLeft[7])

        border.BottomRight:SetSize(atlas.bottomRight[2], atlas.bottomRight[3])
        border.BottomRight:SetTexture(atlas.bottomRight[1])
        border.BottomRight:SetTexCoord(atlas.bottomRight[4], atlas.bottomRight[5], atlas.bottomRight[6], atlas.bottomRight[7])

        border.Top:SetSize(atlas.top[2], atlas.top[3])
        border.Top:SetTexture(atlas.top[1], "MIRROR")
        border.Top:SetTexCoord(atlas.top[4], atlas.top[5], atlas.top[6], atlas.top[7])

        border.Bottom:SetSize(atlas.bottom[2], atlas.bottom[3])
        border.Bottom:SetTexture(atlas.bottom[1], "MIRROR")
        border.Bottom:SetTexCoord(atlas.bottom[4], atlas.bottom[5], atlas.bottom[6], atlas.bottom[7])

        border.Left:SetSize(atlas.left[2], atlas.left[3])
        border.Left:SetTexture(atlas.left[1], nil, "MIRROR")
        border.Left:SetTexCoord(atlas.left[4], atlas.left[5], atlas.left[6], atlas.left[7])

        border.Right:SetSize(atlas.right[2], atlas.right[3])
        border.Right:SetTexture(atlas.right[1], nil, "MIRROR")
        border.Right:SetTexCoord(atlas.right[4], atlas.right[5], atlas.right[6], atlas.right[7])

        Artwork:UpdateBorderScale(border)
    end
end

function Artwork:UpdateBorderScale(border)
    if not border then
        return
    end

    local atlas = Artwork.atlas.frames[E.db[addonName].artwork.frameTheme]
    if not E.db[addonName].artwork.enabled or not atlas then
        return
    end

    local parent = border:GetParent()
    local scale = atlas.scale
    local minWidth = atlas.topLeft[2] + atlas.topRight[2]
    local minHeight = atlas.topLeft[3] + atlas.bottomLeft[3]

    local parentWidth, parentHeight = parent:GetSize()
    if parentWidth > 0 and parentWidth < (scale * minWidth) then
        scale = parentWidth / minWidth
    end
    if parentHeight > 0 and parentHeight < (scale * minHeight) then
        scale = parentHeight / minHeight
    end
    border:SetScale(scale)
end

-- Buttons
function Artwork:SkinButton(button)
    if not button then
        return
    end
    if Artwork:IsButtonRegistered(button) then
        Artwork:UpdateButton(button)
        return
    end

    button.ArtworkLeft = button:CreateTexture(nil, "BACKGROUND")
    button.ArtworkRight = button:CreateTexture(nil, "BACKGROUND")
    button.ArtworkCenter = button:CreateTexture(nil, "BACKGROUND")

    button.ArtworkLeftHighlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.ArtworkRightHighlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.ArtworkCenterHighlight = button:CreateTexture(nil, "HIGHLIGHT")

    button:HookScript("OnMouseDown", function()
    end)

    button:HookScript("OnMouseUp", function()
    end)

    Artwork:UpdateButton(button)

    Artwork.registry.buttons[button] = true
end

function Artwork:UpdateButton(button)
    if not button then
        return
    end

    local atlas = Artwork.atlas.buttons[E.db[addonName].artwork.buttonTheme]

    if not E.db[addonName].artwork.enabled or not atlas then
        E:TogglePixelBorders(button, true)

        button.ArtworkLeft:Hide()
        button.ArtworkCenter:Hide()
        button.ArtworkRight:Hide()
        button.ArtworkLeftHighlight:Hide()
        button.ArtworkCenterHighlight:Hide()
        button.ArtworkRightHighlight:Hide()
    else
        local offsetX, offsetY = unpack(atlas.offset)
        E:TogglePixelBorders(button, false)

        button.ArtworkLeft:Show()
        button.ArtworkLeft:SetWidth(atlas.leftWidth)
        button.ArtworkLeft:SetPoint("TOPLEFT", button, "TOPLEFT", offsetX, offsetY)
        button.ArtworkLeft:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", offsetX, -1 * offsetY)
        button.ArtworkLeft:SetTexture(atlas.left[1])
        button.ArtworkLeft:SetTexCoord(atlas.left[2], atlas.left[3], atlas.left[4], atlas.left[5])

        button.ArtworkRight:Show()
        button.ArtworkRight:SetWidth(atlas.rightWidth)
        button.ArtworkRight:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1 * offsetX, offsetY)
        button.ArtworkRight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1 * offsetX, -1 * offsetY)
        button.ArtworkRight:SetTexture(atlas.right[1])
        button.ArtworkRight:SetTexCoord(atlas.right[2], atlas.right[3], atlas.right[4], atlas.right[5])

        button.ArtworkCenter:Show()
        button.ArtworkCenter:SetPoint("TOPLEFT", button.ArtworkLeft, "TOPRIGHT")
        button.ArtworkCenter:SetPoint("BOTTOMRIGHT", button.ArtworkRight, "BOTTOMLEFT")
        button.ArtworkCenter:SetTexture(atlas.center[1])
        button.ArtworkCenter:SetTexCoord(atlas.center[2], atlas.center[3], atlas.center[4], atlas.center[5])

        if atlas.leftHighlight then
            button.ArtworkLeftHighlight:Show()
            button.ArtworkLeftHighlight:SetWidth(atlas.leftWidth)
            button.ArtworkLeftHighlight:SetPoint("TOPLEFT", button, "TOPLEFT", offsetX, offsetY)
            button.ArtworkLeftHighlight:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", offsetX, -1 * offsetY)
            button.ArtworkLeftHighlight:SetTexture(atlas.leftHighlight[1])
            button.ArtworkLeftHighlight:SetTexCoord(atlas.leftHighlight[2], atlas.leftHighlight[3], atlas.leftHighlight[4], atlas.leftHighlight[5])

            button.ArtworkRightHighlight:Show()
            button.ArtworkRightHighlight:SetWidth(atlas.rightWidth)
            button.ArtworkRightHighlight:SetPoint("TOPRIGHT", button, "TOPRIGHT", -1 * offsetX, offsetY)
            button.ArtworkRightHighlight:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1 * offsetX, -1 * offsetY)
            button.ArtworkRightHighlight:SetTexture(atlas.rightHighlight[1])
            button.ArtworkRightHighlight:SetTexCoord(atlas.rightHighlight[2], atlas.rightHighlight[3], atlas.rightHighlight[4], atlas.rightHighlight[5])

            button.ArtworkCenterHighlight:Show()
            button.ArtworkCenterHighlight:SetPoint("TOPLEFT", button.ArtworkLeftHighlight, "TOPRIGHT")
            button.ArtworkCenterHighlight:SetPoint("BOTTOMRIGHT", button.ArtworkRightHighlight, "BOTTOMLEFT")
            button.ArtworkCenterHighlight:SetTexture(atlas.centerHighlight[1])
            button.ArtworkCenterHighlight:SetTexCoord(atlas.centerHighlight[2], atlas.centerHighlight[3], atlas.centerHighlight[4], atlas.centerHighlight[5])
        else
            button.ArtworkLeftHighlight:SetTexture()
            button.ArtworkCenterHighlight:SetTexture()
            button.ArtworkRightHighlight:SetTexture()
        end
    end
end

-- ElvUI Overrides
local originalHandleFrame = S.HandleFrame
S.HandleFrame = function(...)
    originalHandleFrame(...)

    local _, frame, setBackdrop, template, x1, y1, x2, y2 = ...
    if Artwork:IsParentFrameRegistered(frame) then
        Artwork:SkinNestedFrame(frame)
    else
        Artwork:SkinFrame(frame)
    end
end

local originalHandleButton = S.HandleButton
S.HandleButton = function(...)
    originalHandleButton(...)

    local _, button, strip, isDeclineButton, useCreateBackdrop, noSetTemplate = ...

    if strip then
        return
    end
    if button.artworkType == "SCROLL_UP" or button.artworkType == "SCROLL_DOWN" or button.artworkType == "NEXT_PREV" then
        return
    end

    Artwork:SkinButton(button)
end

local originalHandleScrollBar = S.HandleScrollBar
S.HandleScrollBar = function(...)
    local function GrabScrollBarElement(frame, element)
        local FrameName = frame:GetName()
        return frame[element] or FrameName and (_G[FrameName .. element] or strfind(FrameName, element)) or nil
    end

    local _, frame, thumbTrimY, thumbTrimX = ...

    local parent = frame:GetParent()
    local ScrollUpButton = GrabScrollBarElement(frame, "ScrollUpButton") or GrabScrollBarElement(frame, "UpButton") or GrabScrollBarElement(frame, "ScrollUp") or
                               GrabScrollBarElement(parent, "scrollUp")
    local ScrollDownButton = GrabScrollBarElement(frame, "ScrollDownButton") or GrabScrollBarElement(frame, "DownButton") or GrabScrollBarElement(frame, "ScrollDown") or
                                 GrabScrollBarElement(parent, "scrollDown")
    local Thumb = GrabScrollBarElement(frame, "ThumbTexture") or GrabScrollBarElement(frame, "thumbTexture") or frame.GetThumbTexture and frame:GetThumbTexture()

    ScrollUpButton.artworkType = "SCROLL_UP"
    ScrollDownButton.artworkType = "SCROLL_DOWN"
    Thumb.artworkType = "SCROLL_THUMB"

    originalHandleScrollBar(...)
end

local originalHandleNextPrevButton = S.HandleNextPrevButton
S.HandleNextPrevButton = function(...)
    local _, btn, arrowDir, color, noBackdrop, stripTexts = ...
    btn.artworkType = "NEXT_PREV"

    originalHandleNextPrevButton(...)
end

local originalConfig_WindowOpened = E.Config_WindowOpened
E.Config_WindowOpened = function(...)
    originalConfig_WindowOpened(...)

    local optionsFrame = E:Config_GetWindow()
    if optionsFrame then
        Artwork:SkinFrame(optionsFrame)
    end
end

local originalStaticPopupSpecial_Show = E.StaticPopupSpecial_Show
E.StaticPopupSpecial_Show = function(...)
    originalStaticPopupSpecial_Show(...)

    local _, frame = ...
    Artwork:SkinFrame(frame)
end
