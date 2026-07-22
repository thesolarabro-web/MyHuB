-- [[ TORNADO AIR WALK v4.3 - COMPACT SLIDER & EDIT FIX ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

-- Универсальный контейнер для вывода графики
local TargetParent = nil
pcall(function() TargetParent = game:GetService("CoreGui") end)
if not TargetParent then pcall(function() TargetParent = game:GetService("RobloxGui") end) end
if not TargetParent then TargetParent = localPlayer:WaitForChild("PlayerGui") end

-- Удаление старых копий
if TargetParent:FindFirstChild("TornadoAirWalkUI") then TargetParent["TornadoAirWalkUI"]:Destroy() end
if workspace:FindFirstChild("TornadoAirPad") then workspace["TornadoAirPad"]:Destroy() end

-- Создание контейнера интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TornadoAirWalkUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = TargetParent

local WALK_CONFIG = {
	Enabled = false,
	Size = 7,
	HeightOffset = -3.72, -- Идеальная базовая высота стоп
	MoveStep = 5.0        -- Шаг лифта вверх/вниз
}

-- Создание платформы
local airPad = Instance.new("Part")
airPad.Name = "TornadoAirPad"
airPad.Size = Vector3.new(WALK_CONFIG.Size, 0.2, WALK_CONFIG.Size)
airPad.Transparency = 1
airPad.Anchored = true
airPad.CanCollide = false
airPad.Parent = workspace

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 290, 0, 190)
MainFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(157, 78, 221)
MainStroke.Thickness = 1.5

-- ШАПКА
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Text = "☁️ TORNADO AIR FLIGHT v4.3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -34, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- КНОПКА СТАТУСА
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(1, -24, 0, 40)
ToggleBtn.Position = UDim2.new(0, 12, 0, 50)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
ToggleBtn.Text = "ХОЖДЕНИЕ ПО ВОЗДУХУ: ВЫКЛ"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(60, 45, 80)

-- 1. СТРОКА: НАСТРОЙКА ВЫСОТЫ (СЛАЙДЕР РЯДОМ С ПОЛЕМ ВВОДА)
local HeightLabel = Instance.new("TextLabel", MainFrame)
HeightLabel.Size = UDim2.new(0, 100, 0, 30)
HeightLabel.Position = UDim2.new(0, 15, 0, 100)
HeightLabel.Text = "Высота стоп:"
HeightLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
HeightLabel.Font = Enum.Font.Gotham
HeightLabel.TextSize = 11
HeightLabel.TextXAlignment = Enum.TextXAlignment.Left
HeightLabel.BackgroundTransparency = 1

-- Слайдер (теперь он прямо по центру строки)
local SliderBg = Instance.new("Frame", MainFrame)
SliderBg.Size = UDim2.new(0, 100, 0, 6)
SliderBg.Position = UDim2.new(0, 105, 0, 112)
SliderBg.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 3)

local SliderButton = Instance.new("TextButton", SliderBg)
SliderButton.Size = UDim2.new(0, 14, 0, 14)
SliderButton.BackgroundColor3 = Color3.fromRGB(157, 78, 221)
SliderButton.Text = ""
Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(0, 7)

-- Текстовое поле для ввода высоты (справа от слайдера)
local HeightBox = Instance.new("TextBox", MainFrame)
HeightBox.Size = UDim2.new(0, 55, 0, 24)
HeightBox.Position = UDim2.new(1, -70, 0, 103)
HeightBox.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
HeightBox.Text = string.format("%.2f", WALK_CONFIG.HeightOffset)
HeightBox.ClearTextOnFocus = false -- ФИКС: Текст больше НЕ пропадает при клике мышкой!
HeightBox.TextColor3 = Color3.fromRGB(157, 78, 221)
HeightBox.Font = Enum.Font.GothamBold
HeightBox.TextSize = 11
Instance.new("UICorner", HeightBox).CornerRadius = UDim.new(0, 5)
local BoxStroke = Instance.new("UIStroke", HeightBox)
BoxStroke.Color = Color3.fromRGB(50, 50, 70)

-- 2. СТРОКА: УПРАВЛЕНИЕ ЛИФТОМ (ШАГ ПЕРЕМЕЩЕНИЯ)
local StepLabel = Instance.new("TextLabel", MainFrame)
StepLabel.Size = UDim2.new(0, 100, 0, 30)
StepLabel.Position = UDim2.new(0, 15, 0, 140)
StepLabel.Text = "Лифт (Шаг):"
StepLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
StepLabel.Font = Enum.Font.Gotham
StepLabel.TextSize = 11
StepLabel.TextXAlignment = Enum.TextXAlignment.Left
StepLabel.BackgroundTransparency = 1

