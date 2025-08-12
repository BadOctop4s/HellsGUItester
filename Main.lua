-- Loader.lua

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Configurações
local LOADING_TIME = 3 -- Tempo de carga em segundos
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

-- Barra de progresso
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 0, 20)
progressBar.Position = UDim2.new(0.5, 0, 0.7, 0)
progressBar.AnchorPoint = Vector2.new(0.5, 0.5)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.Parent = loadingFrame

-- Animação de carga
spawn(function()
    local startTime = tick()
    while tick() - startTime < LOADING_TIME do
        local progress = (tick() - startTime) / LOADING_TIME
        progressBar.Size = UDim2.new(progress * 0.8, 0, 0, 20)
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
