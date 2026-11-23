# RICE 1.21 manual test script

Goal: spot-check what the load test, the three game starts and the 30-year observer run can't show: districts in the holding view, start setups, decisions and wars that the 1.21 update changed. About 1.5 hours in three sessions. Steps marked **(optional)** can be skipped.

## 0. Preparation

- Build: `make build`, then install the built mod.
- Launch option `-debug_mode`. Playset: Unop, RICE. No other mods.
- Before each session, rename `error.log`. After it, save it as `error-manual-<session>.log`. I'll clean the logs with both `csv/vanilla_errors.csv` and `csv/rice_errors.csv`.
- Console: `effect <effects>` runs with your character as `root`. To end your wars as won at once: `effect every_character_war = { end_war = attacker }`.
- In debug mode, hovering a character shows their ID.

Watch for throughout:
- **Holding view:** a RICE special district shows its name, description, background and building. No raw keys such as `RICE_..._district`.
- **Raw loc keys**, missing icons and missing images.

## 1. 867: Guiyi Circuit and faiths (25 min)

Start **867** as the **Ganzhou Uyghur ruler**, who holds Heihe (`c_heihe`).

### 1.1 Guiyi Circuit (10 min)

- In the bookmark screen, RICE's bookmark shows **Cao Yijin** as Count of Liaoquan.
- In the game, Cao Yijin holds **Liaoquan** (`c_liaoquan`) as a vassal of Zhang Huaishen's Guiyi Circuit, and has the "Aspiration: Pacify the Guiyi Circuit" modifier. You still hold Heihe.
- **Li Mingzhen** (`han_40026`) has one wife, Jingde. His children are a single son named Hongding and his daughter by Jingde. Mingda and Mingchang are his brothers.
- **Pei Toutuo** is in the Dongjuan Pei house, and his father is Pei Xiu.
- **Mogao Caves:** the holding view of `b_mogao` (Dunhuang) shows the Mogao Caves special district.
- **(optional)** Repeat the Cao Yijin check without All Under Heaven.

### 1.2 Rites, traditions and holy sites (15 min)

- **Rite names:** open the "Uyghur Manichean Church" decision (`RICE_uyghur_manichean_church_decision`), or another RICE Manichean decision you see. Its texts name the Manichean and other rites, with no gaps where a name should be. Check the same text in one other language.
- **Trade traditions:** with Silk and Silver, the Uyghur, Tocharian, Sogdian and Saka cultures have vanilla's Silk Road Entrepreneurs, not RICE's People of the Silk Road, and the Malinke and Songhai have Saharan Traders, not Gold Dust Traders. The Bactrians, Khotanese and Radhanites still have People of the Silk Road. **(optional)** Without Silk and Silver, all of these have RICE's traditions, and the Uyghurs and Tocharians have no Caravaneers.
- **Tenets of rites:** in the faith view, the Mandaean rite has Communal Identity instead of Christian Syncretism, and the Valentinian rite has Christian Syncretism instead of Esotericism.
- **Restored holy sites:** the Meroitic (`meroitic_pagan`), Arabic pagan (`arabic_pagan`) and Bahnar (`bahnar_pagan`) faiths list the Napata (Meroe), Yamama and Preah Vihear holy sites, with names and modifiers. A faith with no adherents is missing from the religion view: convert yourself with `effect set_character_faith = faith:<key>`, check your own faith, and convert back.
- **Rome:** the Sawdan aspiration (held by the ruler of Bari) names Roma, not Vaticano, in its "Control Rome" objective.

## 2. 1066: Egypt, Sicily and Normandy (40 min)

Start **1066** as **Futuh al-Shami** (`RICE_fatimid_african_003`), whom RICE's Nubia setup makes Count of Qus and Duke of al-Said under the Fatimids.

### 2.1 Game start districts (10 min)

- **Qus** has the Luxor Church as its special district.
- **Duchy districts:** the Tiraz factories (Cairo, Ahvaz, Cordoba), Breton free range (Vannes) and dragon blood forest (Suq Socotra) are no longer placed at game start, since 1.21 can't create duchy districts by script (author question 2).
- **Vannes:** the Carnac Stones special district. **Nantes** has the Guerande Salterns county modifier, whose tax shows as a typed tax (e.g. commerce or maritime), not as a general tax.
- **Suq Socotra:** the Bawarij den.
- **Wadi Allaqi** (`b_allaqi`): the mine shows a monthly mining tax.

### 2.2 Luxor (10 min)

