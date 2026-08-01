# td-pack

Server resource pack for the TowerDefense server. Textures only, no plugin code.

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
resource-pack-sha1=ed876fabbc1591d3b0327294cef78adadbe675d2
```

Whenever the textures change, rebuild `resourcepack.zip` and update the SHA1.
The server hands the client a stale file otherwise and the download is rejected.

## Layout

`assets/minecraft/textures/gui/sprites/tooltip/` is the default frame, applied
to every tooltip in the game. `assets/towerdefense/textures/gui/sprites/tooltip/`
holds the seven rarity styles, which the plugin selects through the
`tooltip_style` item component. `resourcepack.zip` is this folder, zipped.

## Building the zip

From the repository root:

```sh
zip -r resourcepack.zip assets pack.mcmeta pack.png
sha1sum resourcepack.zip
```

Requires client 1.21.2 or newer. Older clients fall back to the vanilla tooltip,
which is a silent no-op rather than an error.
