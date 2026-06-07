--[[

TcpClient Sample Code:

This sample code executes a TCP HTTP GET request
to obtain a web page

]]

--[[ Main function, program starts here ]]
function main(s)
	clearOutput();

	--[[ Make sure IP layer is up and running ]]
	waitForIpUp(ip);

	--[[ Set website name ]]
	local webserver = "itcorp.com"; -- oldest website still in service since 1986

	--[[ Resolve IP address ]]
	local address = resolveAddress(webserver);

	print(string.format("Attempting to connect to %s (%s) from %s", webserver, address, getIpAddress(ip)));

	--[[ Attempt to connect ]]
	tcpConnect(tcp, address, 80);

	while true do
		--[[ Let's check for events on TCP ]]
		local event = getEvent(tcp);

		if isEventTcpConnected(event) then
			local session = getEventId(event);

			print(string.format("connected to %s as session %s", webserver, session));

			--[[ Set local session to session ]]
			setSession(session);

			break;
		end
	end

	--[[ Send  HTTP request ]]
	send(raw, "GET / HTTP/1.1\r\nHost: " .. webserver .. "\r\nConnection: keep-alive\r\n\r\n");

	--[[ Infinite loop waiting for events ]]
	while true do

		local var, ok = recv(raw);

		if (ok == false) then
			print("TCP connection " .. getSession() .. " has been terminated.\n");

			break;
		end

		if string.len(var) > 0 then
			--[[ Show page ]]
			messageBox(var);
		end
	end

	--[[ Session Finished ]]
end
