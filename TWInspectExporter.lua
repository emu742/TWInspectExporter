TWInspectExporter = {}

local frame = CreateFrame("Frame")
TWInspectExporter.Frame = frame
frame:Hide()
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent",
function(self, event, ...)
  local unit = ...;
  if ( event == "PLAYER_ENTERING_WORLD") then
    printToChat("WORLD ENTERD")
    OnLoad();
    return;
  end
end)

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

function OnLoad()
  LoadStats(frame, "player")
end

function LoadStats(statFrame, unit)
  SetHealth(statFrame, unit)
  SetMana(statFrame, unit)
  SetIntelligent(statFrame, unit)
  SetStamina(statFrame, unit)
  SetCrit(statFrame, unit)
  SetHaste(statFrame, unit)
  SetMastery(statFrame, unit)
  SetVersatility(statFrame, unit)
end

-- GESUNDHEIT
function SetHealth(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local health = UnitHealthMax(unit);
  printToChat(string.format('GESUNDHEIT: %i', health));
end

-- MANA
function SetMana(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local power = UnitPowerMax(unit) or 0;
  printToChat(string.format('MANA: %i', power));
end

-- INTELLIGENZ
function SetIntelligent(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local primaryStat = select(6, GetSpecializationInfo(GetSpecialization(), nil, nil, nil, UnitSex("player")));
  local mainstat = UnitStat(unit,primaryStat);
  printToChat(string.format('MAINSTAT: %i', mainstat));
end

-- AUSDAUER
function SetStamina(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local stamina = UnitStat(unit,3);
  printToChat(string.format('AUSDAUER: %i', stamina));
end

-- KRITISCHE TREFFERCHANCE
function SetCrit(statFrame, unit)
  if (not unit) then
    unit = "player";
  end

  local rating;
	local spellCrit, rangedCrit, meleeCrit;
	local critChance;
  -- Start at 2 to skip physical damage
local holySchool = 2;
local minCrit = GetSpellCritChance(holySchool);

  for i=(holySchool+1), MAX_SPELL_SCHOOLS do
    spellCrit = GetSpellCritChance(i);
    minCrit = min(minCrit, spellCrit);
  end

  spellCrit = minCrit
	rangedCrit = GetRangedCritChance();
	meleeCrit = GetCritChance();

  if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
    critChance = spellCrit;
    rating = CR_CRIT_SPELL;
  elseif (rangedCrit >= meleeCrit) then
    critChance = rangedCrit;
    rating = CR_CRIT_RANGED;
  else
    critChance = meleeCrit;
    rating = CR_CRIT_MELEE;
  end
  printToChat(string.format('KRITISCHE TREFFERCHANCE: %i', GetCombatRating(rating)));
end

-- TEMPO
function SetHaste(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local haste = GetCombatRating(CR_HASTE_MELEE);
  printToChat(string.format('TEMPO: %i', haste));
end

-- MEISTERSCHAFT
function SetMastery(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local mastery = GetCombatRating(CR_MASTERY);
  printToChat(string.format('MEISTERSCHAFT: %i', mastery));
end

-- VIELSEITIGKEIT
function SetVersatility(statFrame, unit)
  if (not unit) then
    unit = "player";
  end
  local versatility = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
  printToChat(string.format('VIELSEITIGKEIT: %i', versatility));
end

-- ############################################################################
-- Utillity
function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."Debug: |r"..tostring(msg))
end
