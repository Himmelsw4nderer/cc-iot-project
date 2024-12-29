-- config_handler.lua

local config_handler = {}

-- Ensure the configuration file exists
function config_handler.ensureConfig(configPath, defaultValues)
    if not fs.exists(configPath) then
        print("Configuration file not found. Creating with default values...")
        config_handler.writeConfig(configPath, defaultValues)
    end
end

-- Read configuration file
function config_handler.readConfig(configPath)
    if fs.exists(configPath) then
        local file = fs.open(configPath, "r")
        local content = file.readAll()
        file.close()
        return textutils.unserialize(content)
    else
        error("Configuration file not found: " .. configPath)
    end
end

-- Write configuration file
function config_handler.writeConfig(configPath, data)
    local file = fs.open(configPath, "w")
    file.write(textutils.serialize(data))
    file.close()
end

return config_handler
