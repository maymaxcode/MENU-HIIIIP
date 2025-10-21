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

-- GUI Setup with Tabs and Animations
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 1 -- Start transparent for fade in
MainFrame.Parent = ScreenGui

local UIGradientMain = Instance.new("UIGradient")
UIGradientMain.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
UIGradientMain.Parent = MainFrame

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 20)
UICornerMain.Parent = MainFrame

-- Fade in animation
TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
TitleBar.Parent = MainFrame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 20)
UICornerTitle.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "💜 Advanced Menu 💜"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(0.75, 0, 0.5, -20)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(128, 0, 128)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 30
MinimizeButton.Parent = TitleBar

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 10)
UICornerMin.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(0.9, 0, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 22
CloseButton.Parent = TitleBar

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 10)
UICornerClose.Parent = CloseButton

-- Tabs
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 50)
TabFrame.Position = UDim2.new(0, 0, 0, 60)
TabFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
TabFrame.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Parent = TabFrame

local Tabs = {"Movement", "Combat", "Visuals", "Misc"}
local CurrentTab = "Movement"
local TabButtons = {}
local ContentFrames = {}

for _, tabName in pairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.25, 0, 1, 0)
    TabButton.BackgroundColor3 = tabName == CurrentTab and Color3.fromRGB(128, 0, 128) or Color3.fromRGB(255, 255, 255)
    TabButton.Text = tabName
    TabButton.TextColor3 = tabName == CurrentTab and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 0, 128)
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 18
    TabButton.Parent = TabFrame
    TabButtons[tabName] = TabButton

    TabButton.MouseButton1Click:Connect(function()
        CurrentTab = tabName
        for name, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = name == CurrentTab and Color3.fromRGB(128, 0, 128) or Color3.fromRGB(255, 255, 255)
            btn.TextColor3 = name == CurrentTab and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(128, 0, 128)
        end
        for name, frame in pairs(ContentFrames) do
            frame.Visible = name == CurrentTab
        end
    end)

    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -160)
    ContentFrame.Position = UDim2.new(0, 10, 0, 110)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(128, 0, 128)
    ContentFrame.Visible = tabName == CurrentTab
    ContentFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ContentFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    ContentFrames[tabName] = ContentFrame
end

-- Minimize and Close Functions
local Minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        for _, frame in pairs(ContentFrames) do frame.Visible = false end
        MainFrame.Size = UDim2.new(0, 400, 0, 60)
        MinimizeButton.Text = "+"
    else
        ContentFrames[CurrentTab].Visible = true
        MainFrame.Size = UDim2.new(0, 400, 0, 550)
        MinimizeButton.Text = "−"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Utility Functions
local function CreateButton(text, callback, tab)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.Parent = ContentFrames[tab]
    Button.MouseButton1Click:Connect(callback)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Button
    -- Hover animation
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150, 0, 150)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(128, 0, 128)}):Play()
    end)
    return Button
end

local function CreateToggle(text, callback, tab)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 45)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ContentFrames[tab]

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.8, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0, 0, 0, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    ToggleButton.Text = text .. " [OFF]"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.TextSize = 18
    ToggleButton.Parent = ToggleFrame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = ToggleButton

    local Status = false
    ToggleButton.MouseButton1Click:Connect(function()
        Status = not Status
        ToggleButton.Text = text .. (Status and " [ON]" or " [OFF]")
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(128, 0, 128)}):Play()
        callback(Status)
    end)
    -- Hover animation
    ToggleButton.MouseEnter:Connect(function()
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Status and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 0, 150)}):Play()
    end)
    ToggleButton.MouseLeave:Connect(function()
        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(128, 0, 128)}):Play()
    end)
end

local function CreateSlider(text, min, max, default, callback, tab)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -10, 0, 65)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = ContentFrames[tab]

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(128, 0, 128)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 16
    Label.Parent = SliderFrame

    local Slider = Instance.new("Frame")
    Slider.Size = UDim2.new(1, 0, 0, 25)
    Slider.Position = UDim2.new(0, 0, 0, 30)
    Slider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Slider.Parent = SliderFrame
    local UICornerSlider = Instance.new("UICorner")
    UICornerSlider.CornerRadius = UDim.new(0, 12)
    UICornerSlider.Parent = Slider

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
    Fill.Parent = Slider
    local UICornerFill = Instance.new("UICorner")
    UICornerFill.CornerRadius = UDim.new(0, 12)
    UICornerFill.Parent = Fill

    local Value = default
    Slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                local mouse = UserInputService:GetMouseLocation()
                local relative = (mouse.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
                Value = math.clamp(min + (max - min) * relative, min, max)
                TweenService:Create(Fill, TweenInfo.new(0.1), {Size = UDim2.new((Value - min) / (max - min), 0, 1, 0)}):Play()
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

local function ToggleFlyYen(enabled)
    FlyEnabled = enabled
    if enabled then
        FlyConnection = RunService.RenderStepped:Connect(function()
            if Humanoid and RootPart then
                local moveDirection = Humanoid.MoveDirection
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
                        -- Multiple kill methods
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                        -- Alternative: FireServer if available
                        local args = {player.Character}
                        if game.ReplicatedStorage:FindFirstChild("DamageEvent") then
                            game.ReplicatedStorage.DamageEvent:FireServer(unpack(args))
                        end
                        -- Touch interest as fallback
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
CreateToggle("Fly", ToggleFlyYen, "Movement")
CreateSlider("Fly Speed", 10, 200, 50, function(value) FlySpeed = value end, "Movement")

CreateToggle("No Clip", ToggleNoClip, "Movement")

CreateToggle("Speed Hack", ToggleSpeed, "Movement")
CreateSlider("Speed", 16, 200, 16, function(value) SpeedValue = value; if SpeedEnabled then Humanoid.WalkSpeed = value end end, "Movement")

CreateToggle("Jump Boost", ToggleJump, "Movement")
CreateSlider("Jump Power", 50, 500, 50, function(value) JumpValue = value; if JumpEnabled then Humanoid.JumpPower = value end end, "Movement")

CreateToggle("Infinite Jump", function(enabled)
    if enabled then
        UserInputService.JumpRequest:Connect(function()
            if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end, "Movement")

CreateToggle("Godmode", ToggleGodmode, "Combat")

CreateToggle("Kill Aura", ToggleKillAura, "Combat")
CreateSlider("Kill Aura Range", 5, 50, 10, function(value) KillAuraRange = value end, "Combat")

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
end, "Combat")

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
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Wait()
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
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character.Head:FindFirstChild("BillboardGui") then
                player.Character.Head.BillboardGui:Destroy()
            end
        end
    end
end, "Visuals")

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
end, "Visuals")

CreateButton("Teleport to Player", function()
    local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())] -- Random for demo, replace with input
    if target and target.Character and RootPart then
        RootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end, "Misc")

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
end, "Misc")

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
