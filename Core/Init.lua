local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Addon = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.name = "ElvUI Redux"
Addon.title = "|cff1784d1ElvUI|r |cff03D3FFRedux|r"
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

    if not E.db[addonName].version then
        Addon.Installer:Show()
    end

    Addon.Automation:Initialize()
    Addon.EquipmentManager:Initialize()
    Addon.InventoryDatabase:Initialize()
    Addon.Layout:Initialize()
    Addon.Styling:Initialize()

    if Addon.isClassic then
        E.oUF.colors.class["SHAMAN"] = {0.0, 0.44, 0.87}
        _G.RAID_CLASS_COLORS["SHAMAN"] = {r = 0.0, g = 0.44, b = 0.87}
        if _G.CUSTOM_CLASS_COLORS then
            _G.CUSTOM_CLASS_COLORS["SHAMAN"] = {r = 0.0, g = 0.44, b = 0.87}
        end
    end

    if not Addon.isRetail then
        SetCVar("chatClassColorOverride", 0)
    end
end

function Addon:Update()
    Addon.Styling:Update()
end

function Addon:OnSettingChanged(setting)
    if setting[1] == "styling" then
        local styleConfigKey = setting[2] ~= "enabled" and setting[2]
        local onlyShadows = setting[3] and setting[3] == "shadow"
        local onlyBorders = setting[3] and setting[3] == "border"
        Addon.Styling:Update(styleConfigKey, onlyShadows, onlyBorders)
    elseif setting[1] == "layout" and setting[2] ~= "tooltips" then
        if setting[2] == "minimapButtonFrame" then
            if setting[3] == "enabled" then
                if not E.db[addonName].layout.minimapButtonFrame.enabled then
                    ReloadUI()
                else
                    Addon.Layout:CreateMinimapButtonFrame()
                end
            else
                Addon.Layout:UpdateMinimapButtonFrame()
            end
        else
            ReloadUI()
        end
    end
end

E:RegisterModule(Addon:GetName())
