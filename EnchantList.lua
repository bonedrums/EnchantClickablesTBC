EnchantList = {}

local tmp = {
    { spell_id = 13538, icon_id = 135940, name = "enchant-chest-lesser-absorption" },
    { spell_id = 13607, icon_id = 135861, name = "enchant-chest-mana" },
    { spell_id = 13626, icon_id = 136078, name = "enchant-chest-minor-stats" },
    { spell_id = 13640, icon_id = 135987, name = "enchant-chest-greater-health" },
    { spell_id = 13663, icon_id = 135861, name = "enchant-chest-greater-mana" },
    { spell_id = 13700, icon_id = 136078, name = "enchant-chest-lesser-stats" },
    { spell_id = 13858, icon_id = 135987, name = "enchant-chest-superior-health" },
    { spell_id = 13917, icon_id = 135861, name = "enchant-chest-superior-mana" },
    { spell_id = 13941, icon_id = 136078, name = "enchant-chest-stats" },
    { spell_id = 20025, icon_id = 136078, name = "enchant-chest-greater-stats" },
    { spell_id = 20026, icon_id = 135987, name = "enchant-chest-major-health" },
    { spell_id = 20028, icon_id = 135861, name = "enchant-chest-major-mana" },
    { spell_id = 27957, icon_id = 135987, name = "enchant-chest-exceptional-health" },
    { spell_id = 27958, icon_id = 135861, name = "enchant-chest-exceptional-mana" },
    { spell_id = 27960, icon_id = 136078, name = "enchant-chest-exceptional-stats" },
    { spell_id = 33990, icon_id = 135898, name = "enchant-chest-major-spirit" },
    { spell_id = 33991, icon_id = 135861, name = "enchant-chest-restore-mana-prime" },
    { spell_id = 33992, icon_id = 132484, name = "enchant-chest-major-resilience" },
    { spell_id = 46594, icon_id = 132341, name = "enchant-chest-defense" },
    { spell_id = 7420,  icon_id = 135987, name = "enchant-chest-minor-health" },
    { spell_id = 7426,  icon_id = 135940, name = "enchant-chest-minor-absorption" },
    { spell_id = 7443,  icon_id = 135861, name = "enchant-chest-minor-mana" },
    { spell_id = 7748,  icon_id = 135987, name = "enchant-chest-lesser-health" },
    { spell_id = 7776,  icon_id = 135861, name = "enchant-chest-lesser-mana" },
    { spell_id = 7857,  icon_id = 135987, name = "enchant-chest-health" }
}
EnchantList["INVTYPE_ROBE"] = tmp
EnchantList["INVTYPE_CHEST"] = tmp

tmp = {
    { spell_id = 13637, icon_id = 134873, name = "enchant-boots-lesser-agility" },
    { spell_id = 13644, icon_id = 135987, name = "enchant-boots-lesser-stamina" },
    { spell_id = 13687, icon_id = 135898, name = "enchant-boots-lesser-spirit" },
    { spell_id = 13836, icon_id = 135987, name = "enchant-boots-stamina" },
    { spell_id = 13890, icon_id = 132307, name = "enchant-boots-minor-speed" },
    { spell_id = 13935, icon_id = 134874, name = "enchant-boots-agility" },
    { spell_id = 20020, icon_id = 135987, name = "enchant-boots-greater-stamina" },
    { spell_id = 20023, icon_id = 134874, name = "enchant-boots-greater-agility" },
    { spell_id = 20024, icon_id = 135898, name = "enchant-boots-spirit" },
    { spell_id = 27948, icon_id = 132586, name = "enchant-boots-vitality" },
    { spell_id = 27950, icon_id = 135987, name = "enchant-boots-fortitude" },
    { spell_id = 27951, icon_id = 134874, name = "enchant-boots-dexterity" },
    { spell_id = 27954, icon_id = 132545, name = "enchant-boots-surefooted" },
    { spell_id = 34007, icon_id = 132567, name = "enchant-boots-cats-swiftness" },
    { spell_id = 34008, icon_id = 132536, name = "enchant-boots-boars-speed" },
    { spell_id = 7863,  icon_id = 135987, name = "enchant-boots-minor-stamina" },
    { spell_id = 7867,  icon_id = 134873, name = "enchant-boots-minor-agility" }
}
EnchantList["INVTYPE_FEET"] = tmp

