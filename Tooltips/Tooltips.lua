local addonName, addonTable = ...
local Addon = addonTable[1]
local E, L, V, P, G = unpack(ElvUI)
local TT = E:GetModule("Tooltip")

function Addon:HookTooltips()
    Addon:HookSetItem(_G.GameTooltip)
    Addon:HookSetItem(_G.ItemRefTooltip)

    Addon:HookSetSpell(_G.GameTooltip)
    Addon:HookSetSpell(_G.ItemRefTooltip)

    Addon:SecureHook(TT, "GameTooltip_SetDefaultAnchor", function(self, tt, parent)
        Addon:GameTooltip_SetDefaultAnchor(tt, parent)
    end)
end

function Addon:GameTooltip_SetDefaultAnchor(tt, parent)
    if tt.StatusBar and TT.db.healthBar.statusPosition ~= "DISABLED" then
        if TT.db.healthBar.statusPosition == "BOTTOM" then
            tt.StatusBar:ClearAllPoints()
            tt.StatusBar:Point("BOTTOMLEFT", tt, "BOTTOMLEFT", 2, 2)
            tt.StatusBar:Point("BOTTOMRIGHT", tt, "BOTTOMRIGHT", -2, 2)
        else
            tt.StatusBar:ClearAllPoints()
            tt.StatusBar:Point("TOPLEFT", tt, "TOPLEFT", 2, -2)
            tt.StatusBar:Point("TOPRIGHT", tt, "TOPRIGHT", -2, -2)
        end
    end
end

function Addon:HookSetItem(tip)
    tip:HookScript("OnTooltipSetItem", function(tooltip)
        if not E.db[addonName].tooltips.enabled then
            return
        end

        local itemName, link = tooltip:GetItem()
        if link then
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc,
                  itemIcon, sellPrice, classID = GetItemInfo(link)
            Addon:AddIcon(tooltip, itemIcon)
            if itemEquipLoc and itemEquipLoc ~= "" then
                Addon:AddItemLevel(tooltip, itemLevel)
            end
            Addon:AddVendorPrice(tooltip, sellPrice, classID)

            tooltip:Show()
        end
    end)
end

function Addon:HookSetSpell(tip)
    tip:HookScript("OnTooltipSetSpell", function(tooltip)
        if not E.db[addonName].tooltips.enabled then
            return
        end

        local spellName, spellId = tooltip:GetSpell()
        if spellName then
            local icon = select(3, GetSpellInfo(spellId))
            Addon:AddIcon(tooltip, icon)
            tooltip:Show()
        end
    end)
end

function Addon:AddIcon(tooltip, icon)
    if not icon or not E.db[addonName].tooltips.showIcons then
        return
    end

    local title = _G[tooltip:GetName() .. "TextLeft1"]
    if title and not title:GetText():find("|T" .. icon) then
        title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 40, title:GetText())
    end
end

function Addon:AddItemLevel(tooltip, itemLevel)
    if E.db[addonName].tooltips.showItemLevel and itemLevel then
        tooltip:AddLine(L["Item Level"] .. " " .. itemLevel, unpack(E.db[addonName].tooltips.colors.itemLevel))
    end
end

function Addon:AddVendorPrice(tooltip, sellPrice, classID)
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
