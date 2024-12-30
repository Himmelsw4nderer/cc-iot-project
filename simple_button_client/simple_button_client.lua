local base_client = require("base_client")
local config = require("config")

local client = base_client:new(nil, config.modemSide, config.brokerID)

while not client:connect(config.modemSide, config.brokerID) do
    print("Verbindung fehlgeschlagen. Erneuter Versuch in 5 Sekunden.")
    sleep(5)
end

-- redstone_monitor.lua
local lastState = redstone.getInput(config.button_side) -- Get the initial redstone state

print("Monitoring redstone input on side: " .. config.button_side)

-- Infinite loop to monitor changes
while true do
    -- Wait for a redstone event
    os.pullEvent("redstone")

    -- Get the new state of the redstone input
    local newState = redstone.getInput(config.button_side)

    -- Check if the state has changed
    if newState ~= lastState then
        print("Redstone state changed on side " ..
            config.button_side .. ": " .. tostring(lastState) .. " -> " .. tostring(newState))

        -- Send a message or perform an action
        client:publish(config.base_topic .. "/" .. config.value_topic, tostring(newState))

        -- Update the last state
        lastState = newState
    end
end
