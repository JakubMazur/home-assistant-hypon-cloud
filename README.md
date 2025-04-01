# Hypon Cloud Addon for Home Assistant

This repository contains a Hypon cloud integration for Home Assistant.  This is provided without warrenty and is based on personal use only.

## Installation
1.) Clone this repository locally

2.) from the top level of the repository run `scp -r -O hypon-cloud [user]@[ip]:/addons`
    Note:: Please ensure you have the ssh plugin installed with sftp enabled.

3.) Navigate in your Home Assistant frontend to **Settings** -> **Add-ons** -> **Add-on Store** -> **Select 3 button menu** -> **Check for updates** 

4.) Install the Hypon Cloud Addon. Ensuring the following configuration is set:
    - `username` - Your Hypon Cloud username
    - `password` - Your Hypon Cloud password
    - `system_id` - The system ID of the Hypon device you wish to control (this can be found in the Hypon Cloud dashboard)
    - `refresh_time` - The time in seconds between each refresh of the Hypon Cloud Data

## Sensors 
The following sensors are available once the addon is installed:

### Daily Sensors
- `sensor.solar_generated_today` - The amount of solar energy generated today
- `sensor.grid_import_today` - The amount of energy imported from the grid today
- `sensor.grid_export_amount` - The amount of energy exported to the grid today
- `sensor.energy_consumption_today` - The total energy consumption today
- `sensor.solar_used_today` - The total amount of solar energy used today

### Real Time Sensors
- `sensor.solar_energy_now` - The amount of solar energy generated in real time
- `sensor.grid_import_now` - The amount of energy imported from the grid in real time
- `sensor.solar_used_now` - The amount of solar energy used in real time
