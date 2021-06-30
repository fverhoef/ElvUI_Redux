local addonName, addonTable = ...
local Addon = addonTable[1]
local Layout = Addon.Layout
local E, L, V, P, G = unpack(ElvUI)

local Buttons = {}
local IgnoreButton = {
    "HelpOpenWebTicketButton",
    "MiniMapVoiceChatFrame",
    "TimeManagerClockButton",
    "BattlefieldMinimap",
    "ButtonCollectFrame",
    "GameTimeFrame",
    "QueueStatusMinimapButton",
    "GarrisonLandingPageMinimapButton",
    "MiniMapMailFrame",
    "MinimapZoneTextButton",
    "MinimapToggleButton",
    "MiniMapTracking",
    "MinimapZoomIn",
    "MinimapZoomOut",
    "RecipeRadarMinimapButtonFrame"
}
local GenericIgnore = {
    "Archy",
    "GatherMatePin",
    "GatherNote",
    "GuildInstance",
    "HandyNotesPin",
    "MiniMap",
    "Spy_MapNoteList_mini",
    "ZGVMarker",
    "poiMinimap",
    "GuildMap3Mini",
    "LibRockConfig-1.0_MinimapButton",
    "NauticusClassicMiniIcon",
    "NauticusMiniIcon",
    "WestPointer",
    "Cork",
    "DugisArrowMinimapPoint",
    "QuestieFrame"
}
local PartialIgnore = {"Node", "Note", "Pin", "POI"}
local UnrulyButtons = {"WIM3MinimapButton", "RecipeRadar_MinimapButton"}
local ButtonFunctions = {"SetParent", "ClearAllPoints", "SetPoint", "SetSize", "SetScale", "SetFrameStrata", "SetFrameLevel"}
local DoNotCrop = {ZygorGuidesViewerMapIcon = true, ItemRackMinimapFrame = true, Narci_MinimapButton = true}
local RemoveTextureID = {[136430] = true, [136467] = true, [136468] = true, [130924] = true}
local RemoveTextureFile = {
    ["interface/minimap/minimap-trackingborder"] = true,
    ["interface/minimap/ui-minimap-border"] = true,
    ["interface/minimap/ui-minimap-background"] = true
}

local function RemoveTexture(texture)
    if RemoveTextureFile[texture] then
        return true
    elseif strfind(texture, "interface/characterframe") then
        return true
    elseif strfind(texture, "interface/minimap") then
        return true
    elseif strfind(texture, "interface/minimap/tracking") then
        return true
    elseif strfind(texture, "border") then
        return true
    elseif strfind(texture, "background") then
        return true
    elseif strfind(texture, "alphamask") then
        return true
    elseif strfind(texture, "highlight") then
        return true
    end

    return false
end

local function SkipButton(button)
    local name = button.GetName and button:GetName()
    if not name or tContains(IgnoreButton, name) then
        return true
    end

    for i = 1, #GenericIgnore do
        if string.sub(name, 1, string.len(GenericIgnore[i])) == GenericIgnore[i] then
            return true
        end
    end

    for i = 1, #PartialIgnore do
        if string.find(name, PartialIgnore[i]) ~= nil then
            return true
        end
    end

    return false
end

local function StyleButton(button)
    if (not button) or SkipButton(button) then
        return
    end

    if button.style and button.style == E.db[addonName].layout.minimapButtonFrame.iconStyle then
        return
    end
    button.style = E.db[addonName].layout.minimapButtonFrame.iconStyle

    for i = 1, button:GetNumRegions() do
        local region = select(i, button:GetRegions())
        if region.IsObjectType and region:IsObjectType("Texture") then
            local textureID = region.GetTextureFileID and region:GetTextureFileID()
            local texture = strlower(tostring(region:GetTexture()))

            if not region.__texture then
                region.__alpha = region:GetAlpha()
                region.__textureID = textureID
                region.__texture = texture
                region.__setPoint = region.SetPoint
                region.__point = {region:GetPoint()}
                region.__setTexCoord = region.SetTexCoord
                region.__texCoords = {region:GetTexCoord()}
            end

            region:SetMask(nil)
            region:SetAlpha(region.__alpha)
            region:SetTexture(region.__texture)
            region:ClearAllPoints()
            region.SetPoint = region.__setPoint
            region:SetPoint(unpack(region.__point))
            region.SetTexCoord = region.__setTexCoord
            region:SetTexCoord(unpack(region.__texCoords))

            if RemoveTextureID[region.__textureID] then
                region:SetTexture()
            else
                if RemoveTexture(region.__texture) then
                    region:SetTexture()
                    region:SetAlpha(0)
                else
                    region:ClearAllPoints()
                    region:SetDrawLayer("ARTWORK")
                    region:SetInside()

                    local texCoords = {0, 1, 0, 1}
                    local modifier = 0.04 * E.db.general.cropIcon
                    for i, v in ipairs(texCoords) do
                        if i % 2 == 0 then
                            texCoords[i] = v - modifier
                        else
                            texCoords[i] = v + modifier
                        end
                    end

                    if not DoNotCrop[name] and not button.ignoreCrop then
                        region:SetTexCoord(unpack(texCoords))
                    end

                    if not region.__setPoint then
                        region.__setPoint = region.SetPoint
                    end
                    region.SetPoint = function()
                        return
                    end
                end
            end
        end
    end
