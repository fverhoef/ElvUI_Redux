local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)
local B = E:GetModule("Bags")

function Layout:LayoutBags()
    B.BagFrame.title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.title:FontTemplate()
    B.BagFrame.title:Point("TOPLEFT", B.BagFrame, "TOPLEFT", 15, -8)
    B.BagFrame.title:SetText(_G.INVENTORY_TOOLTIP)
end