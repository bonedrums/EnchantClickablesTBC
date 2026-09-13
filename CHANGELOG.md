# Enchant Clickables

## 1.0.3 (2026-09-13) — local fix for TBC Anniversary 2.5.5

- Fixed: clicking a button did nothing. The modern client only processes the click phase matching `useOnKeyDown` (the ActionButtonUseKeyDown CVar, on by default); buttons now register both phases and pin the action to mouse release.  
- One-click apply: the enchant is cast and dropped on the partner's slot-7 item (`AUTO_APPLY` at the top of Init.lua; set to false for the old cursor behaviour). Replace-enchant popup and whisper are unchanged.  
- Buttons are pooled and reused instead of being recreated/leaked on every trade or inventory event.  
- Skip refreshes during combat lockdown and retry on PLAYER_REGEN_ENABLED.  
- Added C_Item / C_Spell fallbacks, BAG_UPDATE_DELAYED refresh for essence counts, `UNIT_INVENTORY_CHANGED` filtered to the player.  
- TOC Interface 20505.  

## [1.0.2](https://github.com/caffeineaddiction/EnchantClickables/tree/1.0.2) (2024-12-12)
[Full Changelog](https://github.com/caffeineaddiction/EnchantClickables/compare/1.0.1...1.0.2) [Previous Releases](https://github.com/caffeineaddiction/EnchantClickables/releases)

- Added Join / Split Essences and Lockpicking(untested)  
- Updated Readme (project approved on curse)  
- Updated Readme.md  