end

local function LockButton(button)
    for _, func in pairs(ButtonFunctions) do
        button[func] = E.noop
    end
end

local function UnlockButton(button)
    for _, func in pairs(ButtonFunctions) do
        button[func] = nil
    end
end

local function GrabMinimapButton(button)
    if (not button) or button.isSkinned or SkipButton(button) then
        return
    end

    StyleButton(button)

    button.isSkinned = true
    table.insert(Buttons, button)

    return button.isSkinned
end

local function GrabChildren(frame)
    local numChildren = frame:GetNumChildren()
    if numChildren < (frame.numChildren or 0) then
        return
    end

    for i = 1, numChildren do
        local object = select(i, frame:GetChildren())
        if object and not object.isSkinned then
            local name = object:GetName()
            local width = object:GetWidth()
            if name and width > 15 and width < 60 and (object:IsObjectType("Button") or object:IsObjectType("Frame")) then
                if GrabMinimapButton(object) then
                    grabbedAnyButtons = true
                end
            end
        end
    end

    frame.numChildren = numChildren

    return grabbedAnyButtons
end

function Layout:CreateMinimapButtonFrame()
    if Minimap.ButtonFrame then
        Layout:UpdateMinimapButtonFrame()
        return
    end

    Minimap.ButtonFrame = CreateFrame("Frame", "MinimapButtonFrame", UIParent)
    Minimap.ButtonFrame:SetFrameStrata("LOW")
    Minimap.ButtonFrame:SetFrameLevel(1)
    Minimap.ButtonFrame:EnableMouse(true)
    Minimap.ButtonFrame:CreateBackdrop()

    _G.MinimapPanel:HookScript("OnShow", Layout.UpdateMinimapButtonFrame)

    Minimap.ButtonFrame.Container = CreateFrame("Frame", "MinimapButtonFrameContainer", Minimap.ButtonFrame)
    Minimap.ButtonFrame.Container:Hide()
    Minimap.ButtonFrame.Container:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "BOTTOMRIGHT", 0, 0)
    Minimap.ButtonFrame.Container:SetFrameStrata("MEDIUM")
    Minimap.ButtonFrame.Container:SetFrameLevel(1)
    Minimap.ButtonFrame.Container:EnableMouse(true)
    Minimap.ButtonFrame.Container:SetSize(Minimap:GetWidth(), 32)
    Minimap.ButtonFrame.Container:CreateBackdrop()

    Minimap.ButtonFrame.Toggle = CreateFrame("Button", "MinimapButtonFrameToggle", Minimap.ButtonFrame)
    Minimap.ButtonFrame.Toggle:SetNormalTexture(Addon.media.textures.arrowUp_ElvUI)
    Minimap.ButtonFrame.Toggle:SetFrameLevel(5)
    Minimap.ButtonFrame.Toggle:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "TOPRIGHT", -8, 0)
    Minimap.ButtonFrame.Toggle:SetSize(16, 16)
    Minimap.ButtonFrame.Toggle:SetScript("OnEnter", function(btn)
        GameTooltip:SetOwner(btn, "ANCHOR_TOPLEFT")
        if E.db[addonName].layout.minimapButtonFrame.collapsed then
            GameTooltip:SetText(L["Show Minimap Buttons"])
        else
            GameTooltip:SetText(L["Hide Minimap Buttons"])
        end
        GameTooltip:Show()

        local r, g, b = unpack(E.media.rgbvaluecolor)
        btn:GetNormalTexture():SetVertexColor(r, g, b)
    end)
    Minimap.ButtonFrame.Toggle:SetScript("OnLeave", function(btn)
        GameTooltip:Hide()
        btn:GetNormalTexture():SetVertexColor(1, 1, 1)
    end)
    Minimap.ButtonFrame.Toggle:SetScript("OnClick", function()
        Layout:ToggleButtonFrame()
        if E.db[addonName].layout.minimapButtonFrame.collapsed then
            GameTooltip:SetText(L["Show Minimap Buttons"])
        else
            GameTooltip:SetText(L["Hide Minimap Buttons"])
        end
        GameTooltip:Show()
    end)

    if E.db[addonName].layout.minimapButtonFrame.collapsed then
        Minimap.ButtonFrame.Container:Hide()
        Minimap.ButtonFrame.Toggle:GetNormalTexture():SetRotation(math.pi)
    else
        Minimap.ButtonFrame.Container:Show()
        Minimap.ButtonFrame.Toggle:GetNormalTexture():SetRotation(0)
    end

    Layout:UpdateMinimapButtonFrame()

    Layout:GrabMinimapButtons()
    Layout:ScheduleTimer("GrabMinimapButtons", 1)
    Layout:ScheduleRepeatingTimer("GrabMinimapButtons", 5)
end

