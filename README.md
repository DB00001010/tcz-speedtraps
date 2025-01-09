# TCZ Speedtraps

This script implements a speed trap system for FiveM servers using QB-Core. It allows the creation of speed trap zones across the map, rewarding or penalizing players based on their speed in specific areas. The script supports configurable zones, rewards, penalties, cooldowns, and notifications, providing an immersive and interactive feature for your server.

## Features

- **Speed Trap Zones**: Create multiple speed trap zones with configurable coordinates, radius, and speed thresholds.
- **Rewards & Penalties**: Configure actions for players based on their speed, including adding money for safe driving and removing money for speeding.
- **Cooldowns**: Prevent players from being penalized or rewarded repeatedly in a short period by using cooldowns for each trap.
- **Notifications**: Customizable messages to notify players of penalties, rewards, or cooldowns.
- **Blips**: Display blips on the map for each speed trap zone.
- **Restricted Plates**: Ability to exclude specific vehicles (e.g., emergency vehicles) from triggering speed traps.

## Installation

### Requirements
- **QB-Core**: This script depends on the QB-Core framework.
- **ox_lib**: This library is used for notifications and other utilities.

### Steps
1. Download and extract the script files to your server's `resources` folder.
2. Add the following lines to your `server.cfg` to start the script or just add it to you [qb] folder:

```   ensure tcz-speedtraps ```

Here is a preview:
https://www.youtube.com/watch?v=VRGBKmGN-zU
