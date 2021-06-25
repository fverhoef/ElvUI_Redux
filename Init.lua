local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")

local Addon = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.name = "Redux"
Addon.title = "|cff76FF03Redux|r"
Addon.version = GetAddOnMetadata(addonName, "Version")

local build = select(4, GetBuildInfo())
Addon.isClassic = build < 20000
Addon.isTbc = build < 30000
Addon.isWotlk = build < 40000
Addon.isRetail = build > 40000

addonTable[1] = Addon
_G[addonName] = Addon

function Addon:Initialize()
    EP:RegisterPlugin(addonName, Addon.InsertOptions)

    Addon:ApplySkins()
    Addon:HookTooltips()
end

function Addon:Update()
    Addon:UpdateSkins()
end

function Addon:OnSettingChanged(setting)
    if setting[1] == "shadows" or setting[1] == "borders" then
        Addon:UpdateSkins()
    elseif setting[1] == "layout" then
        ReloadUI()
    end
end

Addon.registry = {borders = {}, shadows = {}}

function Addon:RegisterShadow(shadow)
    if not shadow or shadow.isRegistered then
        return
    end
    Addon.registry.shadows[shadow] = true
    shadow.isRegistered = true
end

function Addon:RegisterBorder(border)
    if not border or border.isRegistered then
        return
    end
    Addon.registry.borders[border] = true
    border.isRegistered = true
end

E:RegisterModule(Addon:GetName())
