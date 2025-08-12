-- MainGUI.lua (Hospede no seu GitHub)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Configurações
local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled

-- Verificar se já existe GUI e remover
if game.CoreGui:FindFirstChild("MainGUI") then
    game.CoreGui:FindFirstChild("MainGUI"):Destroy()
end

-- Criar GUI principal
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MainGUI"
mainGui.Parent = game.CoreGui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 500)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = mainGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Color = Color3.fromRGB(80, 80, 80)
uiStroke.Thickness = 2

-- Barra de abas
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -40, 0, 40)
tabBar.Position = UDim2.new(0, 20, 0, 10)
tabBar.BackgroundTransparency = 1
tabBar.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 10)

-- Função para criar abas
local function createTab(name)
    local tab = Instance.new("TextButton")
    tab.Text = name
    tab.Size = UDim2.new(0, 90, 1, 0)
    tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tab.TextColor3 = Color3.new(1, 1, 1)
    tab.Font = Enum.Font.GothamSemibold
    tab.TextSize = 14
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)
    
    tab.MouseButton1Click:Connect(function()
        -- Lógica para trocar de aba aqui
    end)
    
    return tab
end

-- Criar abas
local mainTab = createTab("Main"); mainTab.Parent = tabBar
local trollTab = createTab("Troll"); trollTab.Parent = tabBar
local teleportTab = createTab("Teleport"); teleportTab.Parent = tabBar
local houseTab = createTab("House"); houseTab.Parent = tabBar

-- Conteúdo da aba Main
local mainContent = Instance.new("Frame")
mainContent.Size = UDim2.new(1, -40, 1, -100)
mainContent.Position = UDim2.new(0, 20, 0, 60)
mainContent.BackgroundTransparency = 1
mainContent.Parent = mainFrame

-- Imagem do usuário
local userImage = Instance.new("ImageLabel")
userImage.Size = UDim2.new(0, 80, 0, 80)
userImage.Position = UDim2.new(0, 20, 0, 20)
userImage.BackgroundTransparency = 1
userImage.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
userImage.Parent = mainContent
Instance.new("UICorner", userImage).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", userImage).Color = Color3.fromRGB(80, 80, 80)

-- Texto de boas-vindas
local welcomeText = Instance.new("TextLabel")
welcomeText.Text = "Bem-vindo, "..LocalPlayer.Name
welcomeText.Size = UDim2.new(0, 300, 0, 40)
welcomeText.Position = UDim2.new(0, 120, 0, 30)
welcomeText.BackgroundTransparency = 1
welcomeText.TextColor3 = Color3.new(1, 1, 1)
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextSize = 18
welcomeText.TextXAlignment = Enum.TextXAlignment.Left
welcomeText.Parent = mainContent

-- Informações do loader
local infoText = Instance.new("TextLabel")
infoText.Text = "Versão do loader: 1.0\nMapa atual: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
infoText.Size = UDim2.new(1, -40, 0, 60)
infoText.Position = UDim2.new(0, 20, 0, 120)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = Color3.new(1, 1, 1)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = mainContent

-- Informação para PC
if not isMobile then
    local pcInfo = Instance.new("TextLabel")
    pcInfo.Text = "INFO: No PC, aperte CTRL DIREITO para esconder o menu"
    pcInfo.Size = UDim2.new(1, -40, 0, 20)
    pcInfo.Position = UDim2.new(0, 20, 1, -30)
    pcInfo.BackgroundTransparency = 1
    pcInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    pcInfo.Font = Enum.Font.Gotham
    pcInfo.TextSize = 12
    pcInfo.Parent = mainContent
end

-- Créditos
local credits = Instance.new("TextLabel")
credits.Text = "Criado por: Eodraxkk, Einzbern"
credits.Size = UDim2.new(1, -40, 0, 20)
credits.Position = UDim2.new(0, 20, 1, -60)
credits.BackgroundTransparency = 1
credits.TextColor3 = Color3.fromRGB(180, 180, 180)
credits.Font = Enum.Font.Gotham
credits.TextSize = 12
credits.Parent = mainContent

-- Botão de Config (adicione a lógica para mostrar configurações)
local configButton = Instance.new("TextButton")
configButton.Text = "Config"
configButton.Size = UDim2.new(0, 80, 0, 30)
configButton.Position = UDim2.new(1, -100, 1, -35)
configButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
configButton.TextColor3 = Color3.new(1, 1, 1)
configButton.Font = Enum.Font.GothamSemibold
configButton.TextSize = 14
Instance.new("UICorner", configButton).CornerRadius = UDim.new(0, 6)
configButton.Parent = mainFrame

-- Botão para fechar
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-- Lógica para esconder/mostrar com CTRL DIREITO
if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
end

print("GUI principal carregada com sucesso!")
