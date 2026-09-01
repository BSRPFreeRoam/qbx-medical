# qbx_medical

`qbx_medical` is the shared medical system for QBX. It tracks player health, armor, injuries, bleeding, last stand, and deceased states.

Other resources—such as items, jobs, hospital beds, and treatment systems—should use this resource's exports, callbacks, and events instead of changing medical state directly.

## Features

- Injury and wound tracking by body part
- Bleeding, blackout, fade-out, and pain effects
- Armor tracking and damage handling
- Critical/last-stand and deceased states
- Crawl movement while in critical state
- One-minute critical-state countdown by default
- Automatic AI paramedic revival when no EMS is on duty
- Respawn and revival hooks for hospital and job resources
- Medical status data for UI and treatment systems

## Medical states

### Critical state

The player is down but not fully deceased. They can crawl, wait for EMS, or be helped by the AI paramedic when the critical timer expires and no EMS is on duty.

![Critical state](https://github.com/user-attachments/assets/a3d61ee1-b216-4da2-a803-b3dd4c883aa1)

### Deceased state

The player has bled out or entered the deceased state. They remain incapacitated until revived or until the respawn rules allow them to respawn.

![Deceased state](https://github.com/user-attachments/assets/4f7c68bb-1d13-4b18-b4a3-92c7a051613e)

## Configuration

Client configuration is located at `config/client.lua`:

```lua
laststandReviveInterval = 60, -- Critical-state timer, in seconds
deathTime = 300,               -- Deceased-state timer, in seconds
aiReviveEnabled = true,        -- AI revival when no EMS is on duty
```

Set `aiReviveEnabled = false` if players should always bleed out when EMS is unavailable.

## Server exports

```lua
exports.qbx_medical:Revive(playerId)
exports.qbx_medical:Heal(playerId)
exports.qbx_medical:HealPartially(playerId)
local status = exports.qbx_medical:GetPlayerStatus(playerId)
```

`GetPlayerStatus` returns injury information, bleed level, bleed state, and recorded damage causes.

## Client exports

```lua
exports.qbx_medical:IsDead()
exports.qbx_medical:IsLaststand()
exports.qbx_medical:GetDeathTime()
exports.qbx_medical:GetLaststandTime()
exports.qbx_medical:StartLastStand(attacker, weapon)
exports.qbx_medical:KillPlayer()
exports.qbx_medical:PlayDeadAnimation()
exports.qbx_medical:MakePedLimp()
exports.qbx_medical:SendBleedAlert()
```

Damage, bleeding, respawn, and injury-effect controls are also available through the resource's client exports.

## Events

Useful client events include:

```lua
qbx_medical:client:onPlayerLaststand
qbx_medical:client:onPlayerDied
qbx_medical:client:playerRevived
qbx_medical:client:heal
```

Resources listening for these events should keep their handlers lightweight and avoid directly changing the player's medical metadata.

## Dependencies

The resource is designed for the QBX stack and requires the dependencies declared in `fxmanifest.lua`, including `qbx_core`, `ox_lib`, and `ox_inventory`.

## Installation

1. Place `qbx_medical` in the `[qbx]` resources folder.
2. Ensure its dependencies start first.
3. Add `ensure qbx_medical` to the server configuration.
4. Restart the resource after changing `config/client.lua`.

## Notes for developers

Use `qbx_medical` as the single source of truth for medical state. Hospital, ambulance, treatment, and item resources should call the exports above rather than setting `isdead`, `inlaststand`, health, or injuries manually.
