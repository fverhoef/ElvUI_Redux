local addonName, addonTable = ...
local Module = addonTable[1]
local Tooltips = Module:NewModule(addonName .. "Tooltips", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Module.Tooltips = Tooltips
local E, L, V, P, G = unpack(ElvUI)

function Tooltips:Initialize()
    Tooltips:HookSetItem(_G.GameTooltip)
    Tooltips:HookSetItem(_G.ItemRefTooltip)

    Tooltips:HookSetSpell(_G.GameTooltip)
    Tooltips:HookSetSpell(_G.ItemRefTooltip)

    ElvDB.items = ElvDB.items or {}
    ElvDB.items[E.myrealm] = ElvDB.items[E.myrealm] or {}

    if E.db[addonName].tooltips.showItemCount then
        -- disable built-in item counts
        E.db.tooltip.itemCount = "NONE"
    end
end

function Tooltips:HookSetItem(tip)
    tip:HookScript("OnTooltipSetItem", function(tooltip)
        if not E.db[addonName].tooltips.enabled then
            return
        end

        local itemName, link = tooltip:GetItem()
        if link then
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, sellPrice, classID = GetItemInfo(link)
            Tooltips:AddIcon(tooltip, itemIcon)
            if itemEquipLoc and itemEquipLoc ~= "" then
                Tooltips:AddItemLevel(tooltip, itemLevel)
            end
            Tooltips:AddVendorPrice(tooltip, sellPrice, classID)

            local itemId = Module:GetItemIdFromLink(itemLink)
            if itemId then
                Tooltips:AddItemCount(tooltip, itemId)
            end

            tooltip:Show()
        end
    end)
end

function Tooltips:HookSetSpell(tip)
    tip:HookScript("OnTooltipSetSpell", function(tooltip)
        if not E.db[addonName].tooltips.enabled then
            return
        end

        local spellName, spellId = tooltip:GetSpell()
        if spellName then
            local icon = select(3, GetSpellInfo(spellId))
            Tooltips:AddIcon(tooltip, icon)
            tooltip:Show()
        end
    end)
end

function Tooltips:AddIcon(tooltip, icon)
    if not icon or not E.db[addonName].tooltips.showIcons then
        return
    end

    local title = _G[tooltip:GetName() .. "TextLeft1"]
    if title and not title:GetText():find("|T" .. icon) then
        title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 40, title:GetText())
    end
end

function Tooltips:AddItemCount(tooltip, itemId)
    if not itemId or not E.db[addonName].tooltips.showItemCount then
        return
    end
    if not ElvDB or not ElvDB.items or not ElvDB.items.realm or not ElvDB.items.realm[E.myrealm] then
        return
    end

    if Module.InventoryDatabase then
        Module.InventoryDatabase:UpdateItemCount(itemId)
    end

    local characterDatabase = ElvDB.items.realm[E.myrealm].character
    for name, char in next, characterDatabase do
        local bagCount = char.bags and char.bags[itemId] or 0
        local bankCount = char.bank and char.bank[itemId] or 0
        local equippedCount = char.equipped and char.equipped[itemId] or 0
        if bagCount > 0 or bankCount > 0 or equippedCount > 0 then
            local value = ""
            if equippedCount > 0 then
                value = L["Equipped"] .. ": " .. equippedCount
            end
            if bagCount > 0 then
                if value ~= "" then
                    value = value .. " | "
                end
                value = value .. L["Bags"] .. ": " .. bagCount
            end
            if bankCount > 0 then
                if value ~= "" then
                    value = value .. " | "
                end
                value = value .. L["Bank"] .. ": " .. bankCount
            end

            tooltip:AddDoubleLine(Module:Hex(RAID_CLASS_COLORS[char.class or "PRIEST"]) .. name .. "|r:", value)
        end
    end
end

function Tooltips:AddItemLevel(tooltip, itemLevel)
    if E.db[addonName].tooltips.showItemLevel then
        Tooltips:InsertLine(tooltip, 2, {left = {text = L["Item Level"] .. " " .. itemLevel, color = E.db[addonName].tooltips.colors.itemLevel}, right = {}})
    end
end

function Tooltips:AddVendorPrice(tooltip, sellPrice, classID)
    if E.db[addonName].tooltips.showVendorPrice and not tooltip.shownMoneyFrames then
        if sellPrice and sellPrice > 0 then
            local container = GetMouseFocus()
            if not container then
                return
            end
            local count = container and type(container.count) == "number" and container.count or 1
            if sellPrice and count > 0 then
                if classID and classID == 11 then
                    count = 1
                end -- Fix for quiver/ammo pouch so ammo is not included
                SetTooltipMoney(tooltip, sellPrice * count, "STATIC", SELL_PRICE .. ":")
            end
        end
    end
end

function Tooltips:InsertLine(tooltip, position, line)
    local name = tooltip:GetName()
    local lines = {}
    local numLines = tooltip:NumLines()
    for i = 1, numLines do
        local tooltipLeft = _G[name .. "TextLeft" .. i]
        local tooltipRight = _G[name .. "TextRight" .. i]
        local lR, lG, lB = tooltipLeft:GetTextColor()
        local rR, rG, rB = tooltipRight:GetTextColor()

        local index = #lines + 1

        if index == position then
            lines[index] = line
            index = index + 1
        end
        lines[index] = {left = {text = tooltipLeft:GetText(), color = {lR, lG, lB}}, right = {text = tooltipRight:GetText(), color = {rR, rG, rB}}}
    end

    if line.right then
        tooltip:AddDoubleLine(line.left.text, line.right.text, unpack(line.left.color or {1, 1, 1}), unpack(line.right.color or {1, 1, 1}))
    else
        tooltip:AddLine(line.left.text, unpack(line.left.color))
    end

    for i, currentLine in next, lines do
        if currentLine.left then
            local tooltipLeft = _G[name .. "TextLeft" .. i]
            tooltipLeft:SetText(currentLine.left.text or "")
            if currentLine.left.color then
                tooltipLeft:SetTextColor(unpack(currentLine.left.color or {1, 1, 1}))
            end
            tooltipLeft:Show()
        end
        if currentLine.right then
            local tooltipRight = _G[name .. "TextRight" .. i]
            tooltipRight:SetText(currentLine.right.text or "")
            if currentLine.right.color then
                tooltipRight:SetTextColor(unpack(currentLine.right.color or {1, 1, 1}))
            end
            tooltipRight:Show()
        end
    end
end
