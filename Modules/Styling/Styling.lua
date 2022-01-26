local addonName, addonTable = ...
local Addon = addonTable[1]
local Styling = Addon:NewModule(addonName .. "Styling", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
Addon.Styling = Styling
local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")
local AFK = E:GetModule("AFK")
local B = E:GetModule("Bags")
local LO = E:GetModule("Layout")

function Styling:Initialize()
    for frame in pairs(E.frames) do
        if not Addon.templatedFrames[frame] then
            frame:RefreshTemplate()
        end
    end

    for frame in pairs(E.unitFrameElements) do
        if not Addon.templatedFrames[frame] then
            frame:RefreshTemplate()
        end
    end

    Styling:SkinDecorativePanels()
    Styling:SkinMinimap()
    Styling:SkinSpellbook()
    
    Styling:Update()

    if Addon.Styling.TBC then
        Addon.Styling.TBC:Initialize()
    end
end

function Styling:Update(styleConfigKey, onlyShadows, onlyBorders, onlyInlays)
    if UnitAffectingCombat("player") then
        Styling:ScheduleTimer("Update", 1)
        return
    end

    local shadowPerButton = E.db[addonName].styling.default.shadow.shadowPerButton
    for i = 1, 10 do
        local bar = AB.handledBars["bar" .. i]
        if bar then
            local shadow = bar:GetShadow()
            if shadow then
                shadow.isHidden = shadowPerButton
            end

            for j = 1, _G.NUM_ACTIONBAR_BUTTONS do
                shadow = bar.buttons[j]:GetShadow()
                if shadow then
                    shadow.isHidden = not shadowPerButton
                end
            end
        end
    end

    for frame in pairs(Addon.templatedFrames) do
        local border = frame:GetBorder()
        if border and not onlyInlays and not onlyShadows then
            border:Update()
        end
        local shadow = frame:GetShadow()
        if shadow and not onlyBorders and not onlyInlays then
            shadow:Update()
        end
        local inlay = frame:GetInlay()
        if inlay and not onlyBorders and not onlyShadows then
            inlay:Update()
        end
    end
end

function Styling:ApplyStyle(frame, styleConfigKey)
    if not frame then
        return
    end

    local border = frame:GetBorder()
    if border and border.styleConfigKey ~= styleConfigKey then
        border:Update(styleConfigKey)
    end
    local shadow = frame:GetShadow()
    if shadow and shadow.styleConfigKey ~= styleConfigKey then
        shadow:Update(styleConfigKey)
    end
    local inlay = frame:GetInlay()
    if inlay and inlay.styleConfigKey ~= styleConfigKey then
        inlay:Update(styleConfigKey)
    end
end

function Styling:SkinDecorativePanels()
    Styling:HandleDecorativePanel(LO.BottomPanel, "BOTTOM")
    Styling:HandleDecorativePanel(LO.TopPanel, "TOP")
    Styling:HandleDecorativePanel(AFK.AFKMode.bottom, "BOTTOM")

    -- plugins: ElvUI_MerathilisUI
    local merathilis = _G["ElvUI_MerathilisUI"] or _G["ElvUI_MerathilisUI-Classic"]
    if merathilis then
        Styling:HandleDecorativePanel(_G[merathilis[1].Title .. "TopPanel"], "TOP")
        Styling:HandleDecorativePanel(_G[merathilis[1].Title .. "BottomPanel"], "BOTTOM")
    end
end

function Styling:SkinMinimap()
    Styling:ApplyStyle(_G.Minimap, Addon.STYLE_CONFIG_KEYS.MINIMAP)
    local border = _G.Minimap:GetBorder()
    border.frameStrata = _G.MMHolder:GetFrameStrata()
    border.frameLevel = math.max(_G.Minimap:GetFrameLevel(), _G.MMHolder:GetFrameLevel()) + 1000
    border:Update()
    local inlay = _G.Minimap:GetInlay()
    inlay:Update()
end

function Styling:SkinSpellbook()
    for i = 1, _G.MAX_SKILLLINE_TABS do
        Styling:HandleTab(_G["SpellBookSkillLineTab" .. i], false, "RIGHT")
    end
    for i = 1, _G.SPELLS_PER_PAGE do
        _G["SpellButton" .. i].overrideTemplate = "Default"
    end
end