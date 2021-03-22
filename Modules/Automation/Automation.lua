local addonName, addonTable = ...
local Addon = addonTable[1]
local Automation = Addon:NewModule(addonName .. "Automation", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Automation = Automation
local E, L, V, P, G = unpack(ElvUI)

local fastLootDelay = 0

function Automation:Initialize()
    Automation:RegisterEvent("UI_ERROR_MESSAGE")
    Automation:RegisterEvent("LOOT_READY")
    Automation:RegisterEvent("RESURRECT_REQUEST")
    Automation:RegisterEvent("CONFIRM_SUMMON")
    Automation:RegisterEvent("CONFIRM_LOOT_ROLL")
    Automation:RegisterEvent("LOOT_BIND_CONFIRM")
    Automation:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
    Automation:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
    Automation:RegisterEvent("CHAT_MSG_WHISPER")
    Automation:RegisterEvent("CHAT_MSG_BN_WHISPER")
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

function Automation:RESURRECT_REQUEST(event, inviter)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.acceptResurrection then
        Automation:AcceptResurrection(inviter)
    end
end

function Automation:CONFIRM_SUMMON(event)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.acceptSummon then
        Automation:AcceptSummon()
    end
end

function Automation:CONFIRM_LOOT_ROLL(event, rollID, rollType, confirmReason)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.disableLootRollConfirmation then
        ConfirmLootRoll(rollID, rollType)
        StaticPopup_Hide("CONFIRM_LOOT_ROLL")
    end
end

function Automation:LOOT_BIND_CONFIRM(event, lootSlot)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.disableLootBindConfirmation then
        ConfirmLootSlot(lootSlot)
        StaticPopup_Hide("LOOT_BIND")
    end
end

function Automation:MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL(event)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.disableVendorRefundWarning then
        SellCursorItem()
    end
end

function Automation:MAIL_LOCK_SEND_ITEMS(event, attachSlot, itemLink)
    if E.db[addonName].automation.enabled and E.db[addonName].automation.disableMailRefundWarning then
        RespondMailLockSendItem(attachSlot, true)
    end
end

function Automation:CHAT_MSG_WHISPER(event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID,
                                     channelIndex, channelBaseName, unused, lineID, guid, bnSenderID, isMobile, isSubtitle,
                                     hideSenderInLetterbox, supressRaidIcons)
    if not E.db[addonName].automation.enabled or not E.db[addonName].automation.autoInvite then
        return
    end

    if Automation:PlayerCanInvite() and Automation:TextMatchesAutoInvitePassword(text) then
        InviteUnit(playerName)
    end
end

function Automation:CHAT_MSG_BN_WHISPER(event, text, playerName, languageName, channelName, playerName2, specialFlags,
                                        zoneChannelID, channelIndex, channelBaseName, unused, lineID, guid, bnSenderID, isMobile,
                                        isSubtitle, hideSenderInLetterbox, supressRaidIcons)
    if not E.db[addonName].automation.enabled or not E.db[addonName].automation.autoInvite then
        return
    end

    if Automation:PlayerCanInvite() and Automation:TextMatchesAutoInvitePassword(text) then
        if bnSenderID and BNIsFriend(bnSenderID) then
            local index = BNGetFriendIndex(bnSenderID)
            if index then
                local toonID = select(6, BNGetFriendInfo(index))
                if toonID then
                    BNInviteFriend(toonID)
                end
            end
        end
    end
end

function Automation:PlayerCanInvite()
    return not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")
end

function Automation:TextMatchesAutoInvitePassword(text)
    return string.lower(string.trim(text)) == string.lower(E.db[addonName].automation.autoInvitePassword)
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