tmp = {
    { spell_id = 13501, icon_id = 135987, name = "enchant-bracer-lesser-stamina" },
    { spell_id = 13536, icon_id = 136101, name = "enchant-bracer-lesser-strength" },
    { spell_id = 13622, icon_id = 135932, name = "enchant-bracer-lesser-intellect" },
    { spell_id = 13642, icon_id = 135898, name = "enchant-bracer-spirit" },
    { spell_id = 13646, icon_id = 132341, name = "enchant-bracer-lesser-deflection" },
    { spell_id = 13648, icon_id = 135987, name = "enchant-bracer-stamina" },
    { spell_id = 13661, icon_id = 136101, name = "enchant-bracer-strength" },
    { spell_id = 13822, icon_id = 135932, name = "enchant-bracer-intellect" },
    { spell_id = 13846, icon_id = 135898, name = "enchant-bracer-greater-spirit" },
    { spell_id = 13931, icon_id = 132341, name = "enchant-bracer-deflection" },
    { spell_id = 13939, icon_id = 136101, name = "enchant-bracer-greater-strength" },
    { spell_id = 13945, icon_id = 135987, name = "enchant-bracer-greater-stamina" },
    { spell_id = 20008, icon_id = 135932, name = "enchant-bracer-greater-intellect" },
    { spell_id = 20009, icon_id = 135898, name = "enchant-bracer-superior-spirit" },
    { spell_id = 20010, icon_id = 136101, name = "enchant-bracer-superior-strength" },
    { spell_id = 20011, icon_id = 135987, name = "enchant-bracer-superior-stamina" },
    { spell_id = 23801, icon_id = 135861, name = "enchant-bracer-mana-regeneration" },
    { spell_id = 23802, icon_id = 135922, name = "enchant-bracer-healing-power" },
    { spell_id = 27899, icon_id = 132938, name = "enchant-bracer-brawn" },
    { spell_id = 27905, icon_id = 136078, name = "enchant-bracer-stats" },
    { spell_id = 27906, icon_id = 132341, name = "enchant-bracer-major-defense" },
    { spell_id = 27911, icon_id = 135922, name = "enchant-bracer-superior-healing" },
    { spell_id = 27913, icon_id = 135861, name = "enchant-bracer-restore-mana-prime" },
    { spell_id = 27914, icon_id = 135987, name = "enchant-bracer-fortitude" },
    { spell_id = 27917, icon_id = 135150, name = "enchant-bracer-spellpower" },
    { spell_id = 34001, icon_id = 135932, name = "enchant-bracer-major-intellect" },
    { spell_id = 34002, icon_id = 132949, name = "enchant-bracer-assault" },
    { spell_id = 7418,  icon_id = 135987, name = "enchant-bracer-minor-health" },
    { spell_id = 7428,  icon_id = 132341, name = "enchant-bracer-minor-deflection" },
    { spell_id = 7457,  icon_id = 135987, name = "enchant-bracer-minor-stamina" },
    { spell_id = 7766,  icon_id = 135898, name = "enchant-bracer-minor-spirit" },
    { spell_id = 7779,  icon_id = 134873, name = "enchant-bracer-minor-agility" },
    { spell_id = 7782,  icon_id = 136101, name = "enchant-bracer-minor-strength" },
    { spell_id = 7859,  icon_id = 135898, name = "enchant-bracer-lesser-spirit" }
}
EnchantList["INVTYPE_WRIST"] = tmp

