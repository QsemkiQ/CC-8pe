-- simple_dance.lua
-- Заставляет аниматроника танцевать простые движения

-- Находим аниматроника, подключенного к компьютеру
local animatronic = peripheral.find("animatronic")

if not animatronic then
    print("Ошибка: Аниматроник не найден!")
    print("Убедитесь, что он подключен к компьютеру.")
    return
end

print("Начинаю танец! Нажмите Ctrl+T, чтобы остановить.")

-- Функция для плавного движения части тела
local function movePart(part, angle, speed)
    -- part: имя части (например, "head", "leftArm")
    -- angle: угол в радианах (положительный = по часовой стрелке)
    -- speed: скорость движения (0.5 - 2.0, где 1.0 - нормальная)
    animatronic.move(part, {angle = angle, speed = speed})
end

-- Основной танцевальный цикл
local running = true
parallel.waitForAny(
    function()
        while running do
            -- Шаг 1: Взмах руками и наклон головы
            movePart("head", 0.5, 1.0)      -- Наклон головы вправо
            movePart("leftArm", -1.0, 1.5)  -- Левая рука вверх
            movePart("rightArm", 1.0, 1.5)  -- Правая рука вниз
            sleep(0.5)

            -- Шаг 2: Смена позы
            movePart("head", -0.5, 1.0)     -- Наклон головы влево
            movePart("leftArm", 1.0, 1.5)   -- Левая рука вниз
            movePart("rightArm", -1.0, 1.5) -- Правая рука вверх
            sleep(0.5)

            -- Шаг 3: Встряска (быстрые движения)
            movePart("head", 0.0, 2.0)      -- Голова ровно
            movePart("leftArm", 0.5, 2.0)   -- Взмах левой
            movePart("rightArm", -0.5, 2.0) -- Взмах правой
            sleep(0.3)
        end
    end,
    function()
        -- Ожидание нажатия Ctrl+T для остановки
        while true do
            if os.pullEvent() == "terminate" then
                running = false
                break
            end
        end
    end
)

-- Останавливаем все движения и возвращаем части тела в исходное положение
animatronic.stopAll()
movePart("head", 0.0, 1.0)
movePart("leftArm", 0.0, 1.0)
movePart("rightArm", 0.0, 1.0)
print("Танец окончен!")
