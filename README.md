# Enchant Clickables <sub><sup>TBC</sup></sub>

**Stop typing `/cast Enchant Bracer - Superior Strength`.** Open a trade, and every enchant you can actually cast on the customer's item appears as a one-click button beside the trade window.

For **WoW Anniversary (2.5.6)**. A fork of [caffeineaddiction/EnchantClickables](https://github.com/caffeineaddiction/EnchantClickables), itself a port of a Notorious clickable WeakAura.

<img width="752" height="323" alt="The enchant list docked to the right of the trade window" src="https://github.com/user-attachments/assets/50215a78-1f0f-47c5-b3b1-13062aff9914" />

## How it works

When your customer drops an item in the **"Will not be traded"** slot, the addon reads its equip location, pulls every enchant for that slot from a table of ~190 spells, and filters to the ones you know *and* have reagents for. Whatever survives becomes a button. So if you can see it, it will work.

Clicking casts the enchant **and** applies it to their item, so you never chase the targeting cursor. If the item is already enchanted, the game's usual **"Replace enchant?"** confirmation still appears — and your partner gets a whisper asking them to confirm first. Nothing is overwritten silently.

Two extras share the list: **essence splitting and joining** (all six types — green when you have enough, red when you don't) and **lockpicking**, since lockboxes register as an enchantable slot.

Covers chest, bracer, boots, gloves, cloak, shield, and all weapon slots. No setup, no slash commands — it only exists while a trade is open.

<details>
<summary><b>Options & technical notes</b></summary>

<br>

Set `AUTO_APPLY = false` at the top of `Init.lua` to cast without auto-applying, leaving the targeting cursor up like the original addon.

The port's main fix: on this client the buttons did nothing, because the game only processes the click phase matching `useOnKeyDown` (the `ActionButtonUseKeyDown` CVar, on by default) and a plain button registers only `LeftButtonUp` — so every click was silently swallowed. Buttons now register both phases and fire once on release. Also: buttons are pooled rather than leaked on every trade event, and refreshes defer out of combat lockdown. Full detail in [CHANGELOG.md](CHANGELOG.md).

</details>

## Installing

No Git or GitHub account needed — it's a download-and-drag job, about two minutes.

**1. Download.** Click the green **`< > Code`** button at the top of this page → **Download ZIP**.

**2. Unzip, then rename the folder to `EnchantClickables`.**

> [!IMPORTANT]
> GitHub names the folder `EnchantClickablesTBC-main`, and WoW silently ignores it under that name — the addon just won't show up. **This is the step everybody misses.** You want a folder named `EnchantClickables` containing `EnchantClickables.toc`, `Init.lua`, and `EnchantList.lua`. If those files sit one level deeper, you renamed the outer folder; go in one.

**3. Move that folder into your AddOns directory:**

| | |
|---|---|
| **Windows** | `C:\Program Files (x86)\World of Warcraft\_anniversary_\Interface\AddOns\` |
| **Mac** | `/Applications/World of Warcraft/_anniversary_/Interface/AddOns/` |

To get there quickly, open Battle.net, select **World of Warcraft**, set the version dropdown to **WoW Anniversary**, then click the gear icon next to Play → **Show in Explorer / Finder**.

> [!NOTE]
> Your WoW directory holds several `_folders_` side by side and they are **not** interchangeable — `_classic_era_` is Classic Era, `_classic_` is progression Classic, `_retail_` is modern WoW. Only `_anniversary_` works here. If `Interface` has no `AddOns` folder, create one with that exact spelling.

**4. Fully restart WoW** — `/reload` won't do, since the game only scans for new addon folders at launch. Then open a trade and have someone put an enchantable item in the "Will not be traded" slot.

If no buttons appear, that's expected when you don't know any enchants for that item's slot or you're out of reagents — try an item you're sure you can enchant. To update later, just overwrite the folder.

## Credits & license

Originally written by **[CaffeineAddiction](https://github.com/caffeineaddiction)**. TBC port by Bone.

MIT License, Copyright (c) 2024 CaffeineAddiction — see [license.txt](license.txt).