1. Run `effect add_prestige_level = 3 add_prestige = 2000 add_gold = 3000 add_piety = 3000 title:c_qus = { set_county_faith = root.faith }`. The "Rededicate Luxor Temple" decision costs major prestige, 1000 gold and 1000 piety. Take it. Qus now has the **Luxor Mosque**.
2. Run `effect set_character_faith = faith:miaphysitism title:c_qus = { set_county_faith = faith:miaphysitism } remove_global_variable = RICE_upper_egypt_luxor_changed_timer`. Take the decision again. Qus now has the **Luxor Church**.
3. Run the same command with `faith:hellenic_pagan`. Take the decision again. Qus now has the **Luxor Temple**.
4. `error.log` has no `add_special_district`, `add_building` or `remove_district_type` errors.

### 2.3 Characters and cultures (10 min)

- **Najahids:** in RICE's adventurer bookmark, Sa'id ibn Najah is 30 and his brother Jayyash 27. In the game, there is only one Sa'id. He holds only the Sons of Najah camp, or only Dahlak if he took it in RICE's game start event "Sa'id tries to betray the ruler of Dahlak" (`red_sea.0051`, an AI Sa'id takes it about half the time). Ali al-Sulayhi holds Zabid and Tihama, and Sa'id has the "Aspiration: Avenge Najah al-Mu'ayyid" modifier. His family is one Najahid dynasty with RICE's coat of arms: father Najah, siblings Mu'arik, adh-Dhakhirah and Jayyash.
- **Wuhsha al-Dallala:** there is only one, the Karimid merchant in Cairo, and RICE's adventurer bookmark no longer lists her.
- **Iceland:** the Icelandic counties and rulers have the Icelandic culture, with RICE's ethos and traditions (Communal; Things, Fishermen, Concubines, ...).
- **Sicily:** Trapani, Catania and Caltagirone have the Siqilli culture, like Palermo and Siracusa. Trapani is Sunni and has the Arab-Berber stronghold modifier, like Palermo and Agrigento. Roger (`1132`) has claims on Trapani and Caltagirone too. Taranto has the Greek stronghold modifier, like Bari.

### 2.4 Raids (10 min)

Border raids destroy a building in about 25% of the raided counties, more with more soldiers, so try each raid 2-3 times.

- **Sicilian frontier raid:** switch to a Muslim ruler on Sicily (restart, or play on from another game). Declare a Frontier Raid on a neighbor on the island, then end it as won with the console. The victory message lists a destroyed building for some raids, and that building is gone or downgraded in the holding view.
- **(optional) Norman border raid:** as William of Normandy, raid a neighbor (Norman Border Raid) and check the same.
- In both cases, `error.log` has no errors about `raid_province` or `destroyed_building`.
- The victory, white peace and defeat tooltips show the usual vanilla war end lines (truce, prestige for allies), with no raw keys.

## 3. 1178: Sicily, merchants and adventurers (20 min)

Start **1178** as **William II of Sicily**.

### 3.1 Catania statue (5 min)

- Catania is held by Manfred del Vasto in 1178. Run `effect get_title = title:c_catania add_prestige_level = 3 title:c_catania = { change_prosperity_level = 30 }`.
- The decision "Affirm U Liotru as the Symbol of Catania" is shown and valid. Its prosperity requirement names Catania, not Messina. Taking it raises Catania's prosperity.

### 3.2 Characters (10 min)

Find them with the character search:
- **Hugo von Hildesheim:** there is only one.
- **Guglielmo Grasso:** the Grasso merchant, without a camp, with the Viking (or Raider) trait and the "Mediterranean Pirate Connections" modifier.
- **Li Shichang, Mahmud Yalavach and al-Uzgandi:** each holds an adventurer title, not a noble family one, and has a camp. **(optional)** After a year, they still have their camps, and hovering their titles in debug mode shows no raw key.
- **(optional)** Hover a RICE adventurer's title and realm. The texts show the camp's name, not a raw `d_laamp_..._adj` key.

### 3.3 Activities (5 min)

- Open the activity planner and select the **Aachen pilgrimage**. Check whether the special option screen shows a raw `special_type` key.
- **(optional)** As a landless merchant (the vanilla merchant bookmark needs Silk and Silver), open the activity planner. RICE's pilgrimages and festivals near you are listed, or hidden, without errors.

## 4. Optional: longer activities (30 min)

- **North Atlantic grand expedition (1066):** send your heir on a grand expedition as its leader, then kill your ruler (`kill` in the console). The expedition ends early, and the return event names the leader, with the right text whether the leader is alive or not.
- **Hangzhou poetry gathering (1178):** host it with several guests. The other attendees get the winner's announcement (`hangzhou.0083`), and `error.log` has no errors from `hangzhou.0083` and `hangzhou.0085`.

## 5. After testing

- Send me the `error-manual-*.log` paths and I'll triage what's left.
- Note any UI issues (raw keys, missing images, wrong names) with a screenshot or the exact text.
