-- mqtt_client.lua
local rednet = require("rednet")

local brokerID = nil

-- Funktion zum Verbinden mit dem Broker
local function connect()
    rednet.open("right") -- Netzwerkmodem an der "right"-Seite
    rednet.broadcast({command = "CONNECT"})
    brokerID, _ = rednet.receive()
    print("Mit Broker verbunden.")
end

-- Funktion zum Abonnieren eines Topics
local function subscribe(topic)
    rednet.send(brokerID, {command = "SUBSCRIBE", topic = topic})
    print("Abonniert: " .. topic)
end

-- Funktion zum Publizieren auf ein Topic
local function publish(topic, data)
    rednet.send(brokerID, {command = "PUBLISH", topic = topic, data = data})
    print("Publiziert: " .. topic .. " -> " .. data)
end

-- Beispielnutzung
connect()
subscribe("test/topic")
publish("test/topic", "Hello, MQTT!")
