-- Royal Hub GUI (Brookhaven Version) - Ajustada com imagem, scroll e animações
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local themeColor = Color3.fromRGB(140, 0, 255)

-- Remover GUI antiga
if game.CoreGui:FindFirstChild("RoyalHub") then
    game.CoreGui:FindFirstChild("RoyalHub"):Destroy()
end

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHub"
screenGui.Parent = game.CoreGui

-- Detectar mobile
local isMobile = UserInputService.TouchEnabled
local guiWidth = isMobile and 350 or 520
local guiHeight = isMobile and 370 or 560

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, guiWidth, 0, guiHeight)
mainFrame.Position = UDim2.new(0.5, 0, isMobile and 0.48 or 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = themeColor
uiStroke.Thickness = 2

-- Animação de pop-up ao abrir
mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, guiWidth, 0, guiHeight)
}):Play()

-- Barra de título
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)

local titleText = Instance.new("TextLabel")
titleText.Text = "ROYAL HUB | Brookhaven RP"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Font = Enum.Font.GothamBold
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.TextSize = 18
titleText.BackgroundTransparency = 1
titleText.Parent = titleBar

-- Botão de fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- Sidebar com scroll
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0, 150, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
sidebar.ScrollBarThickness = 4
sidebar.CanvasSize = UDim2.new(0, 0, 0, 0) -- ajustado dinamicamente
sidebar.Parent = mainFrame

-- Área de conteúdo
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -160, 1, -50)
contentFrame.Position = UDim2.new(0, 155, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Função para criar páginas
local pages = {}
local function CriarPagina(nome)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = contentFrame
    pages[nome] = page
end

-- Trocar páginas com animação
local function TrocarPagina(nome)
    for _, p in pairs(pages) do p.Visible = false end
    if pages[nome] then
        pages[nome].Visible = true
        pages[nome].BackgroundTransparency = 1
        TweenService:Create(pages[nome], TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end
end

-- Criar páginas + botões
local categories = {
    {"Informações", {"Início", "Spam/Client", "Personagem", "Trolar"}},
    {"Audio/Música", {"Roupas", "Casa", "Carro"}},
    {"Configurações", {}}
}

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
        itemButton.TextColor3 = Color3.new(1, 1, 1)
        itemButton.TextSize = 13
        itemButton.TextXAlignment = Enum.TextXAlignment.Left
        itemButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        itemButton.Parent = sidebar
        Instance.new("UICorner", itemButton).CornerRadius = UDim.new(0, 4)

        CriarPagina(item)
        itemButton.MouseButton1Click:Connect(function()
            TrocarPagina(item)
        end)

        buttonY = buttonY + 35
    end
    buttonY = buttonY + 15
end
sidebar.CanvasSize = UDim2.new(0, 0, 0, buttonY)

-- Página "Início" com imagem e bem-vindo
local inicioPage = pages["Início"]
local thumbType = Enum.ThumbnailType.AvatarBust
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)

local playerImage = Instance.new("ImageLabel")
playerImage.Size = UDim2.new(0, 120, 0, 120)
playerImage.Position = UDim2.new(0.5, -60, 0, 20)
playerImage.BackgroundTransparency = 1
playerImage.Image = content
playerImage.Parent = inicioPage

local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, 0, 0, 40)
welcomeText.Position = UDim2.new(0, 0, 0, 150)
welcomeText.BackgroundTransparency = 1
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextColor3 = Color3.new(1, 1, 1)
welcomeText.TextSize = 18
welcomeText.Text = "Bem-vindo, " .. LocalPlayer.DisplayName
welcomeText.Parent = inicioPage

-- Mostrar página inicial
TrocarPagina("Início")

-- Arrastar (PC + Mobile)
local dragging, dragInput, dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then updateInput(input) end
end)

print("Royal Hub GUI carregada com sucesso!")
