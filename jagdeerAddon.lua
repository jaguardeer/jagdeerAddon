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
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_PAGE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_STATE")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("ADDON_LOADED")
JDSpellAnnounceFrame:UnregisterEvent("BAG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_ADDON")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_GUILD")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_LOOT")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SAY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SKILL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_TRADESKILLS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SYSTEM")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_TEXT_EMOTE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_YELL")
JDSpellAnnounceFrame:UnregisterEvent("COMBAT_MSG_SPELL_SELF_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("COMBAT_TEXT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("CURSOR_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("EXECUTE_CHAT_LINE")
JDSpellAnnounceFrame:UnregisterEvent("FRIENDLIST_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("GOSSIP_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("GOSSIP_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("GUILD_MOTD")
JDSpellAnnounceFrame:UnregisterEvent("GUILD_ROSTER_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("IGNORELIST_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("ITEM_LOCK_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ITEM_PUSH")
JDSpellAnnounceFrame:UnregisterEvent("LANGUAGE_LIST_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("MEETINGSTONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("MERCHANT_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("MERCHANT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_UPDATE_ZOOM")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_ZONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PET_BAR_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ALIVE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_AURAS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_GUILD_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LOGIN")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_MONEY")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_UNGHOST")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_DETAIL")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_DETAIL")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_FINISHED")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_GREETING")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_LOG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_PROGRESS")
JDSpellAnnounceFrame:UnregisterEvent("SKILL_LINES_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
JDSpellAnnounceFrame:UnregisterEvent("SPELL_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_FAILED")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_START")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_STOP")
JDSpellAnnounceFrame:UnregisterEvent("SPELLS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TABARD_CANSAVE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_CLOSE")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UI_ERROR_MESSAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK_POWER")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK_SPEED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_AURA")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_COMBAT")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DEFENSE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DYNAMIC_FLAGS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_FACTION")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_FLAGS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_HEALTH")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_MODEL_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_NAME_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RANGED_ATTACK_POWER")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RESISTANCES")
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
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_SHAPESHIFT_FORMS")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_TICKET")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_TRADESKILL_RECAST")
JDSpellAnnounceFrame:UnregisterEvent("UPDATE_WORLD_STATES")
JDSpellAnnounceFrame:UnregisterEvent("VARIABLES_LOADED")
JDSpellAnnounceFrame:UnregisterEvent("WORLD_MAP_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("ZONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ZONE_CHANGED_INDOORS")
JDSpellAnnounceFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
-- UNIT_SPELLCAST_SUCCEEDED for challenging shout
-- CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS Fired when a buff is cast on self (SW, LS)
JDSpellAnnounceFrame:SetScript("OnEvent", function()
	DEFAULT_CHAT_FRAME:AddMessage(event)
	if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		DEFAULT_CHAT_FRAME:AddMessage(arg1)
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