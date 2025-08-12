-- Royal Hub v2.0 (Brookhaven)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Configurações
local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local themeColor = Color3.fromRGB(140, 0, 255)
local darkColor = Color3.fromRGB(30, 30, 35)
local textColor = Color3.new(1, 1, 1)

-- Remover GUI existente
if game.CoreGui:FindFirstChild("RoyalHub") then
    game.CoreGui:FindFirstChild("RoyalHub"):Destroy()
end

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHub"
screenGui.Parent = game.CoreGui

-- Frame principal (tamanho diferente para mobile)
local mainFrame = Instance.new("Frame")
mainFrame.Size = isMobile and UDim2.new(0.6, 0, 0.6, 0) or UDim2.new(0, 500, 0, 550)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = darkColor
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = themeColor
uiStroke.Thickness = 2

-- Barra de título com função de arrastar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel")
titleText.Text = "ROYAL HUB | Brookhaven RP"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Font = Enum.Font.GothamBold
titleText.TextColor3 = textColor
titleText.TextSize = isMobile and 16 or 18
titleText.BackgroundTransparency = 1
titleText.Parent = titleBar

-- Função para arrastar a GUI
local dragging, dragInput, dragStart, startPos
local function updateInput(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(updateInput)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Botão de fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = textColor
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Sidebar (Menu lateral)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
sidebar.Parent = mainFrame

-- Categorias do menu
local categories = {
    {"Player", {
        "Noclip",
        "Autoclick",
        "Copiar Roupa"
    }},
    {"Veículos", {
        "Spawnar Carro",
        "Teleportar Veículo"
    }},
    {"Casa", {
        "Unban House"
    }},
    {"Troll", {
        "Teleportar",
        "Loop Goto"
    }},
    {"Configurações", {
        "Mudar Cor",
        "Créditos"
    }}
}

-- Conteúdo principal
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -160, 1, -50)
contentFrame.Position = UDim2.new(0, 155, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Função para criar páginas
local function createPage(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Name = name
    frame.Parent = contentFrame
    return frame
end

-- Criar todas as páginas
local playerPage = createPage("PlayerPage")
local vehiclesPage = createPage("VehiclesPage")
local housePage = createPage("HousePage")
local trollPage = createPage("TrollPage")
local configPage = createPage("ConfigPage")

-- Variáveis de estado
local noclipEnabled = false
local autoClickEnabled = false
local loopGotoEnabled = false
local selectedPlayer = nil

-- Funções principais
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        LocalPlayer.Character.Humanoid:ChangeState(11)
    end
end

local function toggleAutoClick()
    autoClickEnabled = not autoClickEnabled
    -- Implementar autoclick
end

local function unbanHouse()
    -- Implementar unban house
end

local function spawnCar()
    -- Implementar spawn de carro
end

local function copyOutfit(target)
    -- Implementar copiar roupa
end

-- Criar botões do menu
local buttonY = 10
for _, category in ipairs(categories) do
    local categoryLabel = Instance.new("TextLabel")
    categoryLabel.Text = " "..category[1]
    categoryLabel.Size = UDim2.new(1, -10, 0, 25)
    categoryLabel.Position = UDim2.new(0, 5, 0, buttonY)
    categoryLabel.Font = Enum.Font.GothamBold
    categoryLabel.TextColor3 = themeColor
    categoryLabel.TextSize = 14
    categoryLabel.TextXAlignment = Enum.TextXAlignment.Left
    categoryLabel.BackgroundTransparency = 1
    categoryLabel.Parent = sidebar
    buttonY = buttonY + 30
    
    for _, item in ipairs(category[2]) do
        local itemButton = Instance.new("TextButton")
        itemButton.Text = "   "..item
        itemButton.Size = UDim2.new(1, -10, 0, 30)
        itemButton.Position = UDim2.new(0, 5, 0, buttonY)
        itemButton.Font = Enum.Font.Gotham
        itemButton.TextColor3 = textColor
        itemButton.TextSize = 13
        itemButton.TextXAlignment = Enum.TextXAlignment.Left
        itemButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        itemButton.Parent = sidebar
        Instance.new("UICorner", itemButton).CornerRadius = UDim.new(0, 4)
        
        -- Conectar funções aos botões
        if item == "Noclip" then
            itemButton.MouseButton1Click:Connect(toggleNoclip)
        elseif item == "Autoclick" then
            itemButton.MouseButton1Click:Connect(toggleAutoClick)
        elseif item == "Unban House" then
            itemButton.MouseButton1Click:Connect(unbanHouse)
        elseif item == "Spawnar Carro" then
            itemButton.MouseButton1Click:Connect(spawnCar)
        end
        
        buttonY = buttonY + 35
    end
    buttonY = buttonY + 15
end

-- Página de Player (Noclip, Autoclick, Copiar Roupa)
local noclipToggle = Instance.new("TextButton")
noclipToggle.Text = "Noclip: OFF"
noclipToggle.Size = UDim2.new(0.8, 0, 0, 40)
noclipToggle.Position = UDim2.new(0.1, 0, 0.1, 0)
noclipToggle.Parent = playerPage
-- (Adicionar estilo e função)

-- Página de Veículos
local carDropdown = Instance.new("TextButton")
carDropdown.Text = "Selecionar Carro ▼"
carDropdown.Size = UDim2.new(0.8, 0, 0, 40)
carDropdown.Position = UDim2.new(0.1, 0, 0.1, 0)
carDropdown.Parent = vehiclesPage
-- (Adicionar estilo e função)

-- Página de Casa
local unbanButton = Instance.new("TextButton")
unbanButton.Text = "Unban House"
unbanButton.Size = UDim2.new(0.8, 0, 0, 40)
unbanButton.Position = UDim2.new(0.1, 0, 0.1, 0)
unbanButton.Parent = housePage
-- (Adicionar estilo e função)

-- Página de Troll
local playerDropdown = Instance.new("TextButton")
playerDropdown.Text = "Selecionar Player ▼"
playerDropdown.Size = UDim2.new(0.6, 0, 0, 40)
playerDropdown.Position = UDim2.new(0.1, 0, 0.1, 0)
playerDropdown.Parent = trollPage
-- (Adicionar estilo e função)

local loopGotoToggle = Instance.new("TextButton")
loopGotoToggle.Text = "Loop Goto: OFF"
loopGotoToggle.Size = UDim2.new(0.6, 0, 0, 40)
loopGotoToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
loopGotoToggle.Parent = trollPage
-- (Adicionar estilo e função)

-- Página de Configurações
local colorPicker = Instance.new("TextButton")
colorPicker.Text = "Mudar Cor"
colorPicker.Size = UDim2.new(0.8, 0, 0, 40)
colorPicker.Position = UDim2.new(0.1, 0, 0.1, 0)
colorPicker.Parent = configPage
-- (Adicionar estilo e função)

local creditsFrame = Instance.new("Frame")
creditsFrame.Size = UDim2.new(0.8, 0, 0, 100)
creditsFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
creditsFrame.BackgroundColor3 = darkColor
creditsFrame.Parent = configPage
Instance.new("UICorner", creditsFrame).CornerRadius = UDim.new(0, 8)

local creditsText = Instance.new("TextLabel")
creditsText.Text = "Criado por:\nEodraxkk\nEinzbern"
creditsText.Size = UDim2.new(1, 0, 1, 0)
creditsText.Font = Enum.Font.Gotham
creditsText.TextColor3 = textColor
creditsText.TextSize = 14
creditsText.BackgroundTransparency = 1
creditsText.Parent = creditsFrame

-- Noclip loop
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Mostrar página inicial
playerPage.Visible = true

print("Royal Hub v2.0 carregado com sucesso!")
