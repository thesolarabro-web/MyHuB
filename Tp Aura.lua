--1
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()
local targetParent = localPlayer:WaitForChild("PlayerGui")

if targetParent:FindFirstChild("FastClickTeleporterGui") then 
    targetParent.FastClickTeleporterGui:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FastClickTeleporterGui"
ScreenGui.Parent = targetParent
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 270, 0, 260)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
Title.BorderSizePixel = 0
Title.Text = "   PURE PIVOT AURA TP v9.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 12)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -28, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

local Btn1 = Instance.new("TextButton", MainFrame)
Btn1.Size = UDim2.new(0.9, 0, 0, 30)
Btn1.Position = UDim2.new(0.05, 0, 0.16, 0)
Btn1.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
Btn1.Text = "🔴 1. ПОСТАВИТЬ МАРКЕР (КЛИК)"
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.Font = Enum.Font.GothamBold
Btn1.TextSize = 10
local Btn1Corner = Instance.new("UICorner", Btn1)
Btn1Corner.CornerRadius = UDim.new(0, 6)

local NameFrame = Instance.new("Frame", MainFrame)
NameFrame.Size = UDim2.new(0.9, 0, 0, 24)
NameFrame.Position = UDim2.new(0.05, 0, 0.30, 0)
NameFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
local NFCorner = Instance.new("UICorner", NameFrame)
NFCorner.CornerRadius = UDim.new(0, 6)

local NameLabel = Instance.new("TextLabel", NameFrame)
NameLabel.Size = UDim2.new(0.4, 0, 1, 0)
NameLabel.Position = UDim2.new(0.04, 0, 0, 0)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = "Ник игрока:"
NameLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
NameLabel.TextSize = 10
NameLabel.Font = Enum.Font.GothamSemibold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local NameBox = Instance.new("TextBox", NameFrame)
NameBox.Size = UDim2.new(0.52, 0, 0.75, 0)
NameBox.Position = UDim2.new(0.44, 0, 0.125, 0)
NameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NameBox.Text = ""
NameBox.PlaceholderText = "Пусто = Клик"
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.TextSize = 10
NameBox.Font = Enum.Font.GothamBold
local NBCorner = Instance.new("UICorner", NameBox)
NBCorner.CornerRadius = UDim.new(0, 4)

local Btn2 = Instance.new("TextButton", MainFrame)
Btn2.Size = UDim2.new(0.9, 0, 0, 30)
Btn2.Position = UDim2.new(0.05, 0, 0.42, 0)
Btn2.BackgroundColor3 = Color3.fromRGB(255, 50, 75)
Btn2.Text = "ВКЛЮЧИТЬ АУРУ ПЕРЕНОСА"
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.Font = Enum.Font.GothamBold
Btn2.TextSize = 10
local Btn2Corner = Instance.new("UICorner", Btn2)
Btn2Corner.CornerRadius = UDim.new(0, 6)

local RadiusFrame = Instance.new("Frame", MainFrame)
RadiusFrame.Size = UDim2.new(0.9, 0, 0, 24)
RadiusFrame.Position = UDim2.new(0.05, 0, 0.56, 0)
RadiusFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
local RFCorner = Instance.new("UICorner", RadiusFrame)
RFCorner.CornerRadius = UDim.new(0, 6)

local RadiusLabel = Instance.new("TextLabel", RadiusFrame)
RadiusLabel.Size = UDim2.new(0.65, 0, 1, 0)
RadiusLabel.Position = UDim2.new(0.05, 0, 0, 0)
RadiusLabel.BackgroundTransparency = 1
RadiusLabel.Text = "Радиус ауры от меня:"
RadiusLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
RadiusLabel.TextSize = 10
RadiusLabel.Font = Enum.Font.GothamSemibold
RadiusLabel.TextXAlignment = Enum.TextXAlignment.Left

local RadiusBox = Instance.new("TextBox", RadiusFrame)
RadiusBox.Size = UDim2.new(0.25, 0, 0.75, 0)
RadiusBox.Position = UDim2.new(0.7, 0, 0.125, 0)
RadiusBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
RadiusBox.Text = "15"
RadiusBox.TextColor3 = Color3.fromRGB(255, 255, 255)
RadiusBox.TextSize = 10
RadiusBox.Font = Enum.Font.GothamBold
local RBCorner = Instance.new("UICorner", RadiusBox)
RBCorner.CornerRadius = UDim.new(0, 4)

