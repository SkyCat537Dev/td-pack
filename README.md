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
resource-pack-sha1=a0dffcf3155905bd6df22ce66201775496978ed3
```

Whenever the textures change, rebuild `resourcepack.zip` and update the SHA1.
The server hands the client a stale file otherwise and the download is rejected.

## Layout

`assets/minecraft/textures/gui/sprites/tooltip/` is the default frame, applied
to every tooltip in the game. `assets/towerdefense/textures/gui/sprites/tooltip/`
holds the seven rarity styles, which the plugin selects through the
`tooltip_style` item component. `resourcepack.zip` is this folder, zipped.

## No fonts here, on purpose

A `towerdefense:small` lore font briefly lived at
`assets/towerdefense/font/small.json`, to make the plugin's long tooltips fit on
a screen at a high GUI scale. It is gone and should not come back, for two
reasons that no amount of tuning fixes.

It cannot make a tooltip shorter. **Minecraft spaces tooltip lines at a fixed
height whatever font they are drawn in**, so a smaller font is narrower and
exactly as tall, which was never the complaint.

And it cannot draw the plugin's own text. The currency symbols, the trait icons
and the `▰` progress bars all come from the vanilla `unihex` provider, which has
no height to scale and no place in a redrawn ASCII bitmap, so in practice they
arrive as missing-glyph boxes and every stat row stops being readable.

The plugin cuts lore lines itself instead (`Settings -> Tooltips`), which needs
nothing from this pack.

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
