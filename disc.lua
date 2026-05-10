-- Find disk drive
local drive = peripheral.find("drive")
if not drive then
    error("No disk drive found. Place drive next to computer.")
end

-- Check if disk is inserted
if not drive.isDiskPresent() then
    error("No disk in drive. Insert floppy disk with audio file.")
end

-- Check if it's a data disk (not music disc)
if not drive.hasData() then
    error("This is a music disc, not a data floppy.")
end

-- Get mount path of the disk (usually "disk" or "disk1")
local mountPath = drive.getMountPath()
if not mountPath then
    error("Failed to mount disk.")
end

print("Disk mounted at: " .. mountPath)

-- Load audio library
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
if not speaker then
    error("No speaker found.")
end

-- Open audio file from disk
local audioPath = mountPath .. "/Zcapala.dfpwm"
local file = io.open(audioPath, "rb")
if not file then
    error("Audio file not found on disk. Files on disk:")
    for _, f in ipairs(fs.list(mountPath)) do
        print("- " .. f)
    end
end

-- Decode and play
local decoder = dfpwm.make_decoder()
print("Playing from disk...")

while true do
    local chunk = file:read(16 * 1024)
    if not chunk then break end
    
    local buffer = decoder(chunk)
    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end

file:close()
print("Playback complete!")
