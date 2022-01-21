local addonName, addonTable = ...
local Addon = addonTable[1]

if not Addon.isTbc then
    return
end

local Automation = Addon:NewModule(addonName .. "Automation.TBC", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Automation.TBC = Automation
local E, L, V, P, G = unpack(ElvUI)

local fastLootDelay = 0

function Automation:Initialize()
    Automation:RegisterEvent("UI_ERROR_MESSAGE")
    Automation:RegisterEvent("LOOT_READY")
end

function Automation:UI_ERROR_MESSAGE(event, errorType, msg)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.standDismount then
        if msg == SPELL_FAILED_NOT_STANDING or msg == ERR_CANTATTACK_NOTSTANDING or msg == ERR_LOOT_NOTSTANDING or msg ==
            ERR_TAXINOTSTANDING then
            DoEmote("stand")
            UIErrorsFrame:Clear()
        elseif msg == ERR_ATTACK_MOUNTED or msg == ERR_MOUNT_ALREADYMOUNTED or msg == ERR_NOT_WHILE_MOUNTED or msg ==
            ERR_TAXIPLAYERALREADYMOUNTED or msg == SPELL_FAILED_NOT_MOUNTED then
            if IsMounted() then
                Dismount()
                UIErrorsFrame:Clear()
            end
        end
    end
end

function Automation:LOOT_READY(event)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.fastLoot then
        if GetTime() - fastLootDelay >= 0.3 then
            fastLootDelay = GetTime()
            if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
                for i = GetNumLootItems(), 1, -1 do
                    LootSlot(i)
                end
                fastLootDelay = GetTime()
            end
        end
    end
end