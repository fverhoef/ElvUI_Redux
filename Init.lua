local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Addon = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.name = "ElvUI Redux"
Addon.title = "|cff1784d1ElvUI|r |cff76FF03Redux|r"
Addon.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Addon.version = GetAddOnMetadata(addonName, "Version")

addonTable[1] = Addon
_G[addonName] = Addon

function Addon:Initialize()
    EP:RegisterPlugin(addonName, Addon.InsertOptions)

    Addon.Shadows:Initialize()
    Addon.MinimapButtonFrame:Initialize()
    Addon.Artwork:Initialize()
    Addon.Automation:Initialize()
    Addon.InventoryDatabase:Initialize()
    Addon.Tooltips:Initialize()

    if Addon.isClassic then
        E.oUF.colors.class["SHAMAN"] = {0.0, 0.44, 0.87}
        _G.RAID_CLASS_COLORS["SHAMAN"]["r"] = 0.0
        _G.RAID_CLASS_COLORS["SHAMAN"]["g"] = 0.44
        _G.RAID_CLASS_COLORS["SHAMAN"]["b"] = 0.87
    end
end

function Addon:Update()
    Addon.Artwork:UpdateArtwork()
    Addon.Shadows:UpdateShadows()
end

E:RegisterModule(Addon:GetName())
