-- installer.lua
local base_url =
"https://raw.githubusercontent.com/Himmelsw4nderer/cc-iot-project/refs/heads/main/"                  -- Replace with your repository URL
local files = {
    { url = "base_client/base_client.lua",                   path = "mqtt-client/base_client.lua" },
    { url = "base_config_handler/base_config_handler.lua",   path = "mqtt-client/base_config_handler.lua" },
    { url = "simple_button_client/simple_button_client.lua", path = "mqtt-client/simple_button_client.lua" },
    { url = "simple_button_client/config.lua",               path = "mqtt-client/config.lua" },
    { url = "simple_button_client/uninstaller.lua",          path = "mqtt-client/uninstaller.lua" },
}

-- Function to download a file
local function downloadFile(url, path)
    print("Downloading: " .. path)
    local full_url = base_url .. url
    local response = http.get(full_url)

    if response then
        local content = response.readAll()
        response.close()

        -- Create directories if needed
        local dir = fs.getDir(path)
        if not fs.exists(dir) and dir ~= "" then
            fs.makeDir(dir)
        end

        -- Write to file
        local file = fs.open(path, "w")
        file.write(content)
        file.close()

        print("Downloaded: " .. path)
    else
        print("Failed to download: " .. path)
    end
end

-- Main installer logic
for _, file in ipairs(files) do
    downloadFile(file.url, file.path)
end

print("Installation complete!")