# RICE 1.20 manual test script

Goal: spot-check the areas changed by the 1.20 adaptation, where something is most likely to be broken. The total time is about 1.5-2 hours, in five sessions. Each step says what to do and what to expect. Anything marked **(optional)** can be skipped if time runs short.

## 0. Preparation (5 min)

- Launch options: `-debug_mode` (Steam > CK3 > Properties > Launch Options).
- Playset: Unop, RICE, Debug Toggle (optional). No other mods.
- DLC: make sure **Legends of the Dead** (legends) is enabled.
- Game rules: defaults, except where a session says otherwise.
- Console: open it with the backtick key. `effect ...` runs the effect with your character as `root`.
- In debug mode, hovering a character shows their ID. Write down the IDs you need.
- Before each session, delete or rename `error.log`. After each session, save it as `error-manual-<session>.log`. Clean it with `scripts/clean-errors.sh <file> csv/rice_errors.csv`, and note any RICE-related lines that are left.

General things to watch for throughout:
- **Raw loc keys:** text like `embera_pagan_priest`, `$beja_...$`, or `CHARACTER_HERHIS_...` instead of text.
- **Activity headers:** missing activity header images, which show as an empty header in the activity planner or window.
- **Queue icons:** missing icons in the event queue for fullscreen events.
- **CTD on load or start:** a crash on loading, or on starting any bookmark. All three loaded fine in the last runs.

## 1. 867: game start setup and religions (30 min)

Start **867**. In the lobby, pick **Faris of Hakkari** (`kurdish0001`, Count of Hakkari, Kurdish).

### 1.1 Game start conversions (5 min)

These failed silently before the last fixes. Check each character's faith and rite in the character window:

| Character | Where | Expected |
|---|---|---|
| Faris (`kurdish0001`), you | Hakkari | Faith Yazidi (`yazidi_faith`), rite **Mehrism**. His Kurdish vassals have the same rite. |
| Morteza (`baloch0001`) | Khawr (Baluchistan) | **Pudgalavada** (Sammitiya) Buddhist, as are his vassals and court. |
| Azur Jamshid (`RICE_pamir_013`) | Gilgit | Depends on his random choice in `pamir.0015` (Mazdayasna, Vajrayana, Nuristani, or Sunni/Hanafi). Any of these is fine. |
| Holder of `c_ranikot` (Sindh) | Sindh | Unchanged. This is the expected no-op until `RICE_bodah_001` is added. |

To find these characters, click their county on the map, or use the character search in the Find Character tab.

### 1.2 Yazidi faith and rites (10 min)

Open the Religion/Faith view for your faith (Yazidi):
- The faith should have **three rites**: Yazidi, Yarsani, Kurdish pagan (Mehrism). Each rite has a name, an icon and a description, with no raw keys.
- **Head of Faith:** title `d_yazidi`, shared by all three rites (open question 1).
- **Doctrines and tenets** of the Mehrism rite are listed and readable. Yarsani and Kurdish pagan keep vanilla tenets (open question 2).
- **Holy sites:** listed, with names. Modifier tooltips work (1.20 removed the `name` field, so there is no custom name).

### 1.3 Doctrine costs (5 min)

This checks the fix to `piety_cost`, which is evaluated in rite scope in 1.20. Open the **create or modify rite** screen for your faith, if it's available:
- Find the RICE "West Iranian" doctrine group (Yazidi/Yarsani/Kurdish pagan doctrines).
- The doctrine your rite already has should cost **0** piety. Switching to another one should show a non-zero cost: 2 steps between Yazidi and the others.
- The cost tooltip shows numbers, not errors or blanks.

If the screen isn't reachable, give yourself piety (`effect add_piety = 5000`) and try again. If it's still not reachable, skip this step. error.log will still show whether `has_doctrine` errors came back.

### 1.4 Browse other faiths for loc (10 min)

Check the description, god names, clergy titles and holy texts in the faith screen tooltips. Faiths with no counties are greyed out in the religion view, and faiths with no adherents at all are missing from it entirely. For those, convert yourself from the console, check your own faith screen, and convert back:

```
effect set_character_faith = faith:embera_religion
```

