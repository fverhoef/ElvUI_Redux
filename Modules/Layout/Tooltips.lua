local addonName, addonTable = ...
local Addon = addonTable[1]
local Layout = Addon.Layout
local E, L, V, P, G = unpack(ElvUI)
local TT = E:GetModule("Tooltip")

function Layout:HookTooltips()
    Layout:HookSetItem(_G.GameTooltip)
    Layout:HookSetItem(_G.ItemRefTooltip)

    Layout:HookSetSpell(_G.GameTooltip)
    Layout:HookSetSpell(_G.ItemRefTooltip)

    Layout:SecureHook(TT, "GameTooltip_SetDefaultAnchor", function(self, tt, parent)
        Layout:GameTooltip_SetDefaultAnchor(tt, parent)
    end)
end

function Layout:GameTooltip_SetDefaultAnchor(tt, parent)
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

local function AddIcon(tooltip, icon)
    if not icon or not E.db[addonName].layout.tooltips.showIcons then
        return
    end

    local title = _G[tooltip:GetName() .. "TextLeft1"]
    if title and not title:GetText():find("|T" .. icon) then
        title:SetFormattedText("|T%s:20:20:0:0:64:64:5:59:5:59:%d|t %s", icon, 40, title:GetText())
    end
end

local function AddItemLevel(tooltip, itemLevel)
    if E.db[addonName].layout.tooltips.showItemLevel and itemLevel then

        local title = _G[tooltip:GetName() .. "TextLeft1"]
        if title and not title:GetText():find("Item Level") then
            title:SetFormattedText([[%s
%s]], title:GetText(), Addon:Hex(E.db[addonName].layout.tooltips.colors.itemLevel) .. L["Item Level "] .. itemLevel .. "|r")
        end
    end
end

local function AddVendorPrice(tooltip, sellPrice, classID)
    if E.db[addonName].layout.tooltips.showVendorPrice and not tooltip.shownMoneyFrames then
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

function Layout:HookSetItem(tip)
    tip:HookScript("OnTooltipSetItem", function(tooltip)
        if not E.db[addonName].layout.tooltips.enabled then
            return
        end

        local itemName, link = tooltip:GetItem()
        if link then
            local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc,
                  itemIcon, sellPrice, classID = GetItemInfo(link)
            AddIcon(tooltip, itemIcon)
            if not Addon.isRetail and itemEquipLoc and itemEquipLoc ~= "" then
                AddItemLevel(tooltip, itemLevel)
            end
            AddVendorPrice(tooltip, sellPrice, classID)

            tooltip:Show()
        end
    end)
end

function Layout:HookSetSpell(tip)
    tip:HookScript("OnTooltipSetSpell", function(tooltip)
        if not E.db[addonName].layout.tooltips.enabled then
            return
        end

        local spellName, spellId = tooltip:GetSpell()
        if spellName then
            local icon = select(3, GetSpellInfo(spellId))
            AddIcon(tooltip, icon)
            tooltip:Show()
        end
    end)
end
