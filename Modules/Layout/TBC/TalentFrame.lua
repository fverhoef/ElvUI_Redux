local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)

function Layout:LayoutTalentFrame()
    _G.PlayerTalentFrameScrollFrame:Point("TOPRIGHT", -60, -77)
    _G.PlayerTalentFrameScrollFrame:Size(301, 332)
    _G.PlayerTalentFrameScrollFrameScrollBar:Point("TOPLEFT", _G.PlayerTalentFrameScrollFrame, "TOPRIGHT", 2, -16)

	for i = 1, _G.MAX_NUM_TALENTS do
		local talent = _G["PlayerTalentFrameTalent" .. i]
		local rank = _G["PlayerTalentFrameTalent" .. i .. "Rank"]

		if talent then
            local border = talent:GetBorder()
            if border then
                rank:SetParent(border)
            end
		end
	end
end