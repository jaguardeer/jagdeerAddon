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

CastMouseover2 = function(spellname)
	--[harm, nodead, exists]
	local isGoodUnit = function(unitid)
		return UnitExists(unitid) and not (UnitIsFriend(unitid, "player") or UnitIsDead(unitid))
	end
	--
	local doMouseover = isGoodUnit("mouseover") and not UnitIsUnit("mouseover", "target")
	--
	if doMouseover then TargetUnit("mouseover") end
	CastSpellByName(spellname)
end

CastMouseoverFriendly = function(spellname)
	--[exists, noharm, nodead]
	local isGoodUnit = function(unitid)
		return UnitExists(unitid) and UnitIsFriend(unitid, "player") and not UnitIsDead(unitid)
	end
	--
	if isGoodUnit("mouseover") then
		local doRetarget = not UnitIsUnit("mouseover", "target")
		TargetUnit("mouseover")
		CastSpellByName(spellname)
		if doRetarget then
			TargetLastTarget()
		end
	elseif isGoodUnit("target") then
		CastSpellByName(spellname)
	else
		CastSpellByName(spellname, true)
	end
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

local UseItem = function(itemstr, onself)
	for b = 0, 4, 1 do
		for s = 1,GetContainerNumSlots(b), 1 do
			local n = GetContainerItemLink(b, s)
			if n and string.find(n, itemstr) then
				UseContainerItem(b, s, onself)
			end
		end
	end
end

UseBandage = function()
	local onself = IsShiftKeyDown()
	--if onself and CheckDebuff("INV_Misc_Bandage_08") then return end
	for _,i in ipairs({14530, 14529, 8545, 8544, 6451, 6450, 3531, 3530, 2581, 1251}) do
		UseItem(i, onself)
	end
end

local CheckBuff = function(bufftex)
	for i=0,32 do
		local n = GetPlayerBuffTexture(i)
		if n and string.find(n, bufftex) then
			return true
		end
	end
	return false
end

EatDrinkMageFood = function()
	local foods = {"Conjured Muffin"}
	local drinks = {"Conjured Water"}
	if not CheckBuff("INV_Drink_07") then
		for _,drink in ipairs(drinks) do
			UseItem(drink)
		end
	elseif not CheckBuff("INV_Misc_Fork&Knife") then
		for _,food in ipairs(foods) do
			UseItem(food)
		end
	end
end


-- KICK ANNOUNCER

local announce = function(msg)
	SendChatMessage(msg, "party")
end

