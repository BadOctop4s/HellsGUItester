-- Royal Hub GUI (Brookhaven Version)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Configurações
local LocalPlayer = Players.LocalPlayer
local themeColor = Color3.fromRGB(140, 0, 255) -- Roxo drip

-- Remover GUI existente
if game.CoreGui:FindFirstChild("RoyalHub") then
    game.CoreGui:FindFirstChild("RoyalHub"):Destroy()
end

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHub"
screenGui.Parent = game.CoreGui

-- Frame principal
local mainFrame = Instance.new("Frame")
local UserInputService = game:GetService("UserInputService")

if UserInputService.TouchEnabled then
    mainFrame.Size = UDim2.new(0, 325, 0, 358)
 -- menor para mobile
else
    mainFrame.Size = UDim2.new(0, 500, 0, 550) -- tamanho padrão para PC
end

mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = themeColor
uiStroke.Thickness = 2

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
    {"Informações", {
        "Início",
        "Spam/Client",
        "Personagem",
        "Trolar"
    }},
    {"Audio/Música", {
        "Roupas",
        "Casa",
        "Carro"
    }},
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
        
        buttonY = buttonY + 35
    end
    buttonY = buttonY + 15
end

-- Conteúdo principal
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -160, 1, -50)
contentFrame.Position = UDim2.new(0, 155, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Conteúdo da página inicial (exemplo)
local homeContent = Instance.new("Frame")
homeContent.Size = UDim2.new(1, 0, 1, 0)
homeContent.BackgroundTransparency = 1
homeContent.Visible = true
homeContent.Parent = contentFrame

-- Título do mapa
local mapTitle = Instance.new("TextLabel")
mapTitle.Text = "Mapa Status"
mapTitle.Size = UDim2.new(1, 0, 0, 30)
mapTitle.Font = Enum.Font.GothamBold
mapTitle.TextColor3 = themeColor
mapTitle.TextSize = 16
mapTitle.BackgroundTransparency = 1
mapTitle.Parent = homeContent

-- Informações do jogo
local gameInfo = Instance.new("TextLabel")
gameInfo.Text = "Nome do Jogo: Brookhaven RP\nExecutor: Royal Hub"
gameInfo.Size = UDim2.new(1, 0, 0, 50)
gameInfo.Position = UDim2.new(0, 0, 0, 40)
gameInfo.Font = Enum.Font.Gotham
gameInfo.TextColor3 = Color3.new(1, 1, 1)
gameInfo.TextSize = 14
gameInfo.TextXAlignment = Enum.TextXAlignment.Left
gameInfo.BackgroundTransparency = 1
gameInfo.Parent = homeContent

-- Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, 100)
divider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
divider.Parent = homeContent

-- Discord Widget
local discordFrame = Instance.new("Frame")
discordFrame.Size = UDim2.new(1, 0, 0, 120)
discordFrame.Position = UDim2.new(0, 0, 0, 110)
discordFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
discordFrame.Parent = homeContent
Instance.new("UICorner", discordFrame).CornerRadius = UDim.new(0, 6)

local discordTitle = Instance.new("TextLabel")
discordTitle.Text = "Royal Hub | Community"
discordTitle.Size = UDim2.new(1, 0, 0, 30)
discordTitle.Font = Enum.Font.GothamBold
discordTitle.TextColor3 = themeColor
discordTitle.TextSize = 16
discordTitle.BackgroundTransparency = 1
discordTitle.Parent = discordFrame

local discordText = Instance.new("TextLabel")
discordText.Text = "Junte-se a nossa comunidade discord para receber informações sobre menu!"
discordText.Size = UDim2.new(1, -20, 0, 50)
discordText.Position = UDim2.new(0, 10, 0, 35)
discordText.Font = Enum.Font.Gotham
discordText.TextColor3 = Color3.new(1, 1, 1)
discordText.TextSize = 13
discordText.TextWrapped = true
discordText.BackgroundTransparency = 1
discordText.Parent = discordFrame

