-- [[ TORNADO ANNIHILATION DETECTOR v2.0 - RADAR ONLY ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer

-- Защищенный выбор папки и очистка старых копий радара
local TargetParent = nil
pcall(function() TargetParent = game:GetService("CoreGui") end)
if not TargetParent then pcall(function() TargetParent = game:GetService("RobloxGui") end) end
if not TargetParent then TargetParent = localPlayer:WaitForChild("PlayerGui") end

if TargetParent:FindFirstChild("TornadoAnnihilationUI") then
	TargetParent["TornadoAnnihilationUI"]:Destroy()
end

-- Контейнер интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TornadoAnnihilationUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = TargetParent

-- ГЛАВНОЕ ОКНО РАДАРА
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0) -- В левой части экрана
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
MainStroke = Stroke
MainStroke.Color = Color3.fromRGB(157, 78, 221) -- Фирменный фиолетовый неон
MainStroke.Thickness = 1.5

-- ШАПКА ОКНА
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(20, 18, 32)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Text = "🛰️ ANNIHILATION RADAR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- КРЕСТИК ЗАКРЫТИЯ (✕)
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -34, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Color = Color3.fromRGB(100, 40, 40)

-- КОНСТРУКТОР ТЕКСТОВЫХ СТРОК
local function createDataLabel(text, yPos, color)
	local Lbl = Instance.new("TextLabel", MainFrame)
	Lbl.Size = UDim2.new(1, -24, 0, 22)
	Lbl.Position = UDim2.new(0, 12, 0, yPos)
	Lbl.Text = text
	Lbl.TextColor3 = color or Color3.fromRGB(200, 200, 210)
	Lbl.Font = Enum.Font.Gotham
	Lbl.TextSize = 11
	Lbl.TextXAlignment = Enum.TextXAlignment.Left
	Lbl.BackgroundTransparency = 1
	return Lbl
end

local PosXLabel = createDataLabel("Позиция X (Широта): 0", 45)
local PosZLabel = createDataLabel("Позиция Z (Долгота): 0", 70, Color3.fromRGB(210, 190, 255))
local PosYLabel = createDataLabel("Позиция Y (Высота): 0", 95)
local LimitLabel = createDataLabel("Лимит аннигиляции (Y): 0", 125, Color3.fromRGB(160, 140, 200))
local StatusLabel = createDataLabel("До аннигиляции: Расчет...", 155, Color3.fromRGB(255, 255, 255))

-- ПОЛОСКА ПРОГРЕССА ОПАСНОСТИ
local ProgressBg = Instance.new("Frame", MainFrame)
ProgressBg.Size = UDim2.new(1, -24, 0, 8)
ProgressBg.Position = UDim2.new(0, 12, 0, 190)
ProgressBg.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
Instance.new("UICorner", ProgressBg).CornerRadius = UDim.new(0, 4)

local ProgressBar = Instance.new("Frame", ProgressBg)
ProgressBar.Size = UDim2.new(1, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(157, 78, 221)
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(0, 4)

-- ЦИКЛ ОБНОВЛЕНИЯ ДАННЫХ
local connection
connection = RunService.Heartbeat:Connect(function()
	if not ScreenGui or not ScreenGui.Parent then connection:Disconnect() return end
	
	local char = localPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local destroyHeight = workspace.FallenPartsDestroyHeight
	
	LimitLabel.Text = string.format("Void (Y): %.1f", destroyHeight)
	
	if root then
		local currentPos = root.Position
		PosXLabel.Text = string.format("X: %.1f", currentPos.X)
		PosZLabel.Text = string.format("Z: %.1f", currentPos.Z)
		PosYLabel.Text = string.format("Y: %.1f", currentPos.Y)
		
		-- Расстояние до удаления
		local distanceToDeath = currentPos.Y - destroyHeight
		
		if distanceToDeath > 0 then
			StatusLabel.Text = string.format("For Void: %.1f студов", distanceToDeath)
			StatusLabel.TextColor3 = distanceToDeath < 150 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
			
			-- Процентное заполнение полоски (за 100% берем опасную дистанцию в 500 студов)
			local percent = math.clamp(distanceToDeath / 500, 0, 1)
			ProgressBar.Size = UDim2.new(percent, 0, 1, 0)
			ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100):Lerp(Color3.fromRGB(157, 78, 221), percent)
		else
			StatusLabel.Text = "You in Void!"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			ProgressBar.Size = UDim2.new(0, 0, 1, 0)
		end
	else
		PosXLabel.Text = "X: ---"
		PosZLabel.Text = "Z: ---"
		PosYLabel.Text = "Y: ---"
		StatusLabel.Text = "Until destruction: ---"
	end
end)

-- РАБОТА КРЕСТИКА
CloseBtn.MouseButton1Click:Connect(function()
	if connection then connection:Disconnect() end
	ScreenGui:Destroy()
end)
