local speaker = peripheral.find("speaker")
if not speaker then
    error("Динамик не найден!")
end

local dfpwm = require("cc.audio.dfpwm")
local decoder = dfpwm.make_decoder()

local file = io.open("1.dfpmu", "rb")
if not file then
    error("Файл 1.dfpmu не найден!")
end

local data = file:read("*a")
file:close()

local audio_data = decoder(data)
speaker.playAudio(audio_data)
