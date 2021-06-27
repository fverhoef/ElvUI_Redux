local addonName, addonTable = ...
local Addon = addonTable[1]
local Layout = Addon.Layout
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

function Layout:LayoutTradeSkillFrame()
    if not E.db[addonName].layout.tradeSkillFrame.enabled then
        return
    end

    local width, height = 714, 487
    _G.UIPanelWindows["TradeSkillFrame"].width = width
    _G.UIPanelWindows["TradeSkillFrame"].height = height
    _G.TradeSkillFrame:SetSize(width, height)
    _G.TradeSkillFrame.backdrop:Point("BOTTOMRIGHT", -32, 46)

    -- Expand the tradeskill list to full height
    _G.TradeSkillListScrollFrame:ClearAllPoints()
    _G.TradeSkillListScrollFrame:SetPoint("TOPLEFT", _G.TradeSkillFrame, "TOPLEFT", 25, -75)
    _G.TradeSkillListScrollFrame:SetSize(295, 360)

    -- Create additional list rows
    local oldTradeSkillsDisplayed = _G.TRADE_SKILLS_DISPLAYED

    -- Position existing buttons
    for i = 1 + 1, _G.TRADE_SKILLS_DISPLAYED do
        _G["TradeSkillSkill" .. i]:ClearAllPoints()
        _G["TradeSkillSkill" .. i]:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
    end

    -- Create and position new buttons
    _G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
    for i = oldTradeSkillsDisplayed + 1, _G.TRADE_SKILLS_DISPLAYED do
        local button = CreateFrame("Button", "TradeSkillSkill" .. i, _G.TradeSkillFrame, "TradeSkillSkillButtonTemplate")
        button:SetID(i)
        button:Hide()
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)

        -- apply ElvUI styling
        local highlight = _G["TradeSkillSkill" .. i .. "Highlight"]

        button:GetNormalTexture():Size(14)
        button:GetNormalTexture():SetPoint("LEFT", 2, 1)

        highlight:SetTexture("")
        highlight.SetTexture = E.noop
    end

    -- Set highlight bar width when shown
    Layout:SecureHook(_G.TradeSkillHighlightFrame, "Show", function()
        _G.TradeSkillHighlightFrame:SetWidth(290)
    end)

    -- Move the tradeskill detail frame to the right and stretch it to full height
    _G.TradeSkillDetailScrollFrame:ClearAllPoints()
    _G.TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", _G.TradeSkillListScrollFrame, "TOPRIGHT", 31, 0)
    _G.TradeSkillDetailScrollFrame:SetPoint("BOTTOMLEFT", _G.TradeSkillListScrollFrame, "BOTTOMRIGHT", 31, 0)

    -- Move create button row
    _G.TradeSkillCreateButton:ClearAllPoints()
    _G.TradeSkillCreateButton:SetPoint("RIGHT", _G.TradeSkillCancelButton, "LEFT", -1, 0)

    -- Position and size close button
    _G.TradeSkillCancelButton:SetSize(80, 22)
    _G.TradeSkillCancelButton:ClearAllPoints()
    _G.TradeSkillCancelButton:SetPoint("BOTTOMRIGHT", _G.TradeSkillFrame, "BOTTOMRIGHT", -36, 49)

    -- Position window close button
    _G.TradeSkillFrameCloseButton:ClearAllPoints()
    _G.TradeSkillFrameCloseButton:SetPoint("TOPRIGHT", _G.TradeSkillFrame, "TOPRIGHT", -30, -8)

    -- Reposition status bar
    _G.TradeSkillRankFrame:ClearAllPoints()
    _G.TradeSkillRankFrame:Point("TOPRIGHT", -40, -45)

    -- Position dropdown menus
    _G.TradeSkillInvSlotDropDown:ClearAllPoints()
    _G.TradeSkillInvSlotDropDown:SetPoint("TOPLEFT", _G.TradeSkillFrame, "TOPLEFT", 0, -40)
    _G.TradeSkillInvSlotDropDown:Width(185)
    _G.TradeSkillSubClassDropDown:ClearAllPoints()
    _G.TradeSkillSubClassDropDown:SetPoint("LEFT", _G.TradeSkillInvSlotDropDown, "RIGHT", -20, 0)
    _G.TradeSkillSubClassDropDown:Width(185)
end
