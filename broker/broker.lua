-- mqtt_broker.lua
local rednet = require("rednet")

-- Tabellen zum Verwalten von Topics und Clients
local topics = {}

-- Funktion zum Verarbeiten von Nachrichten
local function handleMessage(senderID, message)
    local command, topic, data = message.command, message.topic, message.data

    if command == "CONNECT" then
        print("Client verbunden: " .. senderID)
        rednet.send(senderID, {status = "connected"})

    elseif command == "SUBSCRIBE" then
        print("Client " .. senderID .. " abonniert Topic: " .. topic)
        topics[topic] = topics[topic] or {}
        table.insert(topics[topic], senderID)

    elseif command == "PUBLISH" then
        print("Nachricht an Topic " .. topic .. ": " .. data)
        if topics[topic] then
            for _, clientID in ipairs(topics[topic]) do
                rednet.send(clientID, {topic = topic, data = data})
            end
        end
    end
end

-- Startet den Broker
rednet.open("back") -- Netzwerkmodem an der "back"-Seite
print("MQTT-Broker läuft...")

while true do
    local senderID, message = rednet.receive()
    if type(message) == "table" then
        handleMessage(senderID, message)
    end
end
