-- installer.lua
local base_url =
"https://raw.githubusercontent.com/Himmelsw4nderer/cc-iot-project/refs/heads/main/"                  -- Replace with your repository URL
local files = {
    { url = "base_config_handler/base_config_handler.lua", path = "cciot-broker/base_config_handler.lua" },
    { url = "broker/broker.lua",                           path = "cciot-broker/broker.lua" },
    { url = "broker/config.lua",                           path = "cciot-broker/config.lua" },
    { url = "broker/uninstaller.lua",                      path = "cciot-broker/uninstaller.lua" },
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
