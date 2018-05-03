TWInspectExporter = {}

local frame = CreateFrame("Frame")
TWInspectExporter.Frame = frame
frame:Hide()

local statList = {};
local PAPERDOLL_FRAME_EVENTS = {
	"PLAYER_EQUIPMENT_CHANGED",
	"MERCHANT_UPDATE",
	"PLAYERBANKSLOTS_CHANGED",
	"ITEM_LOCK_CHANGED",
	"CURSOR_UPDATE",
	"UPDATE_INVENTORY_ALERTS",
	"AZERITE_ITEM_POWER_LEVEL_CHANGED",
	"AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED",
};

function TinyCasterStats:OnEnable()
  LoadStats(frame, "player")
end

function LoadStats(statFrame, unit)
  SetHealth(statFrame, unit)
end

function SetHealth(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local health = UnitHealthMax(unit);
  printToChat(string.format("Gesundheit: %i", health));
end


-- MANA
-- INTELLIGENZ
-- AUSDAUER
-- KRITISCHE TREFFERCHANCE
-- TEMPO
-- MEISTERSCHAFT
-- VIELSEITIGKEIT



function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."SA: |r"..tostring(msg))
end
