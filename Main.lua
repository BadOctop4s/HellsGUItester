-- Loader.lua (Para colocar em StarterPlayerScripts)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- Configurações
local REPO_URL = "https://raw.githubusercontent.com/Eodraxkk/RoyalHub/main/MainGUI.lua"
local LOADING_MIN_TIME = 2.5 -- Tempo mínimo de loading (para efeito visual)

-- Criar GUI de loading
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

-- Barra de progresso
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

-- Função para atualizar status
local function updateStatus(text, progress)
    statusText.Text = text
    if progress then
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
    end
end

-- Animação de loading suave
spawn(function()
    local startTime = tick()
    while tick() - startTime < LOADING_MIN_TIME do
        local progress = (tick() - startTime) / LOADING_MIN_TIME
        progressBar.Size = UDim2.new(progress * 0.8, 0, 1, 0)
        wait()
    end
end)

-- Carregamento principal
spawn(function()
    updateStatus("Conectando ao GitHub...", 0.2)
    
    local success, response = pcall(function()
        return HttpService:GetAsync(REPO_URL, true)
    end)
    
    if not success then
        updateStatus("Falha na conexão", 1)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        wait(2)
        screenGui:Destroy()
        return
    end

    updateStatus("Validando script...", 0.5)
    wait(0.5)
    
    updateStatus("Compilando...", 0.7)
    local compiled, err = loadstring(response)
    
    if not compiled then
        updateStatus("Erro na compilação", 1)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        warn("Erro no script: "..tostring(err))
        wait(2)
        screenGui:Destroy()
        return
    end

    updateStatus("Executando...", 0.9)
    wait(0.3)
    
    local execSuccess, execErr = pcall(compiled)
    if not execSuccess then
        updateStatus("Erro na execução", 1)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        warn("Erro na execução: "..tostring(execErr))
        wait(2)
        screenGui:Destroy()
        return
    end

    updateStatus("Sucesso! Carregando...", 1)
    wait(0.5)
    
    screenGui:Destroy()
end)

-- Fechar se demorar muito
delay(10, function()
    if screenGui and screenGui.Parent then
        updateStatus("Timeout - Verifique sua conexão", 1)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        wait(2)
        screenGui:Destroy()
    end
end)
