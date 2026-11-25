# Wind Turbine Health Monitor (ThingSpeak + MATLAB)

Simulated condition-monitoring data for a 2 MW wind turbine, sent to a
ThingSpeak channel and visualized with MATLAB. The last 50 samples include
an injected gearbox fault.

Channel: https://thingspeak.mathworks.com/channels/3596991

## Fields
1 Wind speed (m/s) | 2 Rotor speed (RPM) | 3 Power (kW) | 4 Gearbox temp (°C)
5 Vibration (mm/s) | 6 Blade pitch (deg) | 7 Yaw error (deg) | 8 Health index

## How to run
1. Create a ThingSpeak channel with the 8 fields above.
2. Put your Channel ID and Write API Key in `generate_data.m` and run it
   in MATLAB Analysis.
3. Put your Read API Key in `visualize_data.m` and run it in MATLAB
   Visualizations.

Author: Panchakshari G J