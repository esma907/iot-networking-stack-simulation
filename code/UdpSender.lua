--[[

UdpSender Sample Code:

This sample code sends a single UDP datagram to 10.38.181.1:6000

]]

--[[ Main function, program starts here ]]
function main(s)
	clearOutput();

	--[[ Make sure IP layer is up and running ]]
	waitForIpUp(ip);

	--[[ Let's pop up a message with the local ip:port  ]]
	print(string.format("\nCurrent address:port is %s:%d...", getIpAddress(ip),getUdpPort(udp)));

	--[[ Setup destination ip address and port ]]
	setIpDestAddress(ip, "192.168.21.5");
	setUdpDestPort(udp, 6000);

	--[[ Send datagram now ]]
	send(udp, "raw data being sent!\n");
end