local FreqFrame = Instance.new("Frame", MainFrame)
FreqFrame.Size = UDim2.new(0.9, 0, 0, 24)
FreqFrame.Position = UDim2.new(0.05, 0, 0.68, 0)
FreqFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
local FFCorner = Instance.new("UICorner", FreqFrame)
FFCorner.CornerRadius = UDim.new(0, 6)

local FreqLabel = Instance.new("TextLabel", FreqFrame)
FreqLabel.Size = UDim2.new(0.65, 0, 1, 0)
FreqLabel.Position = UDim2.new(0.05, 0, 0, 0)
FreqLabel.BackgroundTransparency = 1
FreqLabel.Text = "Частота задержки (сек):"
FreqLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
FreqLabel.TextSize = 10
FreqLabel.Font = Enum.Font.GothamSemibold
FreqLabel.TextXAlignment = Enum.TextXAlignment.Left

local FreqBox = Instance.new("TextBox", FreqFrame)
FreqBox.Size = UDim2.new(0.25, 0, 0.75, 0)
FreqBox.Position = UDim2.new(0.7, 0, 0.125, 0)
FreqBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
FreqBox.Text = "0.25"
FreqBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FreqBox.TextSize = 10
FreqBox.Font = Enum.Font.GothamBold
local FBCorner = Instance.new("UICorner", FreqBox)
FBCorner.CornerRadius = UDim.new(0, 4)

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.80, 0)
Status.BackgroundTransparency = 1
Status.Text = "Ожидание настройки..."
Status.TextColor3 = Color3.fromRGB(120, 120, 140)
Status.Font = Enum.Font.GothamMedium
Status.TextSize = 10

local Footnote = Instance.new("TextLabel", MainFrame)
Footnote.Size = UDim2.new(1, 0, 0, 20)
Footnote.Position = UDim2.new(0, 0, 0.90, 0)
Footnote.BackgroundTransparency = 1
Footnote.Text = "Нажми [Insert] чтобы скрыть меню"
Footnote.TextColor3 = Color3.fromRGB(90, 90, 110)
Footnote.TextSize = 9
Footnote.Font = Enum.Font.GothamMedium

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
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

local redBallMarker = nil
local isSelecting = false
local auraActive = false
local inputConnection = nil
local auraConnection = nil
local attachConnection = nil
local attachedTargetRoot = nil
--2
local function removeMarker()
    if attachConnection then attachConnection:Disconnect(); attachConnection = nil end
    if redBallMarker then redBallMarker:Destroy(); redBallMarker = nil end
    attachedTargetRoot = nil
end

local function stopSelecting()
    isSelecting = false
    if inputConnection then inputConnection:Disconnect(); inputConnection = nil end
end

local function stopAura()
    auraActive = false
    if auraConnection then auraConnection:Disconnect(); auraConnection = nil end
    Btn2.Text = "ВКЛЮЧИТЬ АУРУ ПЕРЕНОСА"
    Btn2.BackgroundColor3 = Color3.fromRGB(255, 50, 75)
end

local function createMarkerAtRoot(targetRoot)
    removeMarker()
    attachedTargetRoot = targetRoot
    redBallMarker = Instance.new("Part")
    redBallMarker.Name = "AuraTPMarker"
    redBallMarker.Shape = Enum.PartType.Ball
    redBallMarker.Size = Vector3.new(3, 3, 3)
    redBallMarker.Color = Color3.fromRGB(255, 0, 0)
    redBallMarker.Transparency = 0.4
    redBallMarker.CanCollide = false
    redBallMarker.Anchored = false
    redBallMarker.Parent = workspace
    redBallMarker:PivotTo(targetRoot.CFrame)
    
    attachConnection = RunService.Heartbeat:Connect(function()
        if attachedTargetRoot and attachedTargetRoot.Parent and redBallMarker then
            redBallMarker:PivotTo(attachedTargetRoot.CFrame + Vector3.new(0, 4, 0))
        else
            removeMarker()
        end
    end)
end

