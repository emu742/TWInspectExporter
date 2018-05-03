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

local function OnLoad()
  LoadStats(frame, "player")
end

frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
frame:SetScript("OnEvent", function(self, event, arg1)
    OnLoad();
end)


function LoadStats(statFrame, unit)
  SetHealth(statFrame, unit)
end

function SetHealth(statFrame, unit)
	if (not unit) then
		unit = "player";
	end
	local health = UnitHealthMax(unit);
  printToChat(string.format('Gesundheit: %i', health));
end


-- MANA
-- INTELLIGENZ
-- AUSDAUER
-- KRITISCHE TREFFERCHANCE
-- TEMPO
-- MEISTERSCHAFT
-- VIELSEITIGKEIT



function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."Debug: |r"..tostring(msg))
end
