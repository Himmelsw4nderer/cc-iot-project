local base_client = {}

-- Konstruktor
function base_client:new(o, modemSide, brokerID)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.brokerID = brokerID or nil
    o:connect(modemSide, brokerID)
    return o
end

-- Funktion zum Verbinden mit dem Broker
function base_client.connect(modemSide, brokerID)
    rednet.open(modemSide) -- Netzwerkmodem an der "right"-Seite
    rednet.broadcast({ command = "CONNECT" })
    local senderID, message = rednet.receive()
    if message and message.status == "connected" and senderID == brokerID then
        self.brokerID = senderID -- Save the broker ID in the object
        print("Mit Broker verbunden. Broker ID: " .. self.brokerID)
        return true
    else
        print("Verbindung zum Broker fehlgeschlagen.")
        return false
    end
end

-- Funktion zum Abonnieren eines Topics
function base_client.subscribe(topic)
    if not self.brokerID then
        error("Keine Verbindung zu einem Broker. Bitte zuerst verbinden!")
    end

    rednet.send(brokerID, { command = "SUBSCRIBE", topic = topic })
    print("Abonniert: " .. topic)
end

-- Funktion zum Publizieren auf ein Topic
function base_client.publish(topic, data)
    rednet.send(brokerID, { command = "PUBLISH", topic = topic, data = data })
    print("Publiziert: " .. topic .. " -> " .. data)
end

return base_client