local StepBox = Instance.new("TextBox", MainFrame)
StepBox.Size = UDim2.new(0, 45, 0, 24)
StepBox.Position = UDim2.new(0, 105, 0, 143)
StepBox.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
StepBox.Text = tostring(WALK_CONFIG.MoveStep)
StepBox.ClearTextOnFocus = false -- ФИКС: Шаг тоже сохраняется при клике
StepBox.TextColor3 = Color3.fromRGB(140, 80, 255)
StepBox.Font = Enum.Font.GothamBold
StepBox.TextSize = 11
Instance.new("UICorner", StepBox).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", StepBox).Color = Color3.fromRGB(50, 50, 70)

local function createActionBtn(text, xPos, color, onClick)
	local B = Instance.new("TextButton", MainFrame)
	B.Size = UDim2.new(0, 55, 0, 24)
	B.Position = UDim2.new(0, xPos, 0, 143)
	B.BackgroundColor3 = color
	B.Text = text
	B.TextColor3 = Color3.fromRGB(255, 255, 255)
	B.Font = Enum.Font.GothamBold
	B.TextSize = 10
	Instance.new("UICorner", B).CornerRadius = UDim.new(0, 5)
	B.MouseButton1Click:Connect(onClick)
	return B
end

createActionBtn("ВВЕРХ", 160, Color3.fromRGB(140, 80, 255), function()
	local char = localPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if root and WALK_CONFIG.Enabled then root.CFrame = root.CFrame * CFrame.new(0, WALK_CONFIG.MoveStep, 0) end
end)

createActionBtn("ВНИЗ", 220, Color3.fromRGB(140, 80, 255), function()
	local char = localPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if root and WALK_CONFIG.Enabled then root.CFrame = root.CFrame * CFrame.new(0, -WALK_CONFIG.MoveStep, 0) end
end)

-- Логика синхронизации (Диапазон ползунка от -1.0 до -10.0)
local minH, maxH = -1.0, -10.0
local function updateInterface(source)
	if source ~= "box" then HeightBox.Text = string.format("%.2f", WALK_CONFIG.HeightOffset) end
	local pct = (WALK_CONFIG.HeightOffset - minH) / (maxH - minH)
	SliderButton.Position = UDim2.new(math.clamp(pct, 0, 1), -7, 0, -4)
end

HeightBox.FocusLost:Connect(function()
	local num = tonumber(HeightBox.Text)
	if num then WALK_CONFIG.HeightOffset = math.clamp(num, -10.0, -1.0) end
	updateInterface("box")
end)

StepBox.FocusLost:Connect(function()
	local num = tonumber(StepBox.Text)
	if num and num > 0 then WALK_CONFIG.MoveStep = num else StepBox.Text = tostring(WALK_CONFIG.MoveStep) end
end)

updateInterface()

-- Перетаскивание слайдера
local dragging = false
SliderButton.MouseButton1Down:Connect(function() dragging = true end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

RunService.RenderStepped:Connect(function()
	if dragging then
		local mousePos = UserInputService:GetMouseLocation()
		local relativeX = mousePos.X - SliderBg.AbsolutePosition.X
		local pct = math.clamp(relativeX / SliderBg.AbsoluteSize.X, 0, 1)
		WALK_CONFIG.HeightOffset = minH + (maxH - minH) * pct
		updateInterface("slider")
	end
end)

-- Переключатель ходьбы
ToggleBtn.MouseButton1Click:Connect(function()
	WALK_CONFIG.Enabled = not WALK_CONFIG.Enabled
	if WALK_CONFIG.Enabled then
		ToggleBtn.Text = "ХОЖДЕНИЕ ПО ВОЗДУХУ: АКТИВНО"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
		ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		airPad.CanCollide = true
	else
		ToggleBtn.Text = "ХОЖДЕНИЕ ПО ВОЗДУХУ: ВЫКЛ"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
		ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
		airPad.CanCollide = false
	end
end)

-- Физический цикл удержания
local connection
connection = RunService.Heartbeat:Connect(function()
	if not ScreenGui or not ScreenGui.Parent then 
		connection:Disconnect() 
		if airPad then airPad:Destroy() end
		return 
	end
	if WALK_CONFIG.Enabled then
		local char = localPlayer.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if root then airPad.Position = Vector3.new(root.Position.X, root.Position.Y + WALK_CONFIG.HeightOffset, root.Position.Z) end
	end
end)

CloseBtn.MouseButton1Click:Connect(function()
	if connection then connection:Disconnect() end
	if airPad then airPad:Destroy() end
	ScreenGui:Destroy()
end)
