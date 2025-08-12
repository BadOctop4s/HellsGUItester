-- Loader.lua (Coloque em StarterPlayerScripts)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Configurações
local LOADING_TIME = 2.5 -- Tempo de carga em segundos
local REPO_URL = "https://raw.githubusercontent.com/badoctopus/RoyalHub/main/Source.lua"

-- Criar GUI de loading
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingGUI"
screenGui.Parent = game.CoreGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 400, 0, 150)
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.Parent = screenGui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local loadingText = Instance.new("TextLabel")
loadingText.Text = "Royal Hub - Carregando..."
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0.5, 0, 0.3, 0)
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.BackgroundTransparency = 1
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 20
loadingText.Parent = loadingFrame

-- Barra de progresso
local progressBarBack = Instance.new("Frame")
progressBarBack.Size = UDim2.new(0.8, 0, 0, 20)
progressBarBack.Position = UDim2.new(0.5, 0, 0.7, 0)
progressBarBack.AnchorPoint = Vector2.new(0.5, 0.5)
progressBarBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
progressBarBack.Parent = loadingFrame
Instance.new("UICorner", progressBarBack).CornerRadius = UDim.new(0, 10)

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.Parent = progressBarBack
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 10)

-- Animação de carga
spawn(function()
    local startTime = tick()
    while tick() - startTime < LOADING_TIME do
        local progress = (tick() - startTime) / LOADING_TIME
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        wait()
    end
    
    -- Carregar o script principal
    local success, err = pcall(function()
        local mainScript = game:HttpGet(REPO_URL)
        loadstring(mainScript)()
    end)
    
    if not success then
        warn("Falha ao carregar: "..err)
    end
    
    screenGui:Destroy()
end)
