local addonName, addonTable = ...
local Addon = addonTable[1]
local Automation = Addon:NewModule(addonName .. "Automation", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Automation = Automation
local E, L, V, P, G = unpack(ElvUI)

local fastLootDelay = 0

function Automation:Initialize()
    Automation:RegisterEvents()
end

function Automation:RegisterEvents()
    -- Auto stand/dismount
    Automation:RegisterEvent("UI_ERROR_MESSAGE", function(event, messageType, msg)
        if E.db[addonName].automation.enabled and E.db[addonName].automation.standDismount then
            if msg == SPELL_FAILED_NOT_STANDING or msg == ERR_CANTATTACK_NOTSTANDING or msg == ERR_LOOT_NOTSTANDING or msg == ERR_TAXINOTSTANDING then
                DoEmote("stand")
                UIErrorsFrame:Clear()
            elseif msg == ERR_ATTACK_MOUNTED or msg == ERR_MOUNT_ALREADYMOUNTED or msg == ERR_NOT_WHILE_MOUNTED or msg == ERR_TAXIPLAYERALREADYMOUNTED or msg ==
                SPELL_FAILED_NOT_MOUNTED then
                if IsMounted() then
                    Dismount()
                    UIErrorsFrame:Clear()
                end
            end
        end
    end)

    -- Fast loot
    Automation:RegisterEvent("LOOT_READY", function()
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
    end)

    Automation:RegisterEvent("RESURRECT_REQUEST", function(unit)
        if E.db[addonName].automation.enabled and E.db[addonName].automation.acceptResurrection then
            Automation:AcceptResurrection(unit)
        end
    end)

    Automation:RegisterEvent("CONFIRM_SUMMON", function()
        if E.db[addonName].automation.enabled and E.db[addonName].automation.acceptSummon then
            Automation:AcceptSummon()
        end
    end)

    Automation:RegisterEvent("CONFIRM_LOOT_ROLL", function(event, arg1, arg2)
        if E.db[addonName].automation.enabled and E.db[addonName].automation.disableLootRollConfirmation then
            ConfirmLootRoll(arg1, arg2)
            StaticPopup_Hide("CONFIRM_LOOT_ROLL")
        end
    end)

    Automation:RegisterEvent("LOOT_BIND_CONFIRM", function(event, arg1, arg2, ...)
        if E.db[addonName].automation.enabled and E.db[addonName].automation.disableLootBindConfirmation then
            ConfirmLootSlot(arg1, arg2)
            StaticPopup_Hide("LOOT_BIND", ...)
        end
    end)

    Automation:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL", function()
        if E.db[addonName].automation.enabled and E.db[addonName].automation.disableVendorRefundWarning then
            SellCursorItem()
        end
    end)

    Automation:RegisterEvent("MAIL_LOCK_SEND_ITEMS", function(event, arg1)
        if E.db[addonName].automation.enabled and E.db[addonName].automation.disableMailRefundWarning then
            RespondMailLockSendItem(arg1, true)
        end
    end)
end

function Automation:AcceptSummon()
    if not UnitAffectingCombat("player") then
        local summoner = GetSummonConfirmSummoner()
        local summonArea = GetSummonConfirmAreaName()
        Addon:Print("Accepting summons from " .. summoner .. " to " .. summonArea .. " in 10 seconds.")
        C_Timer.After(10, function()
            local newSummoner = GetSummonConfirmSummoner()
            local newSummonArea = GetSummonConfirmAreaName()
            if summoner == newSummoner and summonArea == newSummonArea then
                -- Automatically accept summon after 10 seconds if summoner name and location have not changed
                C_SummonInfo.ConfirmSummon()
                StaticPopup_Hide("CONFIRM_SUMMON")
            end
        end)
    end
end

function Automation:AcceptResurrection(unit)
    -- TODO: Exclude Chained Spirit (Zul'Gurub)
    if unit == L["Chained Spirit"] then
        return
    end

    local delay = GetCorpseRecoveryDelay()
    if delay and delay > 0 then
        C_Timer.After(delay + 1, function()
            if not UnitAffectingCombat(unit) then
                AcceptResurrect()
            end
        end)
    else
        if not UnitAffectingCombat(unit) then
            AcceptResurrect()
        end
    end
end
