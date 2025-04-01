#!/usr/bin/with-contenv bashio

source scripts/home-assistant.sh
source scripts/hypon.sh

#Names for Daily Sensors
declare SOLAR_PRODUCTION_SENSOR_NAME="sensor.solar_generated_today"
declare GRID_IMPORT_SENSOR_NAME="sensor.grid_import_today"
declare GRID_EXPORT_SENSOR_NAME="sensor.grid_export_amount"
declare ENERGY_CONSUMPTION_TODAY_SENSOR_NAME="sensor.energy_consumption_today"
declare SOLAR_USED_TODAY_SENSOR_NAME="sensor.solar_used_today"
declare BATTERY_USED_TODAY_SENSOR_NAME="sensor.battery_used_today"
declare SOLAR_CHARGE_USED_TODAY_SENSOR_NAME="sensor.solar_battery_charge_today"

#Names for Real Time Sensors
declare SOLAR_PRODUCTION_REAL_TIME_NAME="sensor.solar_energy_now"
declare GRID_IMPORT_REAL_TIME_NAME="sensor.grid_import_now"
declare SOLAR_USED_REAL_TIME_NAME="sensor.solar_used_now"

#Template Values for Daily Sensors
declare SOLAR_PRODUCTION_TODAY_TEMPLATE='{"state": "unknown", "attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Solar generated today"}}'
declare GRID_IMPORT_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Grid Import today"}}'
declare GRID_EXPORT_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Grid Export Amount"}}'
declare ENERGY_CONSUMPTION_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Energy Consumption today"}}'
declare SOLAR_USED_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Solar Used Today"}}'
declare BATTERY_USED_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Battery Used Today"}}'
declare SOLAR_CHARGE_USED_TODAY_TEMPLATE='{"state": "unknown","attributes": {"state_class": "total_increasing","unit_of_measurement": "kWh","device_class": "energy","friendly_name": "Solar to Battery Used Today"}}'

#Template Values for Real Time Sensors
declare SOLAR_PRODUCTION_REAL_TIME_TEMPLATE='{"state": "unknown","attributes": {"state_class": "measurement","friendly_name": "Solar Energy Realtime"}}'
declare GRID_IMPORT_REAL_TIME_TEMPLATE='{"state": "unknown","attributes": {"state_class": "measurement","friendly_name": "Grid Used Now"}}'
declare SOLAR_USED_REAL_TIME_TEMPLATE='{"state": "unknown","attributes": {"state_class": "measurement","friendly_name": "Solar Used Now"}}'

loadSensorData() {
  authToken=$1

  while true
  do
  	solarData=$(retrieveSolarData "$authToken")
  	realTimeData=$(retrieveRealTimeSolarData "$authToken")

  	solarDataResponseCode=$(echo $solarData | jq -r '.code')

    bashio::log.debug "Response Code From loading solar data: $solarDataResponseCode"

    if [ "$solarDataResponseCode" = "20000" ]; then
      bashio::log.debug "Data retrieved successfully: $solarData"

      bashio::log.info "Updating Daily Sensors"
      update-sensor "$SOLAR_PRODUCTION_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.kwhac')" $SOLAR_PRODUCTION_SENSOR_NAME
      update-sensor "$GRID_IMPORT_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.load_from_grid')" $GRID_IMPORT_SENSOR_NAME
      update-sensor "$GRID_EXPORT_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.pv_to_grid')" $GRID_EXPORT_SENSOR_NAME
      update-sensor "$ENERGY_CONSUMPTION_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.load')" $ENERGY_CONSUMPTION_TODAY_SENSOR_NAME
      update-sensor "$SOLAR_USED_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.load_from_pv')" $SOLAR_USED_TODAY_SENSOR_NAME
      update-sensor "$BATTERY_USED_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.load_from_bat')" $BATTERY_USED_TODAY_SENSOR_NAME
      update-sensor "$SOLAR_CHARGE_USED_TODAY_TEMPLATE" "$(echo "$solarData" | jq -r '.data.pv_to_bat')" $SOLAR_CHARGE_USED_TODAY_SENSOR_NAME

      bashio::log.info "Updating Real Time Sensors"
      update-sensor "$SOLAR_PRODUCTION_REAL_TIME_TEMPLATE" "$(echo "$realTimeData" | jq -r '.data.power_pv')" $SOLAR_PRODUCTION_REAL_TIME_NAME
      update-sensor "$GRID_IMPORT_REAL_TIME_TEMPLATE" "$(echo "$realTimeData" | jq -r '.data.meter_power')" $GRID_IMPORT_REAL_TIME_NAME
      update-sensor "$SOLAR_USED_REAL_TIME_TEMPLATE" "$(echo "$realTimeData" | jq -r '.data.power_load')" $SOLAR_USED_REAL_TIME_NAME

    else
      bashio::log.error "Data Retrieval Error - updating auth token"
      authToken=$(loginHypon)
    fi
  	sleep "$(bashio::config 'refresh_time')"
  done
}

bashio::log.info "Loading Authentication Token"
authToken=$(loginHypon)
loadSensorData "$authToken"
