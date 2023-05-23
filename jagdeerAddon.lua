 --[[
 local ZT = CreateFrame("Frame")
 
ZT:RegisterEvent("ADDON_LOADED")
ZT:RegisterEvent("CHAT_MSG_ADDON")
 
ZT:SetScript("OnEvent", function()
	if event then
		if event == "ADDON_LOADED" and arg1 == "ztest" then
			DEFAULT_CHAT_FRAME:AddMessage("ZT is running.")
		end
		if event == "CHAT_MSG_ADDON" and arg3 ~= "GUILD" then
			DEFAULT_CHAT_FRAME:AddMessage("---- CHAT_MSG_ADDON ----")
			DEFAULT_CHAT_FRAME:AddMessage(arg1)
			DEFAULT_CHAT_FRAME:AddMessage(arg2)
			DEFAULT_CHAT_FRAME:AddMessage(arg3)
			DEFAULT_CHAT_FRAME:AddMessage(arg4)
			DEFAULT_CHAT_FRAME:AddMessage(arg5)
			DEFAULT_CHAT_FRAME:AddMessage(arg6)
			DEFAULT_CHAT_FRAME:AddMessage(arg7)
			DEFAULT_CHAT_FRAME:AddMessage(arg8)
			DEFAULT_CHAT_FRAME:AddMessage(arg9)
		end
	end
end)
-]]

CastMouseover = function(spellname)
	--[harm, nodead, exists]
	local isGoodUnit = function(unitid)
		return UnitExists(unitid) and not (UnitIsFriend(unitid, "player") or UnitIsDead(unitid))
	end
	--
	local doMouseover = isGoodUnit("mouseover") and not UnitIsUnit("mouseover", "target")
	local doRetarget = isGoodUnit("target")
	--
	if doMouseover then TargetUnit("mouseover") end
	CastSpellByName(spellname)
	if doMouseover and doRetarget then TargetLastTarget() end
end

StartAttack = function()
	if not startattack123.attacking then
		AttackTarget()
	end
end

startattack123 = CreateFrame("Frame")
startattack123:RegisterEvent("PLAYER_ENTER_COMBAT")
startattack123:RegisterEvent("PLAYER_LEAVE_COMBAT")

startattack123.attacking = false

startattack123:SetScript("OnEvent", function()
	this.attacking = event == "PLAYER_ENTER_COMBAT"
end)

CheckDebuff = function(bufftex)
	local i = 1
	local n = UnitDebuff("player", i)
	while n ~= nil do
		if string.find(n, bufftex) then return true end
		i = i + 1
		n = UnitBuff("player", i)
	end
	return false
end

UseBandage = function()
	local b, i, s, n
	local onself = IsShiftKeyDown()
	--DEFAULT_CHAT_FRAME:AddMessage(onself)
	--if onself and CheckDebuff("INV_Misc_Bandage_08") then return end
	for _,i in ipairs({14530, 14529, 8545, 8544, 6451, 6450, 3531, 3530, 2581, 1251}) do
		for b = 0, 4, 1 do
			for s = 1,GetContainerNumSlots(b), 1 do
				n = GetContainerItemLink(b, s)
				if n and string.find(n, i) then
					UseContainerItem(b, s, onself)
				end
			end
		end
	end
end



-- KICK ANNOUNCER


local announce = function(msg)
	SendChatMessage(msg, "party")
end

JDSpellAnnounceFrame = CreateFrame("Frame")
JDSpellAnnounceFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
JDSpellAnnounceFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
JDSpellAnnounceFrame:RegisterAllEvents()
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("ADDON_LOADED")
JDSpellAnnounceFrame:UnregisterEvent("BAG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_ADDON")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_GUILD")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SYSTEM")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_YELL")
JDSpellAnnounceFrame:UnregisterEvent("GUILD_ROSTER_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("MEETINGSTONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_UPDATE_ZOOM")
JDSpellAnnounceFrame:UnregisterEvent("PET_BAR_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_AURAS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LOGIN")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_LOG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("SKILL_LINES_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("SPELL_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("TABARD_CANSAVE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_HEALTH")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RAGE")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_BINDINGS")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_BONUS_ACTIONBAR")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_CHAT_COLOR")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_CHAT_WINDOWS")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_EXHAUSTION")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_FACTION")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_INSTANCE_INFO")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_LFG_TYPES")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_MACROS")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_PENDING_MAIL")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_TICKET")
JDSpellAnnounceFrame:UnregisterEvent("VARIABLES_LOADED")
JDSpellAnnounceFrame:UnregisterEvent("WORLD_MAP_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("ZONE_CHANGED_INDOORS")
-- UNIT_SPELLCAST_SUCCEEDED for challenging shout
-- CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS Fired when a buff is cast on self (SW, LS)
JDSpellAnnounceFrame:SetScript("OnEvent", function()
	DEFAULT_CHAT_FRAME:AddMessage(event)
	if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if string.find(arg1, "Your Taunt was resisted by (%w+)") then
			announce("TAUNT RESIST: "..UnitName("target")..UnitLevel("target"))
		elseif string.find(arg1, "Shield Bash") then
			if string.find(arg1, "Shield Bash hits") or string.find(arg1, "Shield Bash crits") then
				announce("kicked "..UnitName("target")..UnitLevel("target"))
			else
				announce("MISSED kick on "..UnitName("target")..UnitLevel("target"))
			end
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		DEFAULT_CHAT_FRAME:AddMessage(spell)
		DEFAULT_CHAT_FRAME:AddMessage(arg1)
		DEFAULT_CHAT_FRAME:AddMessage(arg2)
		DEFAULT_CHAT_FRAME:AddMessage(arg3)
		DEFAULT_CHAT_FRAME:AddMessage(arg4)
		DEFAULT_CHAT_FRAME:AddMessage(arg5)
	end
end)