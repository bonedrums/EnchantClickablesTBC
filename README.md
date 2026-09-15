# Enchant Clickables <sub><sup>TBC</sup></sub>

**Stop typing `/cast Enchant Bracer - Superior Strength`.** Open a trade, and every enchant you can actually cast on the customer's item appears as a one-click button next to the trade window.

Updated for **TBC Anniversary (2.5.5)**. A fork of [caffeineaddiction/EnchantClickables](https://github.com/caffeineaddiction/EnchantClickables), itself a port of a Notorious clickable WeakAura.

<img width="752" height="323" alt="The enchant list docked to the right of the trade window" src="https://github.com/user-attachments/assets/50215a78-1f0f-47c5-b3b1-13062aff9914" />

---

## How it works

The addon is a list that docks to the right edge of your trade window and rebuilds itself every time the trade changes. Nothing to configure, no slash commands — it only exists while a trade is open.

When the customer drops an item into the **"Will not be traded"** slot, the addon:

1. **Reads the item's equip location** — chest, bracer, boots, cloak, weapon, shield, and so on.
2. **Looks up every enchant for that slot** from a table of ~190 spells spanning Classic and TBC.
3. **Filters to what you can cast right now.** Two independent checks, both of which must pass:
   - *Do you know it?* Trade skill recipes never appear in the spellbook, so `IsSpellKnown` is useless here. Instead the spell ID is resolved to a name and looked up again — a lookup that only succeeds if you've learned the recipe.
   - *Do you have the reagents?* Delegated to the client's own `IsUsableSpell`, so the list reflects your actual bags.
4. **Draws a button per survivor**, with the spell's real icon and name.

Click one and it casts. Everything that doesn't pass step 3 never renders, so the list is only ever things that will succeed.

### One-click apply

By default the addon doesn't just cast — it casts *and* applies:

```lua
/cast <enchant>
/run TradeRecipientItem7ItemButton:Click()
```

The second line clicks the customer's "Will not be traded" slot for you, so the enchant lands without you chasing the targeting cursor. If you'd rather aim it yourself, flip `AUTO_APPLY` to `false` at the top of `Init.lua` and you get the original cursor behaviour back.

This is never destructive. If the item already carries an enchant, the client's normal **"Replace enchant?"** confirmation still appears — and the addon whispers your trade partner `Replace <old> with <new>?` so they can confirm it's what they wanted before you commit.

### Beyond enchants

Two extras ride along in the same list:

**Essence splitting and joining.** Greater ↔ lesser conversions for all six essence types — Magic, Astral, Mystic, Nether, Eternal, and Planar. These are gated on inventory rather than reagents: splits need 1 greater, joins need 3 lesser. Unlike enchants, these buttons always render — they just turn **red** when you're short and **green** when you're good, so you can see the count at a glance.

**Lockpicking.** Hand a rogue a lockbox and it registers as `INVTYPE_NON_EQUIP`, which maps to Pick Lock. Same one-click flow.

### Supported slots

| | |
|---|---|
| Chest / Robe | Bracer |
| Boots | Gloves |
| Cloak | Shield |
| Weapon, 2H, Main-hand, Off-hand | Lockboxes *(Pick Lock)* |

---

## Installing

Drop the `EnchantClickables` folder into `World of Warcraft\_classic_\Interface\AddOns\`. Restart the client or `/reload`. There's nothing to turn on — open a trade and it's there.

---

## Notes on the TBC port

The original addon's buttons did nothing on 2.5.5. The client only processes the click phase matching `useOnKeyDown` — driven by the `ActionButtonUseKeyDown` CVar, which is **on by default** — and a plain button registers only `LeftButtonUp`, so every click was silently swallowed. Buttons now register both phases and pin the action to mouse release, firing exactly once.

The rest of the 1.0.3 pass was durability work:

- Buttons are **pooled and reused** rather than recreated (and leaked) on every trade or bag event.
- Refreshes are **skipped during combat lockdown** and retried on `PLAYER_REGEN_ENABLED`, since secure buttons can't be reconfigured mid-fight.
- `C_Item` / `C_Spell` fallbacks in case the classic globals are ever removed.
- `BAG_UPDATE_DELAYED` keeps essence counts honest; `UNIT_INVENTORY_CHANGED` is filtered to the player.

Full detail in [CHANGELOG.md](CHANGELOG.md).

---

## Credits & license

Originally written by **[CaffeineAddiction](https://github.com/caffeineaddiction)**. TBC port by Bone.

MIT License, Copyright (c) 2024 CaffeineAddiction — see [license.txt](license.txt).
