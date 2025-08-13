-- Loader.lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local REPO_URL = "https://raw.githubusercontent.com/BadOctop4s/RoyalHub/main/Source.lua"
local LOADING_MIN_TIME = 2.5

-- Criar blur
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 15}):Play()

-- Criar GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHubLoader"
screenGui.Parent = game.CoreGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 400, 0, 180)
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
loadingFrame.Parent = screenGui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local loadingText = Instance.new("TextLabel")
loadingText.Text = "Royal Hub v1.0"
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0.5, 0, 0.2, 0)
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.fromRGB(220, 220, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 22
loadingText.Parent = loadingFrame

local statusText = Instance.new("TextLabel")
statusText.Text = "Iniciando..."
statusText.Size = UDim2.new(1, -40, 0, 20)
statusText.Position = UDim2.new(0.5, 0, 0.4, 0)
statusText.AnchorPoint = Vector2.new(0.5, 0.5)
statusText.BackgroundTransparency = 1
statusText.TextColor3 = Color3.fromRGB(180, 180, 255)
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 14
statusText.Parent = loadingFrame

local progressBarBack = Instance.new("Frame")
progressBarBack.Size = UDim2.new(0.8, 0, 0, 20)
progressBarBack.Position = UDim2.new(0.5, 0, 0.6, 0)
progressBarBack.AnchorPoint = Vector2.new(0.5, 0.5)
progressBarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
progressBarBack.Parent = loadingFrame
Instance.new("UICorner", progressBarBack).CornerRadius = UDim.new(0, 10)

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
progressBar.Parent = progressBarBack
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 10)

local function updateStatus(text, progress)
    statusText.Text = text
    if progress then
        TweenService:Create(progressBar, TweenInfo.new(0.3), {Size = UDim2.new(progress, 0, 1, 0)}):Play()
    end
end

task.spawn(function()
    local startTime = tick()
    updateStatus("Conectando...", 0.2)
    pcall(function() game:HttpGet("https://google.com") end)

    updateStatus("Carregando script...", 0.5)
    local success, content = pcall(function()
        return game:HttpGet(REPO_URL)
    end)

    if not success or #content < 50 then
        updateStatus("Falha ao carregar", 1)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(2)
        screenGui:Destroy()
        return
    end

    local elapsed = tick() - startTime
    if elapsed < LOADING_MIN_TIME then
        task.wait(LOADING_MIN_TIME - elapsed)
    end

    updateStatus("Executando...", 1)
    task.wait(0.5)
    pcall(loadstring(content))

    -- Fechar com animação
    TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()
    TweenService:Create(loadingFrame, TweenInfo.new(0.4), {Position = UDim2.new(0.5, 0, 1.5, 0)}):Play()
    task.wait(0.5)
    blur:Destroy()
    screenGui:Destroy()
end)
