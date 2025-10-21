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

-- GUI Setup with Rectangular Design and Dark Purple Theme
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 40) -- Dark purple
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 1 -- Start transparent for fade in
MainFrame.Parent = ScreenGui

local UIGradientMain = Instance.new("UIGradient")
UIGradientMain.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}
UIGradientMain.Parent = MainFrame

-- Fade in animation
TweenService:Create(MainFrame, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 0, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Advanced Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(0.75, 0, 0.5, -17.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 28
MinimizeButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(0.9, 0, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.Parent = TitleBar

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 0, 200)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Minimize and Close Functions
local Minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        ScrollingFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 350, 0, 50)
        MinimizeButton.Text = "+"
    else
        ScrollingFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 350, 0, 500)
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

local function ToggleKillAura(enabled)
    KillAuraEnabled = enabled
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local L_7_ = coroutine.create(function()
                    RunService.RenderStepped:Connect(function()
                        local L_8_, L_9_ = pcall(function()
                            local L_10_ = player.Character
                            if L_10_ and L_10_:FindFirstChild("HumanoidRootPart") then
                                local distance = (L_10_.HumanoidRootPart.Position - RootPart.Position).Magnitude
                                if distance <= KillAuraRange then
                                    -- Bring player close, clear tools, and damage with local player's tool
                                    player.Backpack:ClearAllChildren()
                                    for L_11_forvar1, L_12_forvar2 in pairs(L_10_:GetChildren()) do
                                        if L_12_forvar2:IsA("Tool") then
                                            L_12_forvar2:Destroy()
                                        end
                                    end
                                    L_10_.HumanoidRootPart.CFrame = CFrame.new(RootPart.Position - Vector3.new(5, 0, 0))
                                    -- Use local player's tool to damage
                                    local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate()
                                        wait(0.1)
                                        firetouchinterest(tool.Handle, L_10_.HumanoidRootPart, 0)
                                        firetouchinterest(tool.Handle, L_10_.HumanoidRootPart, 1)
                                    end
                                end
                            end
                        end)
                        if not L_8_ then
                            warn("Kill Aura error: " .. L_9_)
                        end
                    end)
                end)
                coroutine.resume(L_7_)
            end
        end
        Players.PlayerAdded:Connect(function(player)
            if player ~= LocalPlayer then
                local L_14_ = coroutine.create(function()
                    RunService.RenderStepped:Connect(function()
                        local L_15_, L_16_ = pcall(function()
                            local L_17_ = player.Character
                            if L_17_ and L_17_:FindFirstChild("HumanoidRootPart") then
                                local distance = (L_17_.HumanoidRootPart.Position - RootPart.Position).Magnitude
                                if distance <= KillAuraRange then
                                    -- Bring player close, clear tools, and damage with local player's tool
                                    player.Backpack:ClearAllChildren()
                                    for L_18_forvar1, L_19_forvar2 in pairs(L_17_:GetChildren()) do
                                        if L_19_forvar2:IsA("Tool") then
                                            L_19_forvar2:Destroy()
                                        end
                                    end
                                    L_17_.HumanoidRootPart.CFrame = CFrame.new(RootPart.Position - Vector3.new(5, 0, 0))
                                    -- Use local player's tool to damage
                                    local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate()
                                        wait(0.1)
                                        firetouchinterest(tool.Handle, L_17_.HumanoidRootPart, 0)
                                        firetouchinterest(tool.Handle, L_17_.HumanoidRootPart, 1)
                                    end
                                end
                            end
                        end)
                        if not L_15_ then
                            warn("Kill Aura error: " .. L_16_)
                        end
                    end)
                end)
                coroutine.resume(L_14_)
            end
        end)
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
        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
        -- Alternative: FireServer if available
        local args = {target.Character}
        if game.ReplicatedStorage:FindFirstChild("DamageEvent") then
            game.ReplicatedStorage.DamageEvent:FireServer(unpack(args))
        end
        -- Touch interest as fallback
        local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
            wait(0.1)
            firetouchinterest(tool.Handle, target.Character.HumanoidRootPart, 0)
            firetouchinterest(tool.Handle, target.Character.HumanoidRootPart, 1)
        end
    end
end, "Combat")

CreateToggle("ESP", function(enabled)
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = player.Character:GetExtentsSize()
                box.Adornee = player.Character
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Color3 = Color3.fromRGB(255, 0, 0)
                box.Transparency = 0.5
                box.Parent = player.Character

                local healthBar = Instance.new("BillboardGui")
                healthBar.Size = UDim2.new(0, 100, 0, 20)
                healthBar.StudsOffset = Vector3.new(0, 3, 0)
                healthBar.Adornee = player.Character.Head
                healthBar.Parent = player.Character.Head

                local healthFrame = Instance.new("Frame")
                healthFrame.Size = UDim2.new(1, 0, 1, 0)
                healthFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                healthFrame.Parent = healthBar

                local healthFill = Instance.new("Frame")
                healthFill.Size = UDim2.new(1, 0, 1, 0)
                healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                healthFill.Parent = healthFrame

                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    healthFill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
                end

                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Size = UDim2.new(1, 0, 0, 20)
                distanceLabel.Position = UDim2.new(0, 0, 1, 0)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.Text = "Distance: " .. math.floor((player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude)
                distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                distanceLabel.Font = Enum.Font.SourceSansBold
                distanceLabel.TextSize = 12
                distanceLabel.Parent = healthBar
            end
        end
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Wait()
            local box = Instance.new("BoxHandleAdornment")
            box.Size = player.Character:GetExtentsSize()
            box.Adornee = player.Character
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Color3 = Color3.fromRGB(255, 0, 0)
            box.Transparency = 0.5
            box.Parent = player.Character

            local healthBar = Instance.new("BillboardGui")
            healthBar.Size = UDim2.new(0, 100, 0, 20)
            healthBar.StudsOffset = Vector3.new(0, 3, 0)
            healthBar.Adornee = player.Character.Head
            healthBar.Parent = player.Character.Head

            local healthFrame = Instance.new("Frame")
            healthFrame.Size = UDim2.new(1, 0, 1, 0)
            healthFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            healthFrame.Parent = healthBar

            local healthFill = Instance.new("Frame")
            healthFill.Size = UDim2.new(1, 0, 1, 0)
            healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            healthFill.Parent = healthFrame

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                healthFill.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
            end

            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Size = UDim2.new(1, 0, 0, 20)
            distanceLabel.Position = UDim2.new(0, 0, 1, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.Text = "Distance: " .. math.floor((player.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude)
            distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            distanceLabel.Font = Enum.Font.SourceSansBold
            distanceLabel.TextSize = 12
            distanceLabel.Parent = healthBar
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, child in pairs(player.Character:GetChildren()) do
                    if child:IsA("BoxHandleAdornment") or child:IsA("BillboardGui") then
                        child:Destroy()
                    end
                end
                if player.Character.Head:FindFirstChild("BillboardGui") then
                    player.Character.Head.BillboardGui:Destroy()
                end
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