tmp = {
    { spell_id = 13612, icon_id = 134708, name = "enchant-gloves-mining" },
    { spell_id = 13617, icon_id = 134190, name = "enchant-gloves-herbalism" },
    { spell_id = 13620, icon_id = 136245, name = "enchant-gloves-fishing" },
    { spell_id = 13698, icon_id = 134366, name = "enchant-gloves-skinning" },
    { spell_id = 13815, icon_id = 134874, name = "enchant-gloves-agility" },
    { spell_id = 13841, icon_id = 134708, name = "enchant-gloves-advanced-mining" },
    { spell_id = 13868, icon_id = 134190, name = "enchant-gloves-advanced-herbalism" },
    { spell_id = 13887, icon_id = 136101, name = "enchant-gloves-strength" },
    { spell_id = 13947, icon_id = 132261, name = "enchant-gloves-riding-skill" },
    { spell_id = 13948, icon_id = 134376, name = "enchant-gloves-minor-haste" },
    { spell_id = 20012, icon_id = 134873, name = "enchant-gloves-greater-agility" },
    { spell_id = 20013, icon_id = 136101, name = "enchant-gloves-greater-strength" },
    { spell_id = 25072, icon_id = 136080, name = "enchant-gloves-threat" },
    { spell_id = 25073, icon_id = 136197, name = "enchant-gloves-shadow-power" },
    { spell_id = 25074, icon_id = 135846, name = "enchant-gloves-frost-power" },
    { spell_id = 25078, icon_id = 135812, name = "enchant-gloves-fire-power" },
    { spell_id = 25079, icon_id = 135922, name = "enchant-gloves-healing-power" },
    { spell_id = 25080, icon_id = 134874, name = "enchant-gloves-superior-agility" },
    { spell_id = 33993, icon_id = 135839, name = "enchant-gloves-blasting" },
    { spell_id = 33994, icon_id = 135358, name = "enchant-gloves-spell-strike" },
    { spell_id = 33995, icon_id = 136101, name = "enchant-gloves-major-strength" },
    { spell_id = 33996, icon_id = 132949, name = "enchant-gloves-assault" },
    { spell_id = 33997, icon_id = 135150, name = "enchant-gloves-major-spellpower" },
    { spell_id = 33999, icon_id = 135922, name = "enchant-gloves-major-healing" }
}
EnchantList["INVTYPE_HAND"] = tmp

tmp = {
    { spell_id = 13419, icon_id = 134873, name = "enchant-cloak-minor-agility" },
    { spell_id = 13421, icon_id = 133604, name = "enchant-cloak-lesser-protection" },
    { spell_id = 13522, icon_id = 136121, name = "enchant-cloak-lesser-shadow-resistance" },
    { spell_id = 13635, icon_id = 132341, name = "enchant-cloak-defense" },
    { spell_id = 13657, icon_id = 135805, name = "enchant-cloak-fire-resistance" },
    { spell_id = 13746, icon_id = 132341, name = "enchant-cloak-greater-defense" },
    { spell_id = 13794, icon_id = 136120, name = "enchant-cloak-resistance" },
    { spell_id = 13882, icon_id = 134873, name = "enchant-cloak-lesser-agility" },
    { spell_id = 20014, icon_id = 136120, name = "enchant-cloak-greater-resistance" },
    { spell_id = 20015, icon_id = 132341, name = "enchant-cloak-superior-defense" },
    { spell_id = 25081, icon_id = 135805, name = "enchant-cloak-greater-fire-resistance" },
    { spell_id = 25082, icon_id = 136074, name = "enchant-cloak-greater-nature-resistance" },
    { spell_id = 25083, icon_id = 132320, name = "enchant-cloak-stealth" },
    { spell_id = 25084, icon_id = 135910, name = "enchant-cloak-subtlety" },
    { spell_id = 25086, icon_id = 136047, name = "enchant-cloak-dodge" },
    { spell_id = 27961, icon_id = 133604, name = "enchant-cloak-major-armor" },
    { spell_id = 27962, icon_id = 136120, name = "enchant-cloak-major-resistance" },
    { spell_id = 34003, icon_id = 136011, name = "enchant-cloak-spell-penetration" },
    { spell_id = 34004, icon_id = 134873, name = "enchant-cloak-greater-agility" },
    { spell_id = 34005, icon_id = 136116, name = "enchant-cloak-greater-arcane-resistance" },
    { spell_id = 34006, icon_id = 136121, name = "enchant-cloak-greater-shadow-resistance" },
    { spell_id = 47051, icon_id = 134950, name = "enchant-cloak-steelweave" },
    { spell_id = 7454,  icon_id = 136120, name = "enchant-cloak-minor-resistance" },
    { spell_id = 7771,  icon_id = 133604, name = "enchant-cloak-minor-protection" },
    { spell_id = 7861,  icon_id = 135805, name = "enchant-cloak-lesser-fire-resistance" }
}
EnchantList["INVTYPE_CLOAK"] = tmp

