# IoT Networking Stack Simulation — Track B
**Course:** COM0453 Internet of Things  
**Instructor:** Mehmet F. Yuce  
**Institution:** Istanbul Kultur University  
**Student:** Esma Sümer  
**Date:** June 2026

---

## Project Overview

This project implements five foundational IoT networking protocol examples
inside the **Netualizer** simulation framework, as required by Track B.
Each example covers a different layer of the IoT networking stack and is
documented with setup instructions, expected output, and engineering analysis.

| # | Example | Protocol | File |
|---|---------|----------|------|
| 1 | TCP Client (HTTP GET) | TCP / DNS | `TcpClient.lua` |
| 2 | MQTT Sensor (pub/sub loop) | MQTT over TCP | `MQTTSensor.lua` |
| 3 | CoAP Client (sensor query) | CoAP over UDP | `CoAPClient.lua` |
| 4 | UDP Sender (datagram) | UDP | `UdpSender.lua` |
| 5 | mDNS Responder (zero-config) | mDNS / UDP multicast | `mDNS.lua` |

Two supplementary scenarios are also documented in the report:
- **Data Logging & Timestamps** — observed via the Netualizer Events panel
- **Failure Injection** — gateway omission, agent absence, LoRa PHY fault

---

## Requirements

- **Netualizer** (Controller + Agent) — download from https://www.l7tr.com/site/netualizer
- No additional libraries or external hardware required
- All examples run fully inside the Netualizer simulation environment

---

## How to Run Each Example

### Setup (applies to all examples)
1. Install and launch Netualizer Controller
2. Start at least one Netualizer Agent
3. Open the relevant project folder inside Netualizer
4. Apply the network configuration described below
5. Run the corresponding `.lua` script

---

### Example 1 — TCP Client

**File:** `TcpClient.lua`  
**Layer chain:** `phy → ethernet → ip → tcp → raw`  
**Network config:** IP auto-assigned (e.g. `192.168.21.10`), default gateway set  

**Run:**
1. Open the `TcpClient` project in Netualizer
2. Run `TcpClient.lua`
3. Observe the Output panel

**Expected output:**
```
Attempting to connect to itcorp.com (134.173.42.59) from 192.168.21.10
TcpClient.lua [entry:main, priority:1]
```

---

### Example 2 — MQTT Sensor

**File:** `MQTTSensor.lua`  
**Layer chain:** `phy → ethernet → ip → tcp → mqtt`  
**Network config:** Static IP `192.168.21.20`, gateway `192.168.21.1`  
**Broker:** `91.121.93.94` (public sandbox)

**Run:**
1. Open the `MQTTSensor` project in Netualizer
2. Set static IP to `192.168.21.20` in the config
3. Run `MQTTSensor.lua`
4. Observe the Events panel for continuous `dataup 42` entries

**Expected output:**
```
done (0) <= MQTTSensor.lua
Events panel: Fri 06/05/2026 10:1x:xx — dataup 42 (repeating)
```

---

### Example 3 — CoAP Client

**File:** `CoAPClient.lua`  
**Layer chain:** `phy → ethernet → ip → udp → coap`  
**Target sensor:** `192.168.21.30:5683`

**Run:**
1. Open the `CoAPClient` project in Netualizer
2. Run `CoAPClient.lua`
3. Enter `192.168.21.30` when prompted for the sensor IP

**Expected output:**
```
sending request to 192.168.21.30:5683/temperature...
CoAPClient.lua [entry:main, priority:1]
```

---

### Example 4 — UDP Sender

**File:** `UdpSender.lua`  
**Layer chain:** `phy → ethernet → ip → udp`  
**Source:** `192.168.21.30:5000` → **Destination:** `192.168.21.5:6000`

**Run:**
1. Open the `UdpSender` project in Netualizer
2. Run `UdpSender.lua`

**Expected output:**
```
Current address:port is 192.168.21.30:5000...
done (0) <= UdpSender.lua
```

---

### Example 5 — mDNS Responder

**File:** `mDNS.lua`  
**Layer chain:** `phy → ethernet → ip → udp → rtp → player`  
**Bind address:** `192.168.21.18:5353`

**Run:**
1. Open the `mDNS` project in Netualizer
2. Run `mDNS.lua`

**Expected output:**
```
The mDNS responder address:port is 192.168.21.18:5353
You can now issue a PTR query for _sip._udp.local
done (0) <= mDNS.lua
```

---

## Report

The full technical report (PDF + LaTeX source) is located in the `report/` folder.
It includes theoretical background, architecture diagrams, code walkthroughs,
results analysis, protocol comparison matrix, and security threat model for
each example.

---

## Notes

- Static IP assignment is required for the MQTT example to prevent gateway-drop errors
- The mDNS example uses UDP multicast; ensure the virtual network supports multicast traffic in Netualizer
- All failure scenarios (gateway missing, no agent, LoRa PHY absent) are documented in Section 3.7 of the report
