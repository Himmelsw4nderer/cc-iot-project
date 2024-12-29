-- uninstaller.lua
local files = {
    "broker.lua",
}

-- Function to delete a file or directory
local function deleteFileOrDir(path)
    if fs.exists(path) then
        if fs.isDir(path) then
            print("Deleting directory: " .. path)
            for _, file in ipairs(fs.list(path)) do
                deleteFileOrDir(fs.combine(path, file))
            end
            fs.delete(path)
        else
            print("Deleting file: " .. path)
            fs.delete(path)
        end
    else
        print("File or directory not found: " .. path)
    end
end

-- Uninstallation logic
print("Starting uninstallation...")
for _, file in ipairs(files) do
    deleteFileOrDir(file)
end

-- Cleanup: Remove empty directories in "utils" or other base directories
if fs.exists("utils") and fs.isDir("utils") then
    print("Cleaning up empty directories...")
    deleteFileOrDir("utils")
end

print("Uninstallation complete!")