| Faith (in-game name) | Key | Religion | What to check |
|---|---|---|---|
| Jai | `embera_religion` | Andean | 80+ references fixed: god names, clergy, holy texts, afterlife (console) |
| Mandulism | `beja_pagan` | Kemetism | Creator, fate and night god names show "Mandulis" or "Amati", not `$beja_...$` |
| Nuragism | `sardinian_pagan` | Sardinian | Plural adherent name "Sardinians" |
| Chelidism, Yälfaathism | `palau_pagan`, `yap_pagan` | Micronesian | Spot-check (console) |
| Matutuoism, Wuon Cult, Worism | `fakfak_pagan`, `tehit_pagan`, `biak_pagan` | West Papuan | Spot-check (console if not on the map) |
| Wangarr, Palaneri, Djang | `yolngu_pagan`, `tiwi_pagan`, `bininj_pagan` | Indigenous Australian | Death deity name, house of worship (console) |
| Čimarij Jüla | `mari_pagan` | Mari | Death deity name, afterlife |
| Noaidevuohta | `sami_pagan` | Sami | Death deity name |
| Pazon Koy, Shkayism | `erzya_pagan`, `moksha_pagan` | Mordvin | Spot-check |

Remaining raw keys are expected in a few places that need the author's content, e.g. Fiji using Sami god names, or missing afterlife texts in some SEA and Micronesian faiths. Only note any that look different from that.

## 2. 1066: Sri Lanka (25 min)

Start **1066**. Play a Sri Lankan ruler who is involved in the Sri Lanka struggle, e.g. the holder of `d_ruhunu` or another Sinhala Buddhist ruler on the island.

### 2.1 Struggle window (5 min)

- Open the Sri Lanka struggle. The involved faiths should show proper names: Theravada, Mahayana, Vajrayana, Yakaism (the Vedda faith), Shaivism, Shaktism.
- The phase should be **Degeneration** (the historical default for 1066).
- The ending decisions (Unite the Sangha, Destroy the Sangha) are listed.

### 2.2 Monastery decisions, which had duplicate widgets (10 min)

- Take `RICE_sri_lanka_choose_monastic_sect` if it's shown.
- Open **Support Monastery** (`RICE_sri_lanka_support_monastery`) and **Persecute Monastery** (`RICE_sri_lanka_persecute_monastery`). Each should show **one** widget: the option list for picking a monastery, with the monastery prominence bars at the top (the option widget includes them). The separate, duplicate progress-bar widget was removed because 1.20 allows only one widget.
- Take Support Monastery once. Check that the option selection works and the prominence change is applied. The struggle window or decision tooltip shows the prominence values.

### 2.3 Fullscreen event and activity (10 min)

- Console: `event sri_lanka.0001`. This is the fullscreen intro event. Check the background and the **queue icon** (the 1.20 `queue_icon`). It shows in the vertical column of 56x56 icons at the left edge of the fullscreen event window, between two orange divider lines. For this event it's the Sri Lanka "Degeneration" struggle phase icon, a broken wooden Dharma wheel.
- Activity planner: open **Relic Veneration** or **Sri Pada Pilgrimage**. The header image should show. Start one, and if possible use `effect add_gold = 1000` and run it through. Check that the activity window header shows as well.

The ending itself was already tested (Unite the Sangha, with legend seed and single effect application). It doesn't need repeating.

## 3. 1066: North Atlantic and console checks (25 min)

Start **1066**. Play a Norse ruler involved in the Greenland struggle, e.g. the ruler of Iceland (Norse/Icelandic culture). If no one there is playable, use the King of Norway.

### 3.1 Greenland struggle and decisions, which had duplicate widgets (10 min)

- Open the Greenland struggle. The involved cultures and faiths show proper names, and the phase is shown.
- Open **Support Greenland** (`RICE_north_atlantic_support_greenland`), **Support Vinland** (`RICE_north_atlantic_support_vinland`) and **Explore the Americas** (`RICE_north_atlantic_explore_americas`), whichever are shown. Each should show **one** option-list widget, which includes the progress bars itself (the separate duplicate progress-bar widget was removed).
- Take one of them if it's available (`effect add_gold = 2000 add_prestige = 2000` helps). Check that the option picked takes effect.

### 3.2 Legend seeds via console (10 min)

The struggle endings are hard to reach in a short test, so call the restored legend seed effects directly:

```
effect RICE_north_atlantic_legend_seed_greenland_struggle_ending_effect = { ENDER = root STRUGGLE = RICE_greenland_struggle }
effect RICE_north_atlantic_legend_seed_greenland_struggle_sunset_invasion_ending_effect = { ENDER = root STRUGGLE = RICE_greenland_struggle }
```

