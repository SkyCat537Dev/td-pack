# td-pack

Server-Resourcepack für den TowerDefense-Server. Nur Texturen, kein Plugin-Code.

Ändert die Item-Tooltips: ein eigener Rahmen für alle Tooltips, plus je ein
farbiger Rahmen pro Rarity-Stufe. Die Farben entsprechen 1:1 dem `Rarity`-Enum
des Plugins.

| Stufe | Farbe |
|---|---|
| Common | `#b0b0b0` |
| Uncommon | `#55ff55` |
| Rare | `#55ffff` |
| Epic | `#c86bff` |
| Legendary | `#ffaa00` |
| Mythic | `#ff4d4d` |
| Godly | animiert, `#ff5edb` nach `#ffd24d` nach `#5effc9` |

## Einbinden

Direktlink für `server.properties` bzw. das Hoster-Panel:

```
https://raw.githubusercontent.com/SkyCat537Dev/td-pack/main/resourcepack.zip
```

```properties
resource-pack=https://raw.githubusercontent.com/SkyCat537Dev/td-pack/main/resourcepack.zip
resource-pack-sha1=ed876fabbc1591d3b0327294cef78adadbe675d2
```

Nach jeder Änderung an den Texturen muss `resourcepack.zip` neu gebaut und der
SHA1 aktualisiert werden.

## Aufbau

`assets/minecraft/textures/gui/sprites/tooltip/` ist der Standard-Rahmen für
jeden Tooltip. `assets/towerdefense/textures/gui/sprites/tooltip/` enthält die
sieben Rarity-Styles, die das Plugin über die `tooltip_style`-Item-Komponente
anspricht. `resourcepack.zip` ist genau dieser Ordner, gepackt.

Benötigt Client 1.21.2 oder neuer. Ältere Clients sehen den Vanilla-Tooltip.
