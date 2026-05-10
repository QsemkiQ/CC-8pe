-- Download file directly to floppy
local drive = peripheral.find("drive")
local mountPath = drive.getMountPath()

-- Download from URL to floppy
local url = "https://github.com/QsemkiQ/CC-8pe/raw/refs/heads/main/Zcapala.dfpwm"
local response = http.get(url)
if response then
    local data = response.readAll()
    response.close()
    
    local file = io.open(mountPath .. "/Zcapala.dfpwm", "wb")
    file:write(data)
    file:close()
    print("Downloaded to floppy successfully!")
end
