channelID = 3596991;                 % your channel ID, no quotes
readKey   = 'YOUR_READ_API_KEY';    % your read key, inside quotes

[d, t] = thingSpeakRead(channelID, 'Fields', 1:8, 'NumPoints', 200, ...
                        'ReadKey', readKey);

wind = d(:,1); power = d(:,3); temp = d(:,4);
vib = d(:,5); health = d(:,8);

subplot(2,2,1);
yyaxis left;  plot(t, wind);  ylabel('Wind (m/s)');
yyaxis right; plot(t, power); ylabel('Power (kW)');
title('Wind vs power'); grid on;

subplot(2,2,2);
scatter(wind, power, 12, 'filled');
xlabel('Wind (m/s)'); ylabel('Power (kW)');
title('Power curve'); grid on;

subplot(2,2,3);
yyaxis left;  plot(t, vib);  ylabel('Vibration (mm/s)');
yyaxis right; plot(t, temp); ylabel('Gearbox temp (°C)');
title('Fault indicators'); grid on;

subplot(2,2,4);
plot(t, health, 'k'); hold on;
yline(60, 'r--', 'Alert threshold');
ylabel('Health index'); title('Turbine health'); grid on;