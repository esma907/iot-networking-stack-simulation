--[[

mDNS Sample Code:

This sample code creates an mDNS responder tied to a SIP server

The mDNS IP address and port are shown on the screen once the script starts.

]]

--[[ Main function, program starts here ]]
function main(s)
	clearOutput();

	--[[ Make sure IP layer is up and running ]]
	waitForIpUp(ip);

	--[[ Let's pop up a message with the SIP listening ip:port  ]]
	print(string.format("\nThe mDNS responder address:port is %s:%d.\n\nYou can now issue a PTR query for _sip._udp.local.\n", getIpAddress(ip),getUdpPort(udpmDns)));

end