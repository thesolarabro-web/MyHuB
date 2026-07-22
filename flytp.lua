local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local targetParent = nil
if localPlayer and localPlayer:FindFirstChild("PlayerGui") then
    targetParent = localPlayer.PlayerGui
else
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success and coreGui then
        targetParent = coreGui
    end
end
if not targetParent then return end
local oldGui = targetParent:FindFirstChild("FlyMenu_Standalone")
if oldGui then 
    oldGui:Destroy() 
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyMenu_Standalone"
ScreenGui.Parent = targetParent
ScreenGui.ResetOnSpawn = false
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 12)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
Title.BorderSizePixel = 0
Title.Text = "  ✈️ TP FLY SYSTEM v3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 12)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 75)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.GothamBold
local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 8)
local settingsValues = {
    FlySpeed = 2
}
local SliderFrame = Instance.new("Frame", MainFrame)
SliderFrame.Size = UDim2.new(0.9, 0, 0, 26)
SliderFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
SliderFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
SliderFrame.BorderSizePixel = 0
local SFCorner = Instance.new("UICorner", SliderFrame)
SFCorner.CornerRadius = UDim.new(0, 6)
local Label = Instance.new("TextLabel", SliderFrame)
Label.Size = UDim2.new(0.65, 0, 1, 0)
Label.Position = UDim2.new(0.05, 0, 0, 0)
Label.BackgroundTransparency = 1
Label.Text = "Скорость полёта:"
Label.TextColor3 = Color3.fromRGB(180, 180, 190)
Label.TextSize = 11
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Font = Enum.Font.GothamSemibold
local Box = Instance.new("TextBox", SliderFrame)
Box.Size = UDim2.new(0.25, 0, 0.75, 0)
Box.Position = UDim2.new(0.7, 0, 0.125, 0)
Box.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Box.BorderSizePixel = 0
Box.Text = tostring(settingsValues.FlySpeed)
Box.TextColor3 = Color3.fromRGB(0, 255, 180)
Box.TextSize = 11
Box.Font = Enum.Font.GothamBold
local BoxCorner = Instance.new("UICorner", Box)
BoxCorner.CornerRadius = UDim.new(0, 4)
Box.FocusLost:Connect(function()
    local num = tonumber(Box.Text)
    if num then 
        settingsValues.FlySpeed = num 
    else 
        Box.Text = tostring(settingsValues.FlySpeed) 
    end
end)
local Footnote = Instance.new("TextLabel", MainFrame)
Footnote.Size = UDim2.new(1, 0, 0, 20)
Footnote.Position = UDim2.new(0, 0, 0.82, 0)
Footnote.BackgroundTransparency = 1
Footnote.Text = "Нажми [Insert] для скрытия меню"
Footnote.TextColor3 = Color3.fromRGB(120, 120, 140)
Footnote.TextSize = 10
Footnote.Font = Enum.Font.GothamMedium
local RunService = game:GetService("RunService")
local isFlyActive = false
local flyConnection = nil
local camera = workspace.CurrentCamera
local flyVelocity = nil

local function startFly()
    if flyConnection then flyConnection:Disconnect() end
    local character = localPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        -- Создаем принудительный силовой якорь, который полностью отключает падение
        pcall(function()
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.Name = "FlyAnchor"
            flyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyVelocity.Parent = rootPart
        end)
    end
    
    flyConnection = RunService.RenderStepped:Connect(function()
        local char = localPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not root then return end
        
        -- Проверка существования якоря во избежание ресетов персонажа
        if not root:FindFirstChild("FlyAnchor") and flyVelocity then
            pcall(function() flyVelocity.Parent = root end)
        end
        
        pcall(function()
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
        end)
        
        local moveDirection = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + (moveDirection.Unit * settingsValues.FlySpeed)
        else
            -- Точная фиксация координат без скольжения вниз
            root.CFrame = CFrame.new(root.Position)
        end
    end)
end

local function stopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyVelocity then
        pcall(function() flyVelocity:Destroy() end)
        flyVelocity = nil
    end
    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        pcall(function()
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    isFlyActive = not isFlyActive
    if isFlyActive then
        ToggleBtn.Text = "ВЫКЛЮЧИТЬ ПОЛЁТ"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        startFly()
    else
        ToggleBtn.Text = "ВКЛЮЧИТЬ ПОЛЁТ"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 75)
        stopFly()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    stopFly()
    ScreenGui:Destroy()
end)
