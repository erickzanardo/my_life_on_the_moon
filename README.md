# My Life on the Moon

Game `My Life on the Moon`, entry for the [GitHub Game Off 2020](https://itch.io/jam/game-off-2020)

Color palette: https://lospec.com/palette-list/16-bital

## Contributing

Planned tasks are found on the issues of the repository, assign one for yourself and submit the PR.

## Code Organization

This is a Jam game, so code is not the most organized as it could be, but keep to the following rules so we can try to keep it the most organized possible

 - All game logic stays on `game/game_state`
 - Which context of the game logic is a mixin, Station, People, Time and etc, all have its own mixin, new contexts should do the same
 - Anything related to rendering is a component and is under `game/components`, the same things applies to interaction, like the code for clicking on a station, should be on the `StationsComponent`
