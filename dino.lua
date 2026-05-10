local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

if not speaker then
    error("No speaker attached")
end

local decoder = dfpwm.make_decoder()
local file = io.open("data/example.dfpwm", "rb")  -- "rb" = read binary

if not file then
    error("File not found")
end

while true do
    local chunk = file:read(16 * 1024)  -- Читаем 16KB бинарных данных
    if not chunk then break end          -- Конец файла
    
    local buffer = decoder(chunk)        -- Декодируем в PCM
    
    -- Отправляем в динамик, ожидая освобождения
    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end

file:close()
print("Playback finished")