Expected: no crash, and two legend seeds appear for your character in the Legends UI. Their name and description texts should render. The sunset invasion one mentions your culture. If the console rejects the parameterized syntax, skip this step and note it.

### 3.3 Other quick console checks (5 min, optional)

- `event north_atlantic.0001`, or any other North Atlantic fullscreen event you see. Check the queue icon.
- Activity planner: open any RICE activity available to you and check that the header image shows.

## 4. Activity headers in 1178 (20 min)

Start **1178** as the **King of Sicily (William II)**. This is a throwaway game: you'll change your faith, rite and culture from the console to meet each activity's prerequisites. For each activity, open the activity planner, check that the activity is listed, that its **header image** shows, and that its description has no raw keys. Starting the activity is optional; its location may not be valid for you.

| Activity | Prerequisite | Console |
|---|---|---|
| Monte Gargano Pilgrimage | Christian, capital in southern Italy | none, William II meets it |
| Kinnaur Flower Festival | Faith Kinnaur pagan | `effect set_character_faith = faith:kinnaur_pagan` |
| Yazidi Tawus Geran | Yazidi rite | `effect set_character_rite = rite:yazidi` |
| Yarsani Jam | Yarsani rite | `effect set_character_rite = rite:meshefaresism` |
| Fichee-Chambalaalla Festival | Sidamic religion | `effect set_character_faith = faith:sidama_pagan` |
| Sasi Ceremony | Culture has the Sasi innovation | `effect culture = { add_innovation = innovation_RICE_sasi }` |

- **Sasi Ceremony:** its description should name the **water/land** Sasi modifiers, not a broken modifier link.
- **(optional) Magadha:** `effect set_character_faith = faith:mahayana_faith`. Check that the **Observe Vassa** (`RICE_magadha_observe_vassa`) and **Donate to Nalanda/Mahabodhi** decisions show and that their tooltips are readable. They may also need a location in Magadha, so if they don't show, skip this.

## 5. RICE landless adventurers (15 min)

The beta release lists "RICE's new landless adventurers are not playable" as a known issue. The likely cause is that the beta replaced `landless = yes` (and the other landless title fields) with `dlc_feature = roads_to_power` on all 88 RICE adventurer titles, so they were no longer landless titles. These fields have been restored next to `dlc_feature`, as vanilla 1.20 has them. This step checks that the fix works.

Requires the **Roads to Power** DLC.

### 5.1 Bookmark adventurers (10 min)

1. Start a new game at **867** and open the bookmark list. Look for the RICE adventurer bookmark ("Landless Western" group, `bm_867_rice_4`), with Hrolfr/Rollo, Thabit ibn Qurra and Ibn Wahshiyya.
   - If the RICE adventurer bookmarks **don't appear at all**, note it. They use `requires_dlc_flag = landless_playable`, while vanilla 1.20 uses `landless_adventurer`, which would be the next suspect.
2. Select **Thabit ibn Qurra** and check that **Play** is enabled. Start the game.
3. Once in the game, check:
   - Your character is a landless adventurer. The government is Landless Adventurer, you have a camp (domicile) and the camp/contract UI is available.
   - The primary title is `d_laamp_RICE_thabit_ibn_qurra`, a landless title with its proper name (not "Duchy of ..."), shown at the capital Baghdad.
   - The camp is located near Baghdad, and travel and contracts work. Accept or browse one contract.
4. **(optional)** Repeat quickly with one adventurer from **1066** (e.g. Constantine the African or Tzachas) or **1178** (e.g. Michael Scot or Margaret of Beverley). Just check that Play works and the character starts as an adventurer.

### 5.2 Non-bookmark adventurers (5 min)

- In any game, find an AI-held RICE adventurer, e.g. Ibn Wahshiyya (`d_laamp_RICE_ibn_wahshiyya`) in 867, through the character search or their capital (Basra). Check that they show as a landless adventurer with a camp, not as a duke without land.
- **(optional)** In debug mode, a few years in, check that RICE adventurers haven't disappeared right after game start. They have `destroy_if_invalid_heir = yes`, but should only be destroyed on succession.

## 6. After testing

- Collect the `error-manual-*.log` files and clean them with `csv/rice_errors.csv`. Send me the paths and I'll triage what's left.
- Note any UI issues (raw keys, missing images, wrong names) with a screenshot or the exact text.
- Areas known to be untested: AI behavior over time is covered by the observer runs, and the other struggle endings (Greenland, Sicily, Normandy) only by the console checks above.
