local addonName, addonTable = ...
local Addon = addonTable[1]
if not Addon.isTbc then
    return
end

local Layout = Addon.Layout.TBC
local E, L, V, P, G = unpack(ElvUI)

function Layout:LayoutGuildMemberDetailFrame()
    if not E.db[addonName].layout.guildMemberDetailFrame.enabled then
        return
    end

    -- add icons to guild member details frames    
    _G.GuildMemberDetailFrame.icon = _G.GuildMemberDetailFrame:CreateTexture("$parentIcon", "ARTWORK")
    _G.GuildMemberDetailFrame.icon:SetPoint("TOPLEFT", _G.GuildMemberDetailName, "TOPLEFT", -30, 0)
    _G.GuildMemberDetailFrame.icon:SetSize(25, 25)
    _G.GuildMemberDetailFrame.icon:SetTexture([[Interface\WorldStateFrame\Icons-Classes]])
    _G.GuildMemberDetailName:Offset("TOPLEFT", 30, 0)
    _G.GuildMemberDetailZoneLabel:Offset("TOPLEFT", -30, 0)

    Layout:SecureHook("GuildStatus_Update", function()
        local selection = GetGuildRosterSelection()
        if selection then
            local fullName, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(selection)
            local classFileName = E:UnlocalizedClassName(class)
            local classTextColor = _G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[classFileName] or
                                       _G.RAID_CLASS_COLORS[classFileName]
            if classTextColor then
                local levelTextColor = GetQuestDifficultyColor(level)
                _G.GuildMemberDetailName:SetTextColor(classTextColor.r, classTextColor.g, classTextColor.b)
                _G.GuildMemberDetailLevel:SetTextColor(levelTextColor.r, levelTextColor.g, levelTextColor.b)
                if _G.GuildMemberDetailFrame.icon then
                    _G.GuildMemberDetailFrame.icon:SetTexCoord(unpack(_G.CLASS_ICON_TCOORDS[classFileName]))
                end
            end
        end
    end)
end