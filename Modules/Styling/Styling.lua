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

    Styling:SkinBags()
    Styling:SkinDecorativePanels()
    Styling:SkinMinimap()
    
    Styling:Update()

    if Addon.Styling.TBC then
        Addon.Styling.TBC:Initialize()
    end
end

function Styling:Update(styleConfigKey, onlyShadows, onlyBorders)
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
        if frame.shadow and not onlyBorders and
            (not styleConfigKey or styleConfigKey == Addon.STYLE_CONFIG_KEYS.DEFAULT or frame.shadow.styleConfigKey ==
                styleConfigKey) then
            frame.shadow:Update()
        end
        if frame.border and not onlyShadows and
            (not styleConfigKey or styleConfigKey == Addon.STYLE_CONFIG_KEYS.DEFAULT or frame.border.styleConfigKey ==
                styleConfigKey) then
            frame.border:Update()
        end
    end
end

function Styling:ApplyStyle(frame, styleConfigKey)
    if not frame then
        return
    end

    local shadow = frame:GetShadow()
    if shadow and shadow.styleConfigKey ~= styleConfigKey then
        shadow:Update(styleConfigKey)
    end

    local border = frame:GetBorder()
    if border and border.styleConfigKey ~= styleConfigKey then
        border:Update(styleConfigKey)
    end
end

function Styling:SkinBags()
    B.BagFrame.title = B.BagFrame:CreateFontString("OVERLAY")
    B.BagFrame.title:FontTemplate()
    B.BagFrame.title:Point("TOP", B.BagFrame, "TOP", 0, -5)
    B.BagFrame.title:SetText(_G.INVENTORY_TOOLTIP)

    B.BankFrame.title = B.BankFrame:CreateFontString("OVERLAY")
    B.BankFrame.title:FontTemplate()
    B.BankFrame.title:Point("TOP", B.BankFrame, "TOP", 0, -5)
    B.BankFrame.title:SetText(_G.BANK)
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
end
