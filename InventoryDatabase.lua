local addonName, addonTable = ...
local Module = addonTable[1]
local InventoryDatabase = Module:NewModule(addonName .. "InventoryDatabase", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.InventoryDatabase = InventoryDatabase
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")

function InventoryDatabase:Initialize()
    InventoryDatabase:RegisterEvent("BAG_SLOT_FLAGS_UPDATED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("BAG_UPDATE", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("BAG_UPDATE_COOLDOWN", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("BAG_NEW_ITEMS_UPDATED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("QUEST_ACCEPTED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("QUEST_REMOVED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("PLAYER_MONEY", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("PLAYER_TRADE_MONEY", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("BANKFRAME_OPENED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("BANKFRAME_CLOSED", InventoryDatabase.Update)
    InventoryDatabase:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED", InventoryDatabase.Update)
    InventoryDatabase:Update()
end

function InventoryDatabase:Update()
    local db = InventoryDatabase:GetCharacterDatabase()
    db.money = GetMoney()

    db.equipped = {}
    local slots = {
        "HeadSlot",
        "NeckSlot",
        "ShoulderSlot",
        "BackSlot",
        "ChestSlot",
        "ShirtSlot",
        "TabardSlot",
        "WristSlot",
        "HandsSlot",
        "WaistSlot",
        "LegsSlot",
        "FeetSlot",
        "Finger0Slot",
        "Finger1Slot",
        "Trinket0Slot",
        "Trinket1Slot",
        "MainHandSlot",
        "SecondaryHandSlot"
    }

    if Module.isClassic then
        table.insert(slots, "RangedSlot")
    end

    for i, slot in next, slots do
        local link = GetInventoryItemLink("player", GetInventorySlotInfo(slot))
        if link then
            local itemId = Module:GetItemIdFromLink(link)
            if itemId then
                db.equipped["" .. itemId] = 1
            end
        end
    end

    db.bags = {}
    InventoryDatabase:StoreContainerContents(db, false)
    InventoryDatabase:StoreContainerContents(db, true)
end

function InventoryDatabase:GetCharacterDatabase()
    ElvDB = ElvDB or {}
    ElvDB.items = ElvDB.items or {}
    ElvDB.items.realm = ElvDB.items.realm or {}
    ElvDB.items.realm[E.myrealm] = ElvDB.items.realm[E.myrealm] or {}
    ElvDB.items.realm[E.myrealm].character = ElvDB.items.realm[E.myrealm].character or {}
    ElvDB.items.realm[E.myrealm].character[E.myname] = ElvDB.items.realm[E.myrealm].character[E.myname] or {}

    local db = ElvDB.items.realm[E.myrealm].character[E.myname]
    db.class = E.myclass
    db.bags = db.bags or {}
    db.bank = db.bank or {}
    db.equipped = db.equipped or {}

    return db
end

function InventoryDatabase:UpdateItemCount(itemId, db)
    if not itemId then
        return
    end
    db = db or InventoryDatabase:GetCharacterDatabase()

    local equippedCount = db.equipped["" .. itemId] or 0
    local inventoryCount = GetItemCount(itemId, false) - equippedCount
    local allCount = GetItemCount(itemId, true) - equippedCount
    local bankCount = allCount - inventoryCount

    db.bags["" .. itemId] = inventoryCount
    db.bank["" .. itemId] = bankCount
end

function InventoryDatabase:StoreContainerContents(db, isBank)
    local f = B:GetContainerFrame(isBank)
    if not f then
        return
    end

    for i, bagID in ipairs(f.BagIDs) do
        local numSlots = GetContainerNumSlots(bagID)
        for slotID = 1, numSlots do
            local itemId = select(10, GetContainerItemInfo(bagID, slotID))
            InventoryDatabase:UpdateItemCount(itemId, db)
        end
    end
end
