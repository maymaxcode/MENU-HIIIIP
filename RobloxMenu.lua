-- Roblox Advanced Menu Script for Delta Executor
-- Features: TP, Fly, Kill, Kill Aura, No Clip, Speed Hack, Jump Boost, Godmode, and more

if not game then warn("Script must be run in Roblox environment.") return end

print("Script loaded successfully!") -- Debug print to confirm execution

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Character:FindFirstChild("HumanoidRootPart")

-- Loading Screen
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingScreen"
LoadingGui.ResetOnSpawn = false
LoadingGui.Parent = game:GetService("CoreGui")

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = LoadingGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = LoadingFrame

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0.7, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading Advanced Menu..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.Font = Enum.Font.SourceSansBold
LoadingText.TextSize = 20
LoadingText.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 0, 10)
LoadingBar.Position = UDim2.new(0, 10, 0, 70)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
LoadingBar.Parent = LoadingFrame

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Size = UDim2.new(1, -20, 0, 10)
LoadingBarBG.Position = UDim2.new(0, 10, 0, 70)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LoadingBarBG.Parent = LoadingFrame

-- Animate Loading
local tween = TweenService:Create(LoadingBar, TweenInfo.new(2), {Size = UDim2.new(1, -20, 0, 10)})
tween:Play()
wait(2)
LoadingGui:Destroy()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 10)
UICornerTitle.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Advanced Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(0.75, 0, 0.5, -15)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 24
MinimizeButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0.9, 0, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Minimize and Close Functions
local Minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        ScrollingFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 300, 0, 40)
        MinimizeButton.Text = "+"
    else
        ScrollingFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 300, 0, 400)
        MinimizeButton.Text = "-"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Utility Functions
local function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 18
    Button.Parent = ScrollingFrame
    Button.MouseButton1Click:Connect(callback)
    return Button
end

local function CreateToggle(text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ScrollingFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.8, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.Text = text .. " [OFF]"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.TextSize = 18
    ToggleButton.Parent = ToggleFrame

    local Status = false
    ToggleButton.MouseButton1Click:Connect(function()
        Status = not Status
        ToggleButton.Text = text .. (Status and " [ON]" or " [OFF]")
        ToggleButton.BackgroundColor3 = Status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
        callback(Status)
    end)
end

local function CreateSlider(text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -10, 0, 60)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ScrollingFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 16
    Label.Parent = SliderFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, 0, 0, 20)
    Slider.Position = UDim2.new(0, 0, 0, 25)
    Slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Slider.Parent = SliderFrame

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Fill.Parent = Slider

    local Value = default
    Slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local mouse = UserInputService:GetMouseLocation()
                local relative = (mouse.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
                Value = math.clamp(min + (max - min) * relative, min, max)
                Fill.Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)
                Label.Text = text .. ": " .. math.floor(Value)
                callback(Value)
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                end
            end)
        end
    end)
end

-- Features
local FlyEnabled = false
local FlySpeed = 50
local FlyConnection

local function ToggleFly(enabled)
    FlyEnabled = enabled
    if enabled then
        FlyConnection = RunService.RenderStepped:Connect(function()
            if Humanoid and RootPart then
                local moveDirection = Humanoid.MoveDirection
                RootPart:ApplyAngularImpulse(Vector3.new(0, 0, 0))
                RootPart.Velocity = moveDirection * FlySpeed
            end
        end)
    else
        if FlyConnection then FlyConnection:Disconnect() end
        if RootPart then RootPart.Velocity = Vector3.new(0, 0, 0) end
    end
end

local NoClipEnabled = false
local NoClipConnection