JDSpellAnnounceFrame = CreateFrame("Frame")
-- (temp) list of all events
JDSpellAnnounceFrame:RegisterAllEvents()
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_HIDEGRID")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_PAGE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_SHOWGRID")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_STATE")
JDSpellAnnounceFrame:UnregisterEvent("ACTIONBAR_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("ADDON_LOADED")
JDSpellAnnounceFrame:UnregisterEvent("AUTOEQUIP_BIND_CONFIRM")
JDSpellAnnounceFrame:UnregisterEvent("AUTOFOLLOW_BEGIN")
JDSpellAnnounceFrame:UnregisterEvent("AUTOFOLLOW_END")
JDSpellAnnounceFrame:UnregisterEvent("BAG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("BAG_UPDATE_COOLDOWN")
JDSpellAnnounceFrame:UnregisterEvent("BANKFRAME_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("BANKFRAME_OPENED")
JDSpellAnnounceFrame:UnregisterEvent("CHARACTER_POINTS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_ADDON")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_AURA_GONE_PARTY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_JOIN")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_LEAVE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_PARTY_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_GUILD")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_LOOT")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONEY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONSTER_EMOTE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_PARTY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SAY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SKILL")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_MISSES")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SPELL_TRADESKILLS")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_SYSTEM")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_TEXT_EMOTE")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_WHISPER")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_WHISPER_INFORM")
JDSpellAnnounceFrame:UnregisterEvent("CHAT_MSG_YELL")
JDSpellAnnounceFrame:UnregisterEvent("COMBAT_MSG_SPELL_SELF_BUFF")
JDSpellAnnounceFrame:UnregisterEvent("COMBAT_TEXT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("CURRENT_SPELL_CAST_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("CURSOR_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("DELETE_ITEM_CONFIRM")
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
JDSpellAnnounceFrame:UnregisterEvent("LEARNED_SPELL_IN_TAB")
JDSpellAnnounceFrame:UnregisterEvent("LOOT_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("LOOT_OPENED")
JDSpellAnnounceFrame:UnregisterEvent("LOOT_SLOT_CLEARED")
JDSpellAnnounceFrame:UnregisterEvent("MEETINGSTONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("MERCHANT_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("MERCHANT_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("MERCHANT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_PING")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_UPDATE_ZOOM")
JDSpellAnnounceFrame:UnregisterEvent("MINIMAP_ZONE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("MIRROR_TIMER_START")
JDSpellAnnounceFrame:UnregisterEvent("MIRROR_TIMER_STOP")
JDSpellAnnounceFrame:UnregisterEvent("PARTY_LEADER_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PARTY_MEMBER_DISABLE")
JDSpellAnnounceFrame:UnregisterEvent("PARTY_MEMBER_ENABLE")
JDSpellAnnounceFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PET_BAR_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ALIVE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_AURAS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_CAMPING")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_CONTROL_GAINED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_CONTROL_LOST")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_DAMAGE_DONE_MODS")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_GUILD_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LEAVING_WORLD")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LEVEL_UP")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_LOGIN")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_MONEY")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_TRADE_MONEY")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_UNGHOST")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
JDSpellAnnounceFrame:UnregisterEvent("PLAYER_XP_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("PLAYERBANKSLOTS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_COMPLETE")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_DETAIL")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_DETAIL")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_FINISHED")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_GREETING")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_ITEM_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_LOG_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_PROGRESS")
JDSpellAnnounceFrame:UnregisterEvent("QUEST_WATCH_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("RAID_TARGET_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("SKILL_LINES_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
JDSpellAnnounceFrame:UnregisterEvent("SPELL_UPDATE_USABLE")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_CHANNEL_START")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_DELAYED")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_FAILED")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_INTERRUPTED")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_START")
JDSpellAnnounceFrame:UnregisterEvent("SPELLCAST_STOP")
JDSpellAnnounceFrame:UnregisterEvent("SPELLS_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TABARD_CANSAVE_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TAXIMAP_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("TAXIMAP_OPENED")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_ACCEPT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_PLAYER_ITEM_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_REQUEST_CANCEL")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_CLOSE")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_SKILL_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("TRADE_TARGET_ITEM_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("TRAINER_CLOSED")
JDSpellAnnounceFrame:UnregisterEvent("TRAINER_SHOW")
JDSpellAnnounceFrame:UnregisterEvent("TRAINER_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UI_ERROR_MESSAGE")
JDSpellAnnounceFrame:UnregisterEvent("UI_INFO_MESSAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK_POWER")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ATTACK_SPEED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_AURA")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_COMBAT")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DEFENSE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_DYNAMIC_FLAGS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_ENERGY")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_FACTION")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_FLAGS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_FOCUS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_HAPPINESS")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_HEALTH")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_LEVEL")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_LOYALTY")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_MANA")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_MAXHEALTH")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_MAXMANA")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_MODEL_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_NAME_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RANGED_ATTACK_POWER")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RANGEDDAMAGE")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_RESISTANCES")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
JDSpellAnnounceFrame:UnregisterEvent("UNIT_STATS")
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
-- register actual events
JDSpellAnnounceFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
JDSpellAnnounceFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
-- UNIT_SPELLCAST_SUCCEEDED for challenging shout
-- CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS Fired when a buff is cast on self (SW, LS)
JDSpellAnnounceFrame:SetScript("OnEvent", function()
	if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		--DEFAULT_CHAT_FRAME:AddMessage(arg1)
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
	else
		DEFAULT_CHAT_FRAME:AddMessage(event)
	end
end)


-- auto dismount
local autoDismountFrame = CreateFrame("Frame")
autoDismountFrame:RegisterEvent("UI_ERROR_MESSAGE")
autoDismountFrame:SetScript("onEvent", function ()
	if event == "UI_ERROR_MESSAGE" and arg1 == "You are mounted" then
		-- dismount (make this more robust)
		CastSpellByName("Riding Turtle")
	end
end)