function Layout:UpdateMinimapButtonFrame()
    if not E.db[addonName].layout.minimapButtonFrame.enabled then
        return
    end

    local buttonsPerRow = E.db[addonName].layout.minimapButtonFrame.buttonsPerRow or 12
    local spacing = E.db[addonName].layout.minimapButtonFrame.buttonSpacing or 2
    local size = E.db[addonName].layout.minimapButtonFrame.iconSize or 27

    local columnIndex, rowIndex = 0, 1
    local actualButtons, maxed = 0
    local minimapWidth = Minimap:GetWidth()
    local rowWidth = 0

    for _, button in pairs(Buttons) do
        if button:IsVisible() then
            columnIndex, actualButtons = columnIndex + 1, actualButtons + 1

            rowWidth = spacing + (size + spacing) * columnIndex

            if rowWidth > minimapWidth then
                rowIndex, columnIndex, maxed = rowIndex + 1, 1, true
            end

            StyleButton(button)
            UnlockButton(button)

            button:SetParent(Minimap.ButtonFrame.Container)
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", Minimap.ButtonFrame.Container, "TOPLEFT", spacing + (size + spacing) * (columnIndex - 1),
                            -spacing - (size + spacing) * (rowIndex - 1))
            button:SetSize(size, size)
            button:SetScale(1)
            button:SetFrameStrata("MEDIUM")
            button:SetFrameLevel(Minimap.ButtonFrame.Container:GetFrameLevel() + 1)
            button:SetScript("OnDragStart", nil)
            button:SetScript("OnDragStop", nil)

            LockButton(button)

            if maxed then
                actualButtons = buttonsPerRow
            end
        end
    end

    local barWidth = 2 * spacing + (size * actualButtons) + (spacing * (actualButtons - 1))
    local barHeight = 2 * spacing + (size * rowIndex) + (spacing * (rowIndex - 1))
    Minimap.ButtonFrame.Container:SetSize(minimapWidth, barHeight)

    Minimap.ButtonFrame:ClearAllPoints()
    Minimap.ButtonFrame.Toggle:ClearAllPoints()
    Minimap.ButtonFrame.Container:ClearAllPoints()
    MinimapPanel:ClearAllPoints()

    local offset = 2
    if MinimapPanel:IsShown() then
        if Minimap.ButtonFrame.shadow then
            Minimap.ButtonFrame.shadow.isHidden = true
        end
        Minimap.ButtonFrame:SetSize(18, MinimapPanel:GetHeight() - 2)
        Minimap.ButtonFrame:SetPoint("LEFT", MinimapPanel, "RIGHT", 0, 0)
        Minimap.ButtonFrame.Toggle:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "TOPRIGHT", -2, -1)
        Minimap.ButtonFrame.Container:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "BOTTOMRIGHT", 0, -6)

        MinimapPanel:Point("TOPLEFT", Minimap, "BOTTOMLEFT", (E.PixelMode and -1 or -2) + offset, 0)
        MinimapPanel:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", (E.PixelMode and 1 or 2) - 19, -22)
    else
        if Minimap.ButtonFrame.shadow then
            Minimap.ButtonFrame.shadow.isHidden = false
        end
        Minimap.ButtonFrame:SetSize(Minimap:GetWidth(), MinimapPanel:GetHeight() - 2)
        Minimap.ButtonFrame:SetPoint("TOP", Minimap, "BOTTOM", 0, -35)
        Minimap.ButtonFrame.Toggle:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "TOPRIGHT", -5, 0)
        Minimap.ButtonFrame.Container:SetPoint("TOPRIGHT", Minimap.ButtonFrame, "BOTTOMRIGHT", 0, 0)

        MinimapPanel:Point("TOPLEFT", Minimap, "BOTTOMLEFT", (E.PixelMode and -1 or -2) + offset, 0)
        MinimapPanel:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", E.PixelMode and 1 or 2, -22)
    end
end

function Layout:GrabMinimapButtons()
    if (InCombatLockdown() or C_PetBattles and C_PetBattles.IsInBattle()) then
        return
    end

    for _, button in pairs(UnrulyButtons) do
        if _G[button] then
            _G[button]:SetParent(Minimap)
        end
    end

    local grabbedAnyButtons = GrabChildren(Minimap)
    grabbedAnyButtons = GrabChildren(MinimapBackdrop) or grabbedAnyButtons
    grabbedAnyButtons = GrabChildren(MinimapCluster) or grabbedAnyButtons

    if grabbedAnyButtons then
        Layout:UpdateMinimapButtonFrame()
    end
end

function Layout:ToggleButtonFrame()
    if E.db[addonName].layout.minimapButtonFrame.collapsed then
        Minimap.ButtonFrame.Container:Show()
        Minimap.ButtonFrame.Toggle:GetNormalTexture():SetRotation(0)
        E.db[addonName].layout.minimapButtonFrame.collapsed = false
    else
        Minimap.ButtonFrame.Container:Hide()
        Minimap.ButtonFrame.Toggle:GetNormalTexture():SetRotation(math.pi)
        E.db[addonName].layout.minimapButtonFrame.collapsed = true
    end
    Layout:UpdateMinimapButtonFrame()
end