local discordLink = Instance.new("TextButton")
discordLink.Text = "https://discord.gg/royalhub"
discordLink.Size = UDim2.new(1, -20, 0, 30)
discordLink.Position = UDim2.new(0, 10, 0, 85)
discordLink.Font = Enum.Font.Gotham
discordLink.TextColor3 = Color3.fromRGB(100, 150, 255)
discordLink.TextSize = 13
discordLink.BackgroundTransparency = 1
discordLink.Parent = discordFrame

-- Webhook Section
local webhookFrame = Instance.new("Frame")
webhookFrame.Size = UDim2.new(1, 0, 0, 150)
webhookFrame.Position = UDim2.new(0, 0, 0, 240)
webhookFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
webhookFrame.Parent = homeContent
Instance.new("UICorner", webhookFrame).CornerRadius = UDim.new(0, 6)

local webhookTitle = Instance.new("TextLabel")
webhookTitle.Text = "Sistema De WebHook"
webhookTitle.Size = UDim2.new(1, 0, 0, 30)
webhookTitle.Font = Enum.Font.GothamBold
webhookTitle.TextColor3 = themeColor
webhookTitle.TextSize = 16
webhookTitle.BackgroundTransparency = 1
webhookTitle.Parent = webhookFrame

local webhookText = Instance.new("TextLabel")
webhookText.Text = "De ideia de funções para melhorar o hub."
webhookText.Size = UDim2.new(1, -20, 0, 40)
webhookText.Position = UDim2.new(0, 10, 0, 35)
webhookText.Font = Enum.Font.Gotham
webhookText.TextColor3 = Color3.new(1, 1, 1)
webhookText.TextSize = 13
webhookText.TextWrapped = true
webhookText.BackgroundTransparency = 1
webhookText.Parent = webhookFrame

local messageBox = Instance.new("TextBox")
messageBox.PlaceholderText = "Digite sua ideia aqui..."
messageBox.Size = UDim2.new(1, -20, 0, 40)
messageBox.Position = UDim2.new(0, 10, 0, 80)
messageBox.Font = Enum.Font.Gotham
messageBox.TextColor3 = Color3.new(1, 1, 1)
messageBox.TextSize = 13
messageBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
messageBox.Parent = webhookFrame
Instance.new("UICorner", messageBox).CornerRadius = UDim.new(0, 4)

local sendButton = Instance.new("TextButton")
sendButton.Text = "Enviar Mensagem"
sendButton.Size = UDim2.new(1, -20, 0, 30)
sendButton.Position = UDim2.new(0, 10, 0, 130)
sendButton.Font = Enum.Font.GothamBold
sendButton.TextColor3 = Color3.new(1, 1, 1)
sendButton.TextSize = 14
sendButton.BackgroundColor3 = themeColor
sendButton.Parent = webhookFrame
Instance.new("UICorner", sendButton).CornerRadius = UDim.new(0, 4)

-- Anúncios
local announcementFrame = Instance.new("Frame")
announcementFrame.Size = UDim2.new(1, 0, 0, 80)
announcementFrame.Position = UDim2.new(0, 0, 0, 400)
announcementFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
announcementFrame.Parent = homeContent
Instance.new("UICorner", announcementFrame).CornerRadius = UDim.new(0, 6)

local announcementTitle = Instance.new("TextLabel")
announcementTitle.Text = "Anúncios"
announcementTitle.Size = UDim2.new(1, 0, 0, 30)
announcementTitle.Font = Enum.Font.GothamBold
announcementTitle.TextColor3 = themeColor
announcementTitle.TextSize = 16
announcementTitle.BackgroundTransparency = 1
announcementTitle.Parent = announcementFrame

local announcementText = Instance.new("TextLabel")
announcementText.Text = "Aviso Externo\nAviso Externo2"
announcementText.Size = UDim2.new(1, -20, 1, -35)
announcementText.Position = UDim2.new(0, 10, 0, 35)
announcementText.Font = Enum.Font.Gotham
announcementText.TextColor3 = Color3.new(1, 1, 1)
announcementText.TextSize = 13
announcementText.TextXAlignment = Enum.TextXAlignment.Left
announcementText.TextYAlignment = Enum.TextYAlignment.Top
announcementText.BackgroundTransparency = 1
announcementText.Parent = announcementFrame

-- Função para arrastar a GUI
local dragging, dragInput, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("Royal Hub GUI carregada com sucesso!")
