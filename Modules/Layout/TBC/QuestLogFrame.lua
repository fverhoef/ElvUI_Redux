local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

function Layout:LayoutQuestLogFrame()
    if not E.db[addonName].layout.questLogFrame.enabled then
        return
    end

    -- Resize quest log
    local width, height = 714, 487
    _G.UIPanelWindows["QuestLogFrame"].width = width
    _G.UIPanelWindows["QuestLogFrame"].height = height
    _G.QuestLogFrame:SetSize(width, height)

    -- Move the detail frame to the right and stretch it to full height
    _G.QuestLogDetailScrollFrame:ClearAllPoints()
    _G.QuestLogDetailScrollFrame:SetPoint("TOPLEFT", _G.QuestLogListScrollFrame, "TOPRIGHT", 31, 0)
    _G.QuestLogDetailScrollFrame:SetPoint("BOTTOMLEFT", _G.QuestLogListScrollFrame, "BOTTOMRIGHT", 31, 0)

    -- Expand the quest list to full height
    _G.QuestLogListScrollFrame:SetHeight(336)

    -- Create additional quest rows
    local oldQuestsDisplayed = _G.QUESTS_DISPLAYED
    _G.QUESTS_DISPLAYED = _G.QUESTS_DISPLAYED + 16
    for i = oldQuestsDisplayed + 1, _G.QUESTS_DISPLAYED do
        local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")
        button:SetID(i)
        button:Hide()
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i - 1)], "BOTTOMLEFT", 0, 1)
    end

    -- Position and resize abandon button
    _G.QuestLogFrameAbandonButton:Width(106)
    _G.QuestLogFrameAbandonButton:ClearAllPoints()
    _G.QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", _G.QuestLogFrame, "BOTTOMLEFT", 15, 49)

    -- Position and resize share button
    _G.QuestFramePushQuestButton:Width(106)
    _G.QuestFramePushQuestButton:ClearAllPoints()
    _G.QuestFramePushQuestButton:SetPoint("LEFT", _G.QuestLogFrameAbandonButton, "RIGHT", 5, 0)

    -- Add map button
    local showMapButton = CreateFrame("Button", nil, _G.QuestLogFrame, "UIPanelButtonTemplate")
    showMapButton:SetText(_G.SHOW_MAP)
    showMapButton:ClearAllPoints()
    showMapButton:SetPoint("LEFT", _G.QuestFramePushQuestButton, "RIGHT", 5, 0)
    showMapButton:SetSize(106, 21)
    showMapButton:SetScript("OnClick", _G.ToggleWorldMap)
    S:HandleButton(showMapButton)

    -- Position and size close button
    _G.QuestFrameExitButton:Width(106)
    _G.QuestFrameExitButton:ClearAllPoints()
    _G.QuestFrameExitButton:SetPoint("BOTTOMRIGHT", _G.QuestLogFrame, "BOTTOMRIGHT", -36, 49)

    -- Empty quest frame
    _G.QuestLogNoQuestsText:ClearAllPoints()
    _G.QuestLogNoQuestsText:SetPoint("TOP", _G.QuestLogListScrollFrame, 0, -50)
    hooksecurefunc(_G.EmptyQuestLogFrame, "Show", function()
        _G.EmptyQuestLogFrame:ClearAllPoints()
        _G.EmptyQuestLogFrame:SetPoint("BOTTOMLEFT", _G.QuestLogFrame, "BOTTOMLEFT", 20, -76)
        _G.EmptyQuestLogFrame:SetHeight(487)
    end)

    -- Show quest levels
    Layout:SecureHook("QuestLog_Update", Layout.UpdateQuestLogEntries)
    -- TODO: update levels and check mark positions on load
end

function Layout:UpdateQuestLogEntries()
    local numEntries, numQuests = GetNumQuestLogEntries()
    if numEntries == 0 then
        return
    end
    for i = 1, _G.QUESTS_DISPLAYED do
        local questIndex = i + FauxScrollFrame_GetOffset(_G.QuestLogListScrollFrame)
        if questIndex <= numEntries then
            local questLogTitle = _G["QuestLogTitle" .. i]
            local questCheck = _G["QuestLogTitle" .. i .. "Check"]
            local title, level, suggestedGroup, isHeader = GetQuestLogTitle(questIndex)
            if title and level and not isHeader then
                local questTextFormatted = string.format("  [%d] %s", level, title)
                questLogTitle:SetText(questTextFormatted)
                QuestLogDummyText:SetText(questTextFormatted)
            end

            -- adjust check mark position
            local checkText = _G["QuestLogTitle" .. i .. "NormalText"]
            if checkText then
                local checkPos = checkText:GetStringWidth()
                if checkPos then
                    if checkPos <= 210 then
                        questCheck:SetPoint("LEFT", questLogTitle, "LEFT", checkPos + 24, 0)
                    else
                        questCheck:SetPoint("LEFT", questLogTitle, "LEFT", 210, 0)
                    end
                end
            end
        end
    end
end