local addonName, addonTable = ...
local E, L, V, P, G = unpack(ElvUI) -- Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")

local Module = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.name = "Redux"
Module.title = "|cff76FF03" .. Module.name .. "|r"
Module.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Module.version = GetAddOnMetadata(addonName, "Version")

addonTable[1] = Module
_G[addonName] = Module

function Module:Initialize()
    EP:RegisterPlugin(Module.name, Module.InsertOptions)

    Module.Automation:Initialize()
    Module.InventoryDatabase:Initialize()
    Module.MinimapButtonFrame:Initialize()
    Module.Shadows:Initialize()
    Module.Tooltips:Initialize()
end

E:RegisterModule(Module:GetName())
