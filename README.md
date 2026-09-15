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

No Git or GitHub account needed — this is a download-and-drag job. It takes about two minutes.

### Step 1 — Download it

1. Go to the [project page](https://github.com/bonedrums/EnchantClickablesTBC).
2. Click the green **`< > Code`** button near the top right.
3. Click **Download ZIP** at the bottom of the menu that drops down.

You'll get a file called `EnchantClickablesTBC-main.zip`.

### Step 2 — Unzip and rename the folder

> [!IMPORTANT]
> **The folder must end up named exactly `EnchantClickables`.** GitHub names it `EnchantClickablesTBC-main`, and WoW will silently ignore it under that name — the addon simply won't appear in game. This one rename is the step everybody misses.

**Windows:** Right-click the ZIP → **Extract All…** → **Extract**. Open the extracted folder. Inside you'll see *another* folder named `EnchantClickablesTBC-main` — that's the one you want. Right-click it → **Rename** → type `EnchantClickables`.

**Mac:** Double-click the ZIP in Finder (Safari may have already unzipped it into Downloads). You'll get a folder named `EnchantClickablesTBC-main`. Click it once, press <kbd>Return</kbd>, and type `EnchantClickables`.

You should now have a folder named `EnchantClickables` containing `EnchantClickables.toc`, `Init.lua`, and `EnchantList.lua`. If those files are buried one folder deeper, you renamed the wrong folder — go one level in.

### Step 3 — Drop it in your AddOns folder

Move the `EnchantClickables` folder into WoW's AddOns folder:

**Windows**
```
C:\Program Files (x86)\World of Warcraft\_classic_\Interface\AddOns\
```
Fastest route: open the Battle.net app, click **World of Warcraft**, click the **gear icon** next to the Play button, and choose **Show in Explorer**. From there open `_classic_` → `Interface` → `AddOns`.

**Mac**
```
/Applications/World of Warcraft/_classic_/Interface/AddOns/
```
Fastest route: in Battle.net click the **gear icon** next to Play → **Show in Finder**. From there open `_classic_` → `Interface` → `AddOns`.

> [!NOTE]
> `_classic_` is the Burning Crusade / Anniversary folder — the underscores on both ends are part of the name. Don't use `_retail_` or `_classic_era_`. If you don't see an `AddOns` folder inside `Interface`, just create one with that exact spelling.

When you're done it should look like this:

```
_classic_/
└── Interface/
    └── AddOns/
        └── EnchantClickables/
            ├── EnchantClickables.toc
            ├── Init.lua
            └── EnchantList.lua
```

### Step 4 — Turn it on

Fully quit WoW if it's running and start it again. (A `/reload` is **not** enough — the game only scans for new addon folders at launch.)

At the character select screen, click **AddOns** in the bottom left and make sure **Enchant Clickables** is checked. If it's greyed out or missing, tick **Load out of date AddOns** at the top.

### Checking it worked

Log in and open a trade with anyone. Have them put an enchantable item in the **"Will not be traded"** slot. The button list appears docked to the right of the trade window.

If nothing shows up, that's expected in two cases: you don't know any enchants for that item's slot, or you're missing the reagents. Try it with an item you know you can enchant.

### Updating later

Repeat the same steps and overwrite the old `EnchantClickables` folder when asked. Your settings live in the file itself, so there's nothing to back up.

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
