local config_handler = require("base_config_handler")

local default_config = {
    modemSide = "back",
    port = 1,
}

local configPath = "cciot-broker/config.cfg"

config_handler.ensureConfig(configPath, default_config)

local config = config_handler.readConfig(configPath)

return config
