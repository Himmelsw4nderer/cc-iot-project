local config_handler = require("base_config_handler")

local default_config = {
    modemSide = "back",
    brokerID = 1,
    clientID = 1,
    base_topic = "test",
    value_topic = "value",
    button_side = "top",
}

local configPath = "simple_button_client/client_config.cfg"

config_handler.ensureConfig(configPath, default_config)

local config = config_handler.readConfig(configPath)

return config