local function ToggleNoClip(enabled)
    NoClipEnabled = enabled
    if enabled then
        NoClipConnection = RunService.Stepped:Connect(function()
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    else
        if NoClipConnection then NoClipConnection:Disconnect() end
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local SpeedEnabled = false
local SpeedValue = 16

local function ToggleSpeed(enabled)
    SpeedEnabled = enabled
    if Humanoid then
        Humanoid.WalkSpeed = enabled and SpeedValue or 16
    end
end

local JumpEnabled = false
local JumpValue = 50

local function ToggleJump(enabled)
    JumpEnabled = enabled
    if Humanoid then
        Humanoid.JumpPower = enabled and JumpValue or 50
    end
end

local GodmodeEnabled = false

local function ToggleGodmode(enabled)
    GodmodeEnabled = enabled
    if Humanoid then
        Humanoid.MaxHealth = enabled and math.huge or 100
        Humanoid.Health = enabled and math.huge or 100
    end
end

local KillAuraEnabled = false
local KillAuraRange = 10
local KillAuraConnection

local function ToggleKillAura(enabled)
    KillAuraEnabled = enabled
    if enabled then
        KillAuraConnection = RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local distance = (player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                    if distance <= KillAuraRange then
                        -- Kill logic, assuming tool or exploit function
                        local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                            wait(0.1)
                            firetouchinterest(tool.Handle, player.Character.HumanoidRootPart, 0)
                            firetouchinterest(tool.Handle, player.Character.HumanoidRootPart, 1)
                        end
                    end
                end
            end
        end)
    else
        if KillAuraConnection then KillAuraConnection:Disconnect() end
    end
end

-- Buttons and Toggles
CreateToggle("Fly", ToggleFly)
CreateSlider("Fly Speed", 10, 200, 50, function(value) FlySpeed = value end)

CreateToggle("No Clip", ToggleNoClip)

CreateToggle("Speed Hack", ToggleSpeed)
CreateSlider("Speed", 16, 200, 16, function(value) SpeedValue = value; if SpeedEnabled then Humanoid.WalkSpeed = value end end)

CreateToggle("Jump Boost", ToggleJump)
CreateSlider("Jump Power", 50, 500, 50, function(value) JumpValue = value; if JumpEnabled then Humanoid.JumpPower = value end end)

CreateToggle("Godmode", ToggleGodmode)

CreateToggle("Kill Aura", ToggleKillAura)
CreateSlider("Kill Aura Range", 5, 50, 10, function(value) KillAuraRange = value end)

CreateToggle("Infinite Jump", function(enabled)
    if enabled then
        UserInputService.JumpRequest:Connect(function()
            if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end)

CreateToggle("ESP", function(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local esp = Instance.new("BillboardGui")
                esp.Size = UDim2.new(0, 100, 0, 50)
                esp.StudsOffset = Vector3.new(0, 2, 0)
                esp.Adornee = player.Character.Head
                esp.Parent = player.Character.Head
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = player.Name
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 14
                label.Parent = esp
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character.Head:FindFirstChild("BillboardGui") then
                player.Character.Head.BillboardGui:Destroy()
            end
        end
    end
end)

CreateToggle("Aimbot", function(enabled)
    if enabled then
        local aimbotConnection = RunService.RenderStepped:Connect(function()
            local closest = nil
            local minDist = math.huge
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local dist = (player.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = player
                    end
                end
            end
            if closest then
                local direction = (closest.Character.Head.Position - LocalPlayer.Character.Head.Position).Unit
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position + direction)
            end
        end)
        -- Store connection to disconnect later if needed
    end
end)

CreateButton("Teleport to Player", function()
    local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())] -- Random for demo, replace with input
    if target and target.Character and RootPart then
        RootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

CreateButton("Kill Player", function()
    local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())] -- Random for demo
    if target and target.Character then
        local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
            firetouchinterest(tool.Handle, target.Character.HumanoidRootPart, 0)
            firetouchinterest(tool.Handle, target.Character.HumanoidRootPart, 1)
        end
    end
end)

CreateButton("Anti-Kick", function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then
            return nil
        end
        return old(self, ...)
    end
    setreadonly(mt, true)
end)

-- Draggable Menu
local dragging = false
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Cleanup on character change
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    RootPart = Character:FindFirstChild("HumanoidRootPart")
    if FlyEnabled then ToggleFly(true) end
    if NoClipEnabled then ToggleNoClip(true) end
    if SpeedEnabled then ToggleSpeed(true) end
    if JumpEnabled then ToggleJump(true) end
    if GodmodeEnabled then ToggleGodmode(true) end
    if KillAuraEnabled then ToggleKillAura(true) end
end)
