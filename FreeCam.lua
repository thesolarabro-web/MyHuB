--1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local localPlayer = Players.LocalPlayer
local targetParent = localPlayer:WaitForChild("PlayerGui")

if targetParent:FindFirstChild("FreeCamConfigGui") then 
    targetParent.FreeCamConfigGui:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FreeCamConfigGui"
ScreenGui.Parent = targetParent
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(157, 78, 221)
MainStroke.Thickness = 1.5

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderFix = Instance.new("Frame", Header)
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
HeaderFix.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "FREECAM CONFIG v3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -28, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local BindBtn = Instance.new("TextButton", MainFrame)
BindBtn.Size = UDim2.new(0.9, 0, 0, 26)
BindBtn.Position = UDim2.new(0.05, 0, 0.24, 0)
BindBtn.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
BindBtn.Text = "КЛАВИША: P"
BindBtn.TextColor3 = Color3.fromRGB(157, 78, 221)
BindBtn.Font = Enum.Font.GothamBold
BindBtn.TextSize = 10
Instance.new("UICorner", BindBtn).CornerRadius = UDim.new(0, 5)
local BindStroke = Instance.new("UIStroke", BindBtn)
BindStroke.Color = Color3.fromRGB(60, 45, 80)

local NameFrame = Instance.new("Frame", MainFrame)
NameFrame.Size = UDim2.new(0.9, 0, 0, 24)
NameFrame.Position = UDim2.new(0.05, 0, 0.44, 0)
NameFrame.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
local NFCorner = Instance.new("UICorner", NameFrame)
NFCorner.CornerRadius = UDim.new(0, 5)

local NameLabel = Instance.new("TextLabel", NameFrame)
NameLabel.Size = UDim2.new(0.4, 0, 1, 0)
NameLabel.Position = UDim2.new(0.04, 0, 0, 0)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "ТП камеры по нику:"
NameLabel.TextColor3 = Color3.fromRGB(130, 130, 150)
NameLabel.TextSize = 10
NameLabel.Font = Enum.Font.GothamSemibold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local NameBox = Instance.new("TextBox", NameFrame)
NameBox.Size = UDim2.new(0.52, 0, 0.75, 0)
NameBox.Position = UDim2.new(0.44, 0, 0.125, 0)
NameBox.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
NameBox.Text = ""
NameBox.PlaceholderText = "Введите ник..."
NameBox.TextColor3 = Color3.fromRGB(157, 78, 221)
NameBox.TextSize = 10
NameBox.Font = Enum.Font.GothamBold
Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 4)

local SpeedFrame = Instance.new("Frame", MainFrame)
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 24)
SpeedFrame.Position = UDim2.new(0.05, 0, 0.62, 0)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
local SFCorner = Instance.new("UICorner", SpeedFrame)
SFCorner.CornerRadius = UDim.new(0, 5)