tmp = {
    { spell_id = 13380, icon_id = 135898, name = "enchant-2h-weapon-lesser-spirit" },
    { spell_id = 13503, icon_id = 135358, name = "enchant-weapon-lesser-striking" },
    { spell_id = 13529, icon_id = 135360, name = "enchant-2h-weapon-lesser-impact" },
    { spell_id = 13653, icon_id = 132117, name = "enchant-weapon-lesser-beastslayer" },
    { spell_id = 13655, icon_id = 135791, name = "enchant-weapon-lesser-elemental-slayer" },
    { spell_id = 13693, icon_id = 135358, name = "enchant-weapon-striking" },
    { spell_id = 13695, icon_id = 135360, name = "enchant-2h-weapon-impact" },
    { spell_id = 13898, icon_id = 135830, name = "enchant-weapon-fiery-weapon" },
    { spell_id = 13915, icon_id = 134807, name = "enchant-weapon-demonslaying" },
    { spell_id = 13937, icon_id = 135360, name = "enchant-2h-weapon-greater-impact" },
    { spell_id = 13943, icon_id = 135358, name = "enchant-weapon-greater-striking" },
    { spell_id = 20029, icon_id = 134800, name = "enchant-weapon-icy-chill" },
    { spell_id = 20030, icon_id = 135360, name = "enchant-2h-weapon-superior-impact" },
    { spell_id = 20031, icon_id = 135358, name = "enchant-weapon-superior-striking" },
    { spell_id = 20032, icon_id = 136199, name = "enchant-weapon-lifestealing" },
    { spell_id = 20033, icon_id = 136225, name = "enchant-weapon-unholy-weapon" },
    { spell_id = 20034, icon_id = 135882, name = "enchant-weapon-crusader" },
    { spell_id = 20035, icon_id = 135898, name = "enchant-2h-weapon-major-spirit" },
    { spell_id = 20036, icon_id = 135932, name = "enchant-2h-weapon-major-intellect" },
    { spell_id = 21931, icon_id = 135850, name = "enchant-weapon-winters-might" },
    { spell_id = 22749, icon_id = 135150, name = "enchant-weapon-spell-power" },
    { spell_id = 22750, icon_id = 135922, name = "enchant-weapon-healing-power" },
    { spell_id = 23799, icon_id = 136101, name = "enchant-weapon-strength" },
    { spell_id = 23800, icon_id = 134874, name = "enchant-weapon-agility" },
    { spell_id = 23803, icon_id = 135946, name = "enchant-weapon-mighty-spirit" },
    { spell_id = 23804, icon_id = 135869, name = "enchant-weapon-mighty-intellect" },
    { spell_id = 27837, icon_id = 134874, name = "enchant-2h-weapon-agility" },
    { spell_id = 27967, icon_id = 135358, name = "enchant-weapon-major-striking" },
    { spell_id = 27968, icon_id = 135932, name = "enchant-weapon-major-intellect" },
    { spell_id = 27971, icon_id = 132392, name = "enchant-2h-weapon-savagery" },
    { spell_id = 27972, icon_id = 136023, name = "enchant-weapon-potency" },
    { spell_id = 27975, icon_id = 135150, name = "enchant-weapon-major-spellpower" },
    { spell_id = 27977, icon_id = 134874, name = "enchant-2h-weapon-major-agility" },
    { spell_id = 27981, icon_id = 135824, name = "enchant-weapon-sunfire" },
    { spell_id = 27982, icon_id = 135152, name = "enchant-weapon-soulfrost" },
    { spell_id = 27984, icon_id = 136111, name = "enchant-weapon-mongoose" },
    { spell_id = 28003, icon_id = 135729, name = "enchant-weapon-spellsurge" },
    { spell_id = 28004, icon_id = 132344, name = "enchant-weapon-battlemaster" },
    { spell_id = 34010, icon_id = 135922, name = "enchant-weapon-major-healing" },
    { spell_id = 42620, icon_id = 134874, name = "enchant-weapon-greater-agility" },
    { spell_id = 42974, icon_id = 133069, name = "enchant-weapon-executioner" },
    { spell_id = 46578, icon_id = 135683, name = "enchant-weapon-deathfrost" },
    { spell_id = 7745,  icon_id = 135360, name = "enchant-2h-weapon-minor-impact" },
    { spell_id = 7786,  icon_id = 132117, name = "enchant-weapon-minor-beastslayer" },
    { spell_id = 7788,  icon_id = 135358, name = "enchant-weapon-minor-striking" },
    { spell_id = 7793,  icon_id = 135932, name = "enchant-2h-weapon-lesser-intellect" }
}
EnchantList["INVTYPE_WEAPON"] = tmp
EnchantList["INVTYPE_2HWEAPON"] = tmp
EnchantList["INVTYPE_WEAPONMAINHAND"] = tmp
EnchantList["INVTYPE_WEAPONOFFHAND"] = tmp