Btn1.MouseButton1Click:Connect(function()
    stopSelecting()
    local typedName = NameBox.Text
    if typedName ~= "" then
        local targetPlayerObj = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= localPlayer and (string.sub(p.Name:lower(), 1, #typedName) == typedName:lower() or string.sub(p.DisplayName:lower(), 1, #typedName) == typedName:lower()) then
                targetPlayerObj = p
                break
            end
        end
        local tChar = targetPlayerObj and targetPlayerObj.Character
        local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if tRoot then
            createMarkerAtRoot(tRoot)
            Status.Text = "Маркер привязан к: " .. targetPlayerObj.Name
            Status.TextColor3 = Color3.fromRGB(0, 180, 120)
            return
        else
            Status.Text = "Игрок не найден!"
            Status.TextColor3 = Color3.fromRGB(255, 75, 75)
            return
        end
    end

    isSelecting = true
    Status.Text = "Кликни на пол ИЛИ на человека!"
    Status.TextColor3 = Color3.fromRGB(0, 140, 255)
    
    inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
            if mouse.Hit and mouse.Target then
                removeMarker()
                local hitPos = mouse.Hit.Position
                local targetPart = mouse.Target
                local characterModel = targetPart:FindFirstAncestorOfClass("Model")
                local foundHumanoid = characterModel and characterModel:FindFirstChildOfClass("Humanoid")
                local targetRoot = characterModel and characterModel:FindFirstChild("HumanoidRootPart")
                
                if foundHumanoid and targetRoot and characterModel ~= localPlayer.Character then
                    createMarkerAtRoot(targetRoot)
                    Status.Text = "Маркер прикреплен к: " .. characterModel.Name
                    Status.TextColor3 = Color3.fromRGB(0, 180, 120)
                else
                    redBallMarker = Instance.new("Part")
                    redBallMarker.Name = "AuraTPMarker"
                    redBallMarker.Shape = Enum.PartType.Ball
                    redBallMarker.Size = Vector3.new(3, 3, 3)
                    redBallMarker.Color = Color3.fromRGB(255, 0, 0)
                    redBallMarker.Transparency = 0.4
                    redBallMarker.CanCollide = false
                    redBallMarker.Anchored = true
                    redBallMarker.Parent = workspace
                    redBallMarker:PivotTo(CFrame.new(hitPos))
                    Status.Text = "Статичный шар заспавнен!"
                    Status.TextColor3 = Color3.fromRGB(0, 180, 120)
                end
                stopSelecting()
            end
        end
    end)
end)

Btn2.MouseButton1Click:Connect(function()
    stopSelecting()
    if auraActive then
        stopAura()
        Status.Text = "Аура выключена."
        Status.TextColor3 = Color3.fromRGB(120, 120, 140)
    else
        if not redBallMarker then
            Status.Text = "Сначала спавни маркер кнопкой 1!"
            Status.TextColor3 = Color3.fromRGB(255, 75, 75)
            return
        end
        auraActive = true
        Btn2.Text = "ВЫКЛЮЧИТЬ АУРУ ПЕРЕНОСА"
        Btn2.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
        Status.Text = "Аура активна! Бегай рядом с предметами."
        Status.TextColor3 = Color3.fromRGB(0, 180, 120)
        
        local lastScanTime = 0
        local stackCount = 0
        auraConnection = RunService.Heartbeat:Connect(function()
            local char = localPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root or not redBallMarker then return end
            
            local currentTime = tick()
            local customDelay = tonumber(FreqBox.Text) or 0.25
            
            if currentTime - lastScanTime > customDelay then
                lastScanTime = currentTime
                local customRadius = tonumber(RadiusBox.Text) or 15
                
                for _, part in ipairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part.Anchored and part.Name ~= "AuraTPMarker" and not part:IsDescendantOf(char) then
                        if not part.Parent:FindFirstChildOfClass("Humanoid") and (part.Parent.Parent == nil or not part.Parent.Parent:FindFirstChildOfClass("Humanoid")) then
                            
                            local dist = (part.Position - root.Position).Magnitude
                            if dist <= customRadius then
                                pcall(function()
                                    -- СОВРЕМЕННЫЙ ТЕЛЕПОРТ ЧЕРЕЗ PIVOTTO
                                    local targetCFrame = CFrame.new(redBallMarker.Position + Vector3.new(0, (stackCount % 35) * 0.15, 0))
                                    part:PivotTo(targetCFrame)
                                    
                                    part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                    part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                    stackCount = stackCount + 1
                                end)
                            end
                            
                        end
                    end
                end
            end
        end)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.Insert then MainFrame.Visible = not MainFrame.Visible end
end)

RadiusBox.FocusLost:Connect(function()
    if not tonumber(RadiusBox.Text) then RadiusBox.Text = "15" end
end)

FreqBox.FocusLost:Connect(function()
    if not tonumber(FreqBox.Text) then FreqBox.Text = "0.25" end
end)

CloseBtn.MouseButton1Click:Connect(function() 
    stopSelecting(); stopAura(); removeMarker(); ScreenGui:Destroy() 
end)