local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
SpeedLabel.Size = UDim2.new(0.65, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0.04, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Скорость камеры:"
SpeedLabel.TextColor3 = Color3.fromRGB(130, 130, 150)
SpeedLabel.TextSize = 10
SpeedLabel.Font = Enum.Font.GothamSemibold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedBox = Instance.new("TextBox", SpeedFrame)
SpeedBox.Size = UDim2.new(0.25, 0, 0.75, 0)
SpeedBox.Position = UDim2.new(0.7, 0, 0.125, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
SpeedBox.Text = "1.2"
SpeedBox.TextColor3 = Color3.fromRGB(157, 78, 221)
SpeedBox.TextSize = 10
SpeedBox.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 4)

local Footnote = Instance.new("TextLabel", MainFrame)
Footnote.Size = UDim2.new(1, 0, 0, 15)
Footnote.Position = UDim2.new(0, 0, 0.86, 0)
Footnote.BackgroundTransparency = 1
Footnote.Text = "Нажми [Insert] чтобы скрыть меню конфигурации"
Footnote.TextColor3 = Color3.fromRGB(100, 100, 120)
Footnote.TextSize = 9
Footnote.Font = Enum.Font.GothamMedium
--2
local currentBind = Enum.KeyCode.P
local isBinding = false
local active = false
local cameraPos = Vector3.new()
local rotX = 0
local rotY = 0
local connection = nil
local savedAutoRotate = true

BindBtn.MouseButton1Click:Connect(function()
    if not isBinding then
        isBinding = true
        BindBtn.Text = "НАЖМИТЕ КЛАВИШУ..."
        BindBtn.BackgroundColor3 = Color3.fromRGB(35, 30, 55)
    end
end)

local function getMoveDirection()
    local dir = Vector3.new()
    local look = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then dir = dir + look end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then dir = dir - look end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then dir = dir - right end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then dir = dir + right end
    if UserInputService:IsKeyDown(Enum.KeyCode.E) then dir = dir + Vector3.new(0, 1, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then dir = dir - Vector3.new(0, 1, 0) end
    
    return dir.Magnitude > 0 and dir.Unit or Vector3.new()
end

local function toggleFreeCam()
    active = not active
    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if active then
        camera.CameraType = Enum.CameraType.Scriptable
        
        -- Логика ТП свободной камеры по частичному нику
        local targetCFrame = nil
        if NameBox.Text ~= "" then
            local typed = NameBox.Text:lower()
            local foundPlayer = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if string.sub(p.Name:lower(), 1, #typed) == typed or string.sub(p.DisplayName:lower(), 1, #typed) == typed then
                    foundPlayer = p
                    break
                end
            end
            local tChar = foundPlayer and foundPlayer.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if tRoot then
                targetCFrame = tRoot.CFrame * CFrame.new(0, 2, -6)
            end
        end
        
        if targetCFrame then
            camera.CFrame = targetCFrame
            cameraPos = targetCFrame.Position
        else
            cameraPos = camera.CFrame.Position
        end
        
        -- Вытаскиваем углы обзора, чтобы камеру не дергало при старте
        local _, _, _, r00, r01, r02, _, _, r12, _, _, r22 = camera.CFrame:GetComponents()
        rotX = math.atan2(-r12, r22)
        rotY = math.asin(r02)
        
        if humanoid then humanoid.AutoRotate = false end
        
        -- ЖЕСТКАЯ ФИКСАЦИЯ МЫШКИ В ЦЕНТРЕ ЭКРАНА
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        
        connection = RunService.RenderStepped:Connect(function(dt)
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
            
            -- Считываем чистый сдвиг мыши в LockCenter
            local delta = UserInputService:GetMouseDelta()
            rotX = rotX - delta.X * 0.003
            rotY = math.clamp(rotY - delta.Y * 0.003, -math.rad(80), math.rad(80))
            
            local customSpeed = tonumber(SpeedBox.Text) or 1.2
            cameraPos = cameraPos + getMoveDirection() * customSpeed
            
            camera.CFrame = CFrame.new(cameraPos) * CFrame.fromEulerAnglesYXZ(rotY, rotX, 0)
        end)
    else
        if connection then connection:Disconnect(); connection = nil end
        
        -- Сброс блокировок мыши и принудительное возвращение вращения торса
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        camera.CameraType = Enum.CameraType.Custom
        if humanoid then 
            humanoid.AutoRotate = true 
            camera.CameraSubject = humanoid
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- Блокируем ложное переключение, если фокус на чате или поле ввода ника
    if UserInputService:GetFocusedTextBox() then return end
    
    if isBinding then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentBind = input.KeyCode
            BindBtn.Text = "КЛАВИША: " .. input.KeyCode.Name:upper()
            BindBtn.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
            isBinding = false
        end
        return
    end
    
    if gameProcessed then return end
    if input.KeyCode == currentBind then
        toggleFreeCam()
    end
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

SpeedBox.FocusLost:Connect(function()
    if not tonumber(SpeedBox.Text) then SpeedBox.Text = "1.2" end
end)

CloseBtn.MouseButton1Click:Connect(function()
    if active then toggleFreeCam() end
    ScreenGui:Destroy()
end)
