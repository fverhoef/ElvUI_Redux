local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)

function Layout:LayoutInspectFrame()
    -- NOTE: ElvUI (mistakenly?) has a double backdrop for inspect talent frame
    if _G.InspectTalentFrame.backdrop then
        _G.InspectTalentFrame.backdrop:Hide()
    end

    _G.InspectTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.InspectTalentFrameScrollFrame:Size(301, 332)
    _G.InspectTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)

    for i = 1, 3 do
        local tab = _G["InspectTalentFrameTab" .. i]
        tab:SetHeight(28)
        if i == 1 then
            tab:SetPoint("TOPLEFT", 70, -48)
        end
    end
end