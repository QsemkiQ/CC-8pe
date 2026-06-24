-- Узнаем, что на самом деле подключено к компьютеру
local devices = peripheral.getNames()
for i, name in ipairs(devices) do
    local type = peripheral.getType(name)
    print(name .. " -> " .. type)
end
