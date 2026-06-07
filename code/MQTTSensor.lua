--[[

MQTT Sample Code:

This sample code start an MQTT sensor

]]

--[[ Main function, program starts here ]]
function main(s)
	clearOutput();

	--[[ Make sure IP layers are up and running ]]
	waitForIpUp(ip);

	local address, ok = inputBox("What's the MQTT broker IP address?");

	if (string.len(address) == 0 or ok == false or isIpv4Address(address) == false) then
		print("error: not a valid IPv4 address");

		exit();
	end

	--[[ Assign IP address ]]
	setMqttUrl(mqtt, address);

	--[[ Enable MQTT publishing of sensor data ]]
	setMqttEnablePublish(mqtt, true);

end
