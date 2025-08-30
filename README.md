# Hypon Cloud Addon for Home Assistant

This repository contains a Hypon cloud integration for Home Assistant.  This is provided without warranty and is for personal use only.

## Installation

### Method 1: Add-on Repository

1.	In Home Assistant go to: Settings → Add-ons → Add-on store → ⋮ → Repositories
2.	Paste this URL:
```https://github.com/amckee23/home-assistant-hypon-cloud```
3. Find **Hypon Cloud** under “Local Add-ons” (or the repo name) and click **Install**.

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Famckee23%2Fhome-assistant-hypon-cloud)

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FJakubMazur%2Fhome-assistant-hypon-cloud)

### Method 2: Manual Installation

1. Clone this repository to your local machine:
git clone https://github.com/amckee23/home-assistant-hypon-cloud hypon_cloud
cd into the hypon_cloud folder

2. from the top level of the repository run `scp -r -O hypon-cloud [user]@[ip]:/addons`
    Note:: Please ensure you have the ssh plugin installed in home assistant with sftp enabled.  Instructions can be found [here](https://community.home-assistant.io/t/home-assistant-community-add-on-ssh-web-terminal/33820)

3. Navigate in your Home Assistant frontend to **Settings** -> **Add-ons** -> **Add-on Store** -> **Select 3 button menu** -> **Check for updates** 

4. Install the Hypon Cloud Addon. Ensuring the following configuration is set:
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