tmp = {
    { spell_id = 13378, icon_id = 135987, name = "enchant-shield-minor-stamina" },
    { spell_id = 13464, icon_id = 133604, name = "enchant-shield-lesser-protection" },
    { spell_id = 13485, icon_id = 135898, name = "enchant-shield-lesser-spirit" },
    { spell_id = 13631, icon_id = 135987, name = "enchant-shield-lesser-stamina" },
    { spell_id = 13659, icon_id = 135898, name = "enchant-shield-spirit" },
    { spell_id = 13689, icon_id = 134953, name = "enchant-shield-lesser-block" },
    { spell_id = 13817, icon_id = 135987, name = "enchant-shield-stamina" },
    { spell_id = 13905, icon_id = 135898, name = "enchant-shield-greater-spirit" },
    { spell_id = 13933, icon_id = 135849, name = "enchant-shield-frost-resistance" },
    { spell_id = 20016, icon_id = 135898, name = "enchant-shield-superior-spirit" },
    { spell_id = 20017, icon_id = 135987, name = "enchant-shield-greater-stamina" },
    { spell_id = 27944, icon_id = 133604, name = "enchant-shield-tough-shield" },
    { spell_id = 27945, icon_id = 135932, name = "enchant-shield-intellect" },
    { spell_id = 27946, icon_id = 134953, name = "enchant-shield-shield-block" },
    { spell_id = 27947, icon_id = 136120, name = "enchant-shield-resistance" },
    { spell_id = 34009, icon_id = 135987, name = "enchant-shield-major-stamina" },
    { spell_id = 44383, icon_id = 132484, name = "enchant-shield-resilience" }
}
EnchantList["INVTYPE_SHIELD"] = tmp

tmp = {
    { spell_id = 1804, icon_id = 136058, name = "pick-lock" }
}
EnchantList["INVTYPE_NON_EQUIP"] = tmp

tmp = {
        -- Magic
        { item_id = 10939, icon_id = 132866, name = "split-greater-magic" },
        { item_id = 10938, icon_id = 132867, name = "join-lesser-magic" },
        -- Astral
        { item_id = 11082, icon_id = 132862, name = "split-greater-astral" },
        { item_id = 10998, icon_id = 132863, name = "join-lesser-astral" },
        -- Mystic
        { item_id = 11135, icon_id = 132868, name = "split-greater-mystic" },
        { item_id = 11134, icon_id = 132869, name = "join-lesser-mystic" },
        -- Nether
        { item_id = 11175, icon_id = 132870, name = "split-greater-nether" },
        { item_id = 11174, icon_id = 132871, name = "join-lesser-nether" },
        -- Eternal
        { item_id = 16203, icon_id = 132864, name = "split-greater-eternal" },
        { item_id = 16202, icon_id = 132865, name = "join-lesser-eternal" },
        -- Planar
        { item_id = 22446, icon_id = 132860, name = "split-greater-planar" },
        { item_id = 22447, icon_id = 132861, name = "join-lesser-planar" },
}
EnchantList["ESSENCE"] = tmp