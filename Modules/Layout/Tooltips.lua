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

-- TODO: fix this so it doesn't screw up the following lines
local function InsertLine(tooltip, position, line)
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
        lines[index] = {
            left = {text = tooltipLeft:GetText(), color = {lR, lG, lB}},
            right = {text = tooltipRight:GetText(), color = {rR, rG, rB}}
        }
    end

    if line.right then
        tooltip:AddDoubleLine(line.left.text, line.right.text, unpack(line.left.color or {1, 1, 1}),
                              unpack(line.right.color or {1, 1, 1}))
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
        tooltip:AddLine(L["Item Level"] .. " " .. itemLevel, unpack(E.db[addonName].layout.tooltips.colors.itemLevel))

        if TODO then
            InsertLine(tooltip, 2, {
                left = {text = L["Item Level"] .. " " .. itemLevel, color = E.db[addonName].layout.tooltips.colors.itemLevel},
                right = {}
            })
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
            if itemEquipLoc and itemEquipLoc ~= "" then
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
