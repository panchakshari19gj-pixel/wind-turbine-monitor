channelID = 3596991;                 % your channel ID
writeKey  = 'YOUR_WRITE_API_KEY';   % your write key

N = 200;
k = (1:N)';
t = datetime('now') - minutes(N:-1:1)';   % one point per minute, ending now

% Wind with a daily-like cycle plus gusts
windSpeed = 8 + 4*sin(2*pi*k/60) + 1.5*randn(N,1);
windSpeed = max(windSpeed, 0);

% Rotor speed saturates at 18 RPM
rotorRPM = min(18, 1.4*windSpeed) + 0.2*randn(N,1);

% Power curve: cut-in 3 m/s, rated 2000 kW
power = min(2000, 1.15*windSpeed.^3) + 20*randn(N,1);
power(windSpeed < 3) = 0;
power = max(power, 0);

% Pitch only activates above rated wind speed (~12 m/s)
pitch = max(0, (windSpeed - 12)*4) + 0.2*randn(N,1);

% Gearbox temperature lags behind power (thermal inertia)
gearTemp = 40 + 0.012*movmean(power, 10) + 0.3*randn(N,1);

% Vibration depends on rotor speed
vib = 1.5 + 0.08*rotorRPM + 0.2*randn(N,1);

% Yaw misalignment
yawErr = 4*randn(N,1) + 2*sin(k/15);

% Inject a developing gearbox fault in the last 50 points
idx = 151:N;
vib(idx)      = vib(idx)      + linspace(0, 4, numel(idx))';
gearTemp(idx) = gearTemp(idx) + linspace(0, 12, numel(idx))';

% Health index falls as vibration and temperature rise
health = 100 - 8*max(0, vib-3) - 0.8*max(0, gearTemp-60) - 0.5*abs(yawErr);
health = min(100, max(0, health));

TT = timetable(t, windSpeed, rotorRPM, power, gearTemp, vib, pitch, yawErr, health);

thingSpeakWrite(channelID, TT, 'WriteKey', writeKey);
disp('Bulk write complete');