script_name('setWeather&Time')
script_description('/sw - change weather, /st - change time')
script_version_number(1)
script_version('v.001')
script_authors('kaplya')
script_dependencies('SAMP v0.3.7')

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

  sampRegisterChatCommand("st", cmdSetTime)
  sampRegisterChatCommand("sw", cmdSetWeather)
  while true do
    wait(0)
    if time then
      setTimeOfDay(time, 0)
    end
  end
end

function SetTime(ram)
	local hour = tonumber(ram)
	if hour ~= nil and hour >= 0 and hour <= 23 then
	time = hour
	patch(false)
	time = nil
	end
end

function SetWather(ram)
		local weather = tonumber(ram)
	if weather ~= nil and weather >= 0 and weather <= 45 then
		forceWeatherNow(weather)
	end
end

function patch(enable)
	if enable and default ==nil then
	default = readMenory(sampGetBase() + 0x9C0A0, 4, true)
	writeMemory(sampGetBase() + 0x9C0A0, 4, 0x000008C2, true)
	elseif enable == false and default ~= nil then
		writeMemory(sampGetBase() + 0x9C0A0, 4, default, true)
		default = nil
	end
end

