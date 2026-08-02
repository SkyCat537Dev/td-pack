# td-pack

Server resource pack for the TowerDefense server. Textures and one font, no
plugin code.

It restyles item tooltips: one custom frame for every tooltip, plus a coloured
frame per rarity tier. The colours match the plugin's `Rarity` enum exactly.

| Tier | Colour |
|---|---|
| Common | `#b0b0b0` |
| Uncommon | `#55ff55` |
| Rare | `#55ffff` |
| Epic | `#c86bff` |
| Legendary | `#ffaa00` |
| Mythic | `#ff4d4d` |
| Godly | animated, `#ff5edb` to `#ffd24d` to `#5effc9` |

## Usage

Direct link for `server.properties` or a host panel:

```
https://raw.githubusercontent.com/SkyCat537Dev/td-pack/main/resourcepack.zip
```

```properties
resource-pack=https://raw.githubusercontent.com/SkyCat537Dev/td-pack/main/resourcepack.zip
resource-pack-sha1=8f40b55b4f22a9b13a446af1f743166775bbfe5a
```

Whenever the textures change, rebuild `resourcepack.zip` and update the SHA1.
The server hands the client a stale file otherwise and the download is rejected.

## Layout

`assets/minecraft/textures/gui/sprites/tooltip/` is the default frame, applied
to every tooltip in the game. `assets/towerdefense/textures/gui/sprites/tooltip/`
holds the seven rarity styles, which the plugin selects through the
`tooltip_style` item component. `resourcepack.zip` is this folder, zipped.

## The small font

`assets/towerdefense/font/small.json` is the lore font behind the plugin's
`Settings -> Tooltips` option, at `towerdefense:small`. It pulls the vanilla
default in whole and redraws only the Latin bitmap on top of it at `height: 7`
against vanilla's 8, so every glyph that is not plain ASCII, the currency
symbols and the trait icons among them, still comes from vanilla and is still
drawn.

`height` is the one knob and 7 is deliberately mild: those symbols come from the
`unihex` provider, which has no height, so they cannot be scaled along with the
letters and the further this drops the further the two drift apart on one line.

**This file is not optional once the plugin offers the setting.** Minecraft does
not fall back to the default font for a font id it cannot find, it builds an
empty one, and every character then draws as the missing-glyph box. The plugin
guards its own half by only naming the font for a player who has actually
applied this pack, but a pack that is applied and does not contain this file is
exactly the case that guard cannot see. Delete the setting before deleting the
font.

## Building the zip

Run `build-pack.bat` (or `build-pack.ps1` directly). It prints the SHA1 that goes
into `server.properties`, and it refuses to print one for a zip it could not
build correctly.

Do **not** rebuild it with `Compress-Archive`: on Windows PowerShell 5.1 that
writes entry names with backslash separators, and a Minecraft pack built that
way is not a broken pack, it is an empty one. The client accepts it, finds
nothing at any path it looks for, and every custom frame quietly reverts to
vanilla with no error anywhere. Zip entry names are POSIX paths, always.

On a machine with the `zip` binary this is the same thing:

```sh
zip -r resourcepack.zip assets pack.mcmeta pack.png
sha1sum resourcepack.zip
```

Requires client 1.21.2 or newer. Older clients fall back to the vanilla tooltip,
which is a silent no-op rather than an error.
