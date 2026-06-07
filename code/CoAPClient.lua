--[[

InternetOfThings Sample Code:

This sample code gives coap access to a sensor and actuators

]]

--[[ Main function, program starts here ]]
function main(s)
	clearOutput();

	--[[ Make sure IP layers are up and running ]]
	waitForIpUp(ip2);

	--[[ Get address and port of sensor ]]
	local iotDeviceAdd, ok = inputBox("What's the CoAP sensor IP address?");

	if (string.len(iotDeviceAdd) == 0 or ok == false or isIpv4Address(iotDeviceAdd) == false) then
		print("error: not a valid IPv4 address");

		exit();
	end


	local iotDevicePort = getUdpPort(udp2);

	--[[ With address and port make URL ]]
	local url = string.format("%s:%d/temperature", iotDeviceAdd, iotDevicePort);

	print(string.format("sending request to %s...", url));

	--[[ Send CoAP observation request ]]
	local cmd = coapGetConfirmableObserve(coap2, url);

	--[[ Extract token out of command ]]
	local cmdToken = coapGetToken(cmd);

	--[[ Set counter ]]
	local ct = 0;

	while true do
		--[[ Get event on client side ]]
		local event = getEvent(coap2);

		--[[ Check if it is a response ]]
		if (isEventCoapResponse(event)) then
			--[[ Get token associated to event ]]
			local token = coapGetToken(event);

			--[[ If event token is same as command token ]]
			if (token == cmdToken) then
				--[[ Extract body/data part ]]
				local data = coapGetData(event);

				print(string.format("%d) response '%s' received", ct, data));

				--[[ Increase counter ]]
				ct = ct + 1;

				--[[ Up to 3 times ]]
				if (ct == 4) then
					break;
				end
			end
		end
	end

	--[[ Cancel observation now ]]
	coapGetConfirmableCancel(coap2, url, cmdToken);
end
