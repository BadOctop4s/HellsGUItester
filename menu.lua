local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("[Script] Iniciando script GUI executor...")

local function createRoundedFrame(parent, size, position, bgColor)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = bgColor
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.ClipsDescendants = true
    frame.Parent = parent

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 15)
    uicorner.Parent = frame

    return frame
end

local blur = Lighting:FindFirstChildOfClass("BlurEffect")
if not blur then
    blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = Lighting
    print("[Script] Blur criado")
else
    print("[Script] Blur existente encontrado")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TestGUIExecutor"
screenGui.Parent = playerGui

local loadingFrame = createRoundedFrame(screenGui, UDim2.new(0, 300, 0, 150), UDim2.new(0.5, 0, 0.5, 0), Color3.fromRGB(35, 35, 35))
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Text = "Carregando..."
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.TextColor3 = Color3.fromRGB(255,255,255)
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.TextSize = 28
loadingLabel.Parent = loadingFrame

local mainFrame = createRoundedFrame(screenGui, UDim2.new(0, 500, 0, 350), UDim2.new(0.5, 0, 0.5, 0), Color3.fromRGB(30,30,30))
mainFrame.Visible = false

local tabButtonsFrame = Instance.new("Frame")
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
tabButtonsFrame.BackgroundTransparency = 1
tabButtonsFrame.Parent = mainFrame

local tabs = {}

local function createTabButton(name, posScale)
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(posScale, 0, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = tabButtonsFrame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 15)
    uicorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80,80,80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60,60,60)}):Play()
    end)

    return btn
end

local mainTabBtn = createTabButton("Main", 0.05)
local teleportTabBtn = createTabButton("Teleport", 0.35)

local mainTabFrame = Instance.new("Frame")
mainTabFrame.Size = UDim2.new(1, 0, 1, -40)
mainTabFrame.Position = UDim2.new(0, 0, 0, 40)
mainTabFrame.BackgroundTransparency = 1
mainTabFrame.Parent = mainFrame

local teleportTabFrame = Instance.new("Frame")
teleportTabFrame.Size = mainTabFrame.Size
teleportTabFrame.Position = mainTabFrame.Position
teleportTabFrame.BackgroundTransparency = 1
teleportTabFrame.Visible = false
teleportTabFrame.Parent = mainFrame

tabs["Main"] = mainTabFrame
tabs["Teleport"] = teleportTabFrame

local function switchTab(name)
    for tabName, frame in pairs(tabs) do
        frame.Visible = (tabName == name)
    end
end

switchTab("Main")

mainTabBtn.MouseButton1Click:Connect(function()
    switchTab("Main")
end)

teleportTabBtn.MouseButton1Click:Connect(function()
    switchTab("Teleport")
end)

-- Conteúdo Main

local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size180x180
local userId = player.UserId
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

local avatarImage = Instance.new("ImageLabel")
avatarImage.Image = content
avatarImage.Size = UDim2.new(0, 180, 0, 180)
avatarImage.Position = UDim2.new(0.5, -90, 0, 30)
avatarImage.BackgroundTransparency = 1
avatarImage.Parent = mainTabFrame
avatarImage.ScaleType = Enum.ScaleType.Fit
avatarImage.ClipsDescendants = true

local userNameLabel = Instance.new("TextLabel")
userNameLabel.Text = player.Name
userNameLabel.Font = Enum.Font.GothamBold
userNameLabel.TextSize = 24
userNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
userNameLabel.BackgroundTransparency = 1
userNameLabel.Size = UDim2.new(1, 0, 0, 30)
userNameLabel.Position = UDim2.new(0, 0, 0, 220)
userNameLabel.Parent = mainTabFrame
userNameLabel.TextScaled = true
userNameLabel.TextWrapped = true

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Text = "Criado por Eodraxkk"
creatorLabel.Font = Enum.Font.Gotham -- corrigido aqui
creatorLabel.TextSize = 18
creatorLabel.TextColor3 = Color3.fromRGB(180,180,180)
creatorLabel.BackgroundTransparency = 1
creatorLabel.Size = UDim2.new(1, 0, 0, 25)
creatorLabel.Position = UDim2.new(0, 0, 0, 260)
creatorLabel.Parent = mainTabFrame
creatorLabel.TextScaled = true
creatorLabel.TextWrapped = true

local supportButton = Instance.new("TextButton")
supportButton.Size = UDim2.new(0, 120, 0, 40)
supportButton.Position = UDim2.new(0.5, -60, 0, 300)
supportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
supportButton.Text = "Apoiar"
supportButton.TextColor3 = Color3.fromRGB(255,255,255)
supportButton.Font = Enum.Font.GothamSemibold
supportButton.TextSize = 20
supportButton.AutoButtonColor = false
supportButton.Parent = mainTabFrame

local uicornerSupport = Instance.new("UICorner")
uicornerSupport.CornerRadius = UDim.new(0, 15)
uicornerSupport.Parent = supportButton

supportButton.MouseEnter:Connect(function()
    TweenService:Create(supportButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
end)
supportButton.MouseLeave:Connect(function()
    TweenService:Create(supportButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
end)

supportButton.MouseButton1Click:Connect(function()
    local url = "https://www.roblox.com/users/12345678/profile"
    if setclipboard then
        setclipboard(url)
    end
    print("[Script] Link para apoiar copiado para área de transferência.")
end)

-- Conteúdo Teleport

local testButton = Instance.new("TextButton")
testButton.Size = UDim2.new(0, 150, 0, 50)
testButton.Position = UDim2.new(0.5, -75, 0, 50)
testButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
testButton.Text = "Botão de Teste"
testButton.TextColor3 = Color3.fromRGB(255,255,255)
testButton.Font = Enum.Font.GothamSemibold
testButton.TextSize = 20
testButton.AutoButtonColor = false
testButton.Parent = teleportTabFrame

local uicornerTest = Instance.new("UICorner")
uicornerTest.CornerRadius = UDim.new(0, 15)
uicornerTest.Parent = testButton

testButton.MouseEnter:Connect(function()
    TweenService:Create(testButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
end)
testButton.MouseLeave:Connect(function()
    TweenService:Create(testButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
end)

testButton.MouseButton1Click:Connect(function()
    print("[Script] Botão de teste clicado!")
end)

coroutine.wrap(function()
    wait(2)
    if loadingFrame and loadingFrame.Parent then
        loadingFrame:Destroy()
    end
    if blur and blur.Parent then
        blur:Destroy()
    end
    mainFrame.Visible = true
    print("[Script] Loading removido e GUI mostrada.")
end)()