local addonName, addonTable = ...
local Addon = addonTable[1]
local EquipmentManager = Addon:NewModule(addonName .. "EquipmentManager", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.EquipmentManager = EquipmentManager
local E, L, V, P, G = unpack(ElvUI)

function EquipmentManager:Initialize()
end

function EquipmentManager:Update()
end
