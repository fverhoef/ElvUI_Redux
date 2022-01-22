local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

function Layout:LayoutClassTrainerFrame()
    if not E.db[addonName].layout.classTrainerFrame.enabled then
        return
    end

    local width, height = 714, 487
    _G.UIPanelWindows["ClassTrainerFrame"].width = width
    _G.UIPanelWindows["ClassTrainerFrame"].height = height
    _G.ClassTrainerFrame:SetSize(width, height)

    -- Expand the skill list to full height
    _G.ClassTrainerListScrollFrame:ClearAllPoints()
    _G.ClassTrainerListScrollFrame:SetPoint("TOPLEFT", _G.ClassTrainerFrame, "TOPLEFT", 25, -75)
    _G.ClassTrainerListScrollFrame:SetSize(295, 336)

    -- Create additional list rows
    local oldSkillsDisplayed = _G.CLASS_TRAINER_SKILLS_DISPLAYED

    -- Position existing buttons
    for i = 1 + 1, _G.CLASS_TRAINER_SKILLS_DISPLAYED do
        _G["ClassTrainerSkill" .. i]:ClearAllPoints()
        _G["ClassTrainerSkill" .. i]:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
    end

    -- Create and position new buttons
    _G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 12
    for i = oldSkillsDisplayed + 1, CLASS_TRAINER_SKILLS_DISPLAYED do
        local button = CreateFrame("Button", "ClassTrainerSkill" .. i, _G.ClassTrainerFrame, "ClassTrainerSkillButtonTemplate")
        button:SetID(i)
        button:Hide()
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)

        -- apply ElvUI styling
        button:GetNormalTexture():Size(14)
        button:GetNormalTexture():SetPoint("LEFT", 2, 1)

        local highlight = _G["TradeSkillSkill" .. i .. "Highlight"]
        if highlight then
            highlight:SetTexture("")
            highlight.SetTexture = E.noop
        end
    end

    Layout:SecureHook("ClassTrainer_SetToTradeSkillTrainer", function()
        _G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 12
        _G.ClassTrainerListScrollFrame:SetHeight(336)
        _G.ClassTrainerDetailScrollFrame:SetHeight(336)
    end)

    Layout:SecureHook("ClassTrainer_SetToClassTrainer", function()
        _G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 11
        _G.ClassTrainerListScrollFrame:SetHeight(336)
        _G.ClassTrainerDetailScrollFrame:SetHeight(336)
    end)

    -- Set highlight bar width when shown
    S:SecureHook(_G.ClassTrainerSkillHighlightFrame, "Show", function()
        _G.ClassTrainerSkillHighlightFrame:SetWidth(290)
    end)

    -- Move the detail frame to the right and stretch it to full height
    _G.ClassTrainerDetailScrollFrame:ClearAllPoints()
    _G.ClassTrainerDetailScrollFrame:SetPoint("TOPLEFT", _G.ClassTrainerFrame, "TOPLEFT", 352, -74)
    _G.ClassTrainerDetailScrollFrame:SetSize(296, 336)
    -- _G["ClassTrainerSkillIcon"]:SetHeight(500) -- Debug

    -- Hide detail scroll frame textures
    _G.ClassTrainerDetailScrollFrameTop:SetAlpha(0)
    _G.ClassTrainerDetailScrollFrameBottom:SetAlpha(0)

    -- Hide expand tab (left of All button)
    _G.ClassTrainerExpandTabLeft:Hide()

    -- Move bottom button row
    _G.ClassTrainerTrainButton:ClearAllPoints()
    _G.ClassTrainerTrainButton:SetPoint("RIGHT", _G.ClassTrainerCancelButton, "LEFT", -1, 0)

    -- Position and size close button
    _G.ClassTrainerCancelButton:SetSize(80, 22)
    _G.ClassTrainerCancelButton:SetText(CLOSE)
    _G.ClassTrainerCancelButton:ClearAllPoints()
    _G.ClassTrainerCancelButton:SetPoint("BOTTOMRIGHT", _G.ClassTrainerFrame, "BOTTOMRIGHT", -42, 54)

    -- Position close box
    _G.ClassTrainerFrameCloseButton:ClearAllPoints()
    _G.ClassTrainerFrameCloseButton:SetPoint("TOPRIGHT", _G.ClassTrainerFrame, "TOPRIGHT", -30, -8)

    -- Position dropdown menus
    _G.ClassTrainerFrameFilterDropDown:ClearAllPoints()
    _G.ClassTrainerFrameFilterDropDown:SetPoint("TOPLEFT", _G.ClassTrainerFrame, "TOPLEFT", 501, -40)

    -- Position money frame
    _G.ClassTrainerMoneyFrame:ClearAllPoints()
    _G.ClassTrainerMoneyFrame:SetPoint("TOPLEFT", _G.ClassTrainerFrame, "TOPLEFT", 143, -49)
    _G.ClassTrainerGreetingText:Hide()
end
