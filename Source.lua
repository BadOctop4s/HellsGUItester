-- Royal Hub GUI (Brookhaven Version) com melhorias solicitadas

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Tema padrão (pode ser alterado na aba Configurações)
local themeColor = Color3.fromRGB(140, 0, 255) -- Roxo drip

-- Detectar plataforma (mobile ou PC)
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- Remover GUI existente
if game.CoreGui:FindFirstChild("RoyalHub") then
    game.CoreGui:FindFirstChild("RoyalHub"):Destroy()
end

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoyalHub"
screenGui.Parent = game.CoreGui

-- Frame principal, tamanho ajustado para mobile
local mainFrame = Instance.new("Frame")
mainFrame.Size = isMobile and UDim2.new(0, 300, 0, 330) or UDim2.new(0, 500, 0, 550)
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

-- Frame conteúdo principal
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -160, 1, -50)
contentFrame.Position = UDim2.new(0, 155, 0, 45)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Função para limpar conteúdo
local function clearContent()
    for _, child in pairs(contentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

-- Criar abas
local tabs = {}

-- Função para trocar aba
local function setTab(tabName)
    clearContent()
    if tabs[tabName] then
        tabs[tabName]()
    end
end

-- Criar botões do sidebar com troca de abas
local tabButtons = {}

local function createSidebarButton(text, tabName, yPos)
    local btn = Instance.new("TextButton")
    btn.Text = "   "..text
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Font = Enum.Font.Gotham
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        -- Marca o botão ativo
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        end
        btn.BackgroundColor3 = themeColor
        setTab(tabName)
    end)
    table.insert(tabButtons, btn)
end

-- Criar os botões principais, organizados conforme solicitado

local posY = 10

-- Aba: Início (Informações)
createSidebarButton("Início", "home", posY)
posY = posY + 35

-- Aba: Troll (Teleport e LoopGoto)
createSidebarButton("Teleport", "troll_teleport", posY)
posY = posY + 35
createSidebarButton("Loop Goto", "troll_loopgoto", posY)
posY = posY + 35

-- Aba: Personagem (Roupas)
createSidebarButton("Roupas", "character_clothes", posY)
posY = posY + 35

-- Aba: Casa (Unban)
createSidebarButton("Casa (Unban)", "house_unban", posY)
posY = posY + 35

-- Aba: Carros (Spawn carros)
createSidebarButton("Carros", "car_spawn", posY)
posY = posY + 35

-- Aba: Configurações (Noclip, Autoclick, cor GUI)
createSidebarButton("Configurações", "settings", posY)
posY = posY + 35

-- Créditos fixos canto inferior esquerdo
local creditLabel = Instance.new("TextLabel")
creditLabel.Text = "Criado por Eodraxkk, Einzbern"
creditLabel.Size = UDim2.new(0, 200, 0, 20)
creditLabel.Position = UDim2.new(0, 5, 1, -25)
creditLabel.BackgroundTransparency = 1
creditLabel.Font = Enum.Font.GothamItalic
creditLabel.TextSize = 12
creditLabel.TextColor3 = Color3.new(1,1,1)
creditLabel.TextXAlignment = Enum.TextXAlignment.Left
creditLabel.Parent = mainFrame

-- Funções básicas para as funções pedidas:

-- Noclip (exemplo simples: atravessar paredes)
local noclipEnabled = false
local function noclipLoop()
    if noclipEnabled then
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Conecta noclip loop
RunService.Stepped:Connect(function()
    noclipLoop()
end)

-- Autoclick - exemplo simples com delay customizável
local autoclickEnabled = false
local autoclickDelay = 0.05

local function autoclick()
    while autoclickEnabled do
        wait(autoclickDelay)
        -- Aqui você deve colocar o código de click, exemplo:
        -- LocalPlayer:FindFirstChildOfClass('Tool') e ativar o click
        -- Exemplo simples:
        local mouseTarget = Mouse.Target
        if mouseTarget then
            -- Simula clique com evento, ou chama função de click
            -- Precisa adaptar ao game exato
            mouseTarget:FindFirstChildWhichIsA("ClickDetector")?.Click()
        end
    end
end

-- Unban houses (exemplo básico)
local function unbanHouses()
    -- Exemplo: desbloquear todas as casas banidas
    -- A lógica depende do game, deve-se chamar algum evento ou mudar valores
    print("Função Unban Houses acionada (implemente conforme game)")
end

-- Teleportar para posição (exemplo)
local function teleportToPosition(pos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Loop Goto (exemplo básico)
local loopGotoEnabled = false
local loopGotoPosition = nil

spawn(function()
    while true do
        wait(0.5)
        if loopGotoEnabled and loopGotoPosition then
            teleportToPosition(loopGotoPosition)
        end
    end
end)

-- Spawn carros (exemplo básico)
local function spawnCar(modelName)
    -- Adaptar para o sistema do Brookhaven
    print("Tentando spawnar carro: "..modelName)
    -- Exemplo: procurar carro em workspace.Cars e clonar para perto do player
    local carsFolder = workspace:FindFirstChild("Cars")
    if carsFolder then
        local carModel = carsFolder:FindFirstChild(modelName)
        if carModel then
            local carClone = carModel:Clone()
            carClone.Parent = workspace
            carClone:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
        else
            warn("Carro não encontrado: "..modelName)
        end
    else
        warn("Pasta de carros não encontrada")
    end
end

-- Copiar roupa de outro jogador
local function copyClothesFromPlayer(targetPlayer)
    if not targetPlayer.Character then return end
    local targetChar = targetPlayer.Character
    local localChar = LocalPlayer.Character
    if not localChar then return end

    -- Remover roupas atuais
    for _, item in pairs(localChar:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("CharacterMesh") or item:IsA("Shirt") or item:IsA("Pants") then
            item:Destroy()
        end
    end

    -- Clonar roupas do alvo
    for _, item in pairs(targetChar:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("CharacterMesh") or item:IsA("Shirt") or item:IsA("Pants") then
            local clone = item:Clone()
            clone.Parent = localChar
        end
    end
end

-- Criar conteúdo das abas:

-- 1) Aba Home
tabs["home"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Bem-vindo ao Royal Hub | Brookhaven RP"
    label.Size = UDim2.new(1,0,0,30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    local info = Instance.new("TextLabel")
    info.Text = "Plataforma: "..(isMobile and "Mobile" or "PC").."\nCriadores: Eodraxkk, Einzbern\nExecutor: Royal Hub"
    info.Size = UDim2.new(1, 0, 0, 60)
    info.Position = UDim2.new(0, 0, 0, 40)
    info.Font = Enum.Font.Gotham
    info.TextSize = 14
    info.TextColor3 = Color3.new(1,1,1)
    info.BackgroundTransparency = 1
    info.TextWrapped = true
    info.Parent = contentFrame
end

-- 2) Aba Troll: Teleport
tabs["troll_teleport"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Teleportar para jogador:"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    -- Dropdown para selecionar jogador
    local dropdown = Instance.new("TextBox")
    dropdown.PlaceholderText = "Nome do jogador"
    dropdown.Size = UDim2.new(1, -20, 0, 30)
    dropdown.Position = UDim2.new(0, 10, 0, 40)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.TextColor3 = Color3.new(1,1,1)
    dropdown.BackgroundColor3 = Color3.fromRGB(40,40,45)
    dropdown.Parent = contentFrame
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0,4)

    local tpButton = Instance.new("TextButton")
    tpButton.Text = "Teleportar"
    tpButton.Size = UDim2.new(1, -20, 0, 30)
    tpButton.Position = UDim2.new(0, 10, 0, 80)
    tpButton.Font = Enum.Font.GothamBold
    tpButton.TextColor3 = Color3.new(1,1,1)
    tpButton.BackgroundColor3 = themeColor
    tpButton.Parent = contentFrame
    Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0,4)

    tpButton.MouseButton1Click:Connect(function()
        local targetName = dropdown.Text
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            teleportToPosition(targetPlayer.Character.HumanoidRootPart.Position)
        else
            warn("Jogador não encontrado ou sem personagem")
        end
    end)
end

-- 3) Aba Troll: Loop Goto
tabs["troll_loopgoto"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Loop Teleport para jogador:"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    local dropdown = Instance.new("TextBox")
    dropdown.PlaceholderText = "Nome do jogador"
    dropdown.Size = UDim2.new(1, -20, 0, 30)
    dropdown.Position = UDim2.new(0, 10, 0, 40)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.TextColor3 = Color3.new(1,1,1)
    dropdown.BackgroundColor3 = Color3.fromRGB(40,40,45)
    dropdown.Parent = contentFrame
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0,4)

    local toggle = Instance.new("TextButton")
    toggle.Text = "Ativar Loop"
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, 80)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.BackgroundColor3 = themeColor
    toggle.Parent = contentFrame
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,4)

    toggle.MouseButton1Click:Connect(function()
        if loopGotoEnabled then
            loopGotoEnabled = false
            toggle.Text = "Ativar Loop"
        else
            local targetName = dropdown.Text
            local targetPlayer = Players:FindFirstChild(targetName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                loopGotoPosition = targetPlayer.Character.HumanoidRootPart.Position
                loopGotoEnabled = true
                toggle.Text = "Desativar Loop"
            else
                warn("Jogador não encontrado")
            end
        end
    end)
end

-- 4) Aba Roupas
tabs["character_clothes"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Copiar roupa de outro jogador:"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    local dropdown = Instance.new("TextBox")
    dropdown.PlaceholderText = "Nome do jogador"
    dropdown.Size = UDim2.new(1, -20, 0, 30)
    dropdown.Position = UDim2.new(0, 10, 0, 40)
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 14
    dropdown.TextColor3 = Color3.new(1,1,1)
    dropdown.BackgroundColor3 = Color3.fromRGB(40,40,45)
    dropdown.Parent = contentFrame
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0,4)

    local copyBtn = Instance.new("TextButton")
    copyBtn.Text = "Copiar Roupa"
    copyBtn.Size = UDim2.new(1, -20, 0, 30)
    copyBtn.Position = UDim2.new(0, 10, 0, 80)
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextColor3 = Color3.new(1,1,1)
    copyBtn.BackgroundColor3 = themeColor
    copyBtn.Parent = contentFrame
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0,4)

    copyBtn.MouseButton1Click:Connect(function()
        local targetName = dropdown.Text
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer then
            copyClothesFromPlayer(targetPlayer)
        else
            warn("Jogador não encontrado")
        end
    end)
end

-- 5) Aba Casa (Unban)
tabs["house_unban"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Desbanir casas:"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    local unbanBtn = Instance.new("TextButton")
    unbanBtn.Text = "Unban Houses"
    unbanBtn.Size = UDim2.new(1, -20, 0, 40)
    unbanBtn.Position = UDim2.new(0, 10, 0, 50)
    unbanBtn.Font = Enum.Font.GothamBold
    unbanBtn.TextColor3 = Color3.new(1,1,1)
    unbanBtn.BackgroundColor3 = themeColor
    unbanBtn.Parent = contentFrame
    Instance.new("UICorner", unbanBtn).CornerRadius = UDim.new(0,4)

    unbanBtn.MouseButton1Click:Connect(function()
        unbanHouses()
    end)
end

-- 6) Aba Carros (Spawn carros)
tabs["car_spawn"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Spawn de carros:"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    local carInput = Instance.new("TextBox")
    carInput.PlaceholderText = "Nome do carro"
    carInput.Size = UDim2.new(1, -20, 0, 30)
    carInput.Position = UDim2.new(0, 10, 0, 40)
    carInput.Font = Enum.Font.Gotham
    carInput.TextSize = 14
    carInput.TextColor3 = Color3.new(1,1,1)
    carInput.BackgroundColor3 = Color3.fromRGB(40,40,45)
    carInput.Parent = contentFrame
    Instance.new("UICorner", carInput).CornerRadius = UDim.new(0,4)

    local spawnBtn = Instance.new("TextButton")
    spawnBtn.Text = "Spawn Carro"
    spawnBtn.Size = UDim2.new(1, -20, 0, 30)
    spawnBtn.Position = UDim2.new(0, 10, 0, 80)
    spawnBtn.Font = Enum.Font.GothamBold
    spawnBtn.TextColor3 = Color3.new(1,1,1)
    spawnBtn.BackgroundColor3 = themeColor
    spawnBtn.Parent = contentFrame
    Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0,4)

    spawnBtn.MouseButton1Click:Connect(function()
        local carName = carInput.Text
        spawnCar(carName)
    end)
end

-- 7) Aba Configurações
tabs["settings"] = function()
    local label = Instance.new("TextLabel")
    label.Text = "Configurações"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = themeColor
    label.BackgroundTransparency = 1
    label.Parent = contentFrame

    -- Noclip toggle
    local noclipToggle = Instance.new("TextButton")
    noclipToggle.Text = "Noclip: Desativado"
    noclipToggle.Size = UDim2.new(1, -20, 0, 40)
    noclipToggle.Position = UDim2.new(0, 10, 0, 40)
    noclipToggle.Font = Enum.Font.GothamBold
    noclipToggle.TextColor3 = Color3.new(1,1,1)
    noclipToggle.BackgroundColor3 = themeColor
    noclipToggle.Parent = contentFrame
    Instance.new("UICorner", noclipToggle).CornerRadius = UDim.new(0,4)
    noclipToggle.MouseButton1Click:Connect(function()
        noclipEnabled = not noclipEnabled
        noclipToggle.Text = "Noclip: "..(noclipEnabled and "Ativado" or "Desativado")
    end)

    -- Autoclick toggle e delay
    local autoclickToggle = Instance.new("TextButton")
    autoclickToggle.Text = "Autoclick: Desativado"
    autoclickToggle.Size = UDim2.new(1, -20, 0, 40)
    autoclickToggle.Position = UDim2.new(0, 10, 0, 90)
    autoclickToggle.Font = Enum.Font.GothamBold
    autoclickToggle.TextColor3 = Color3.new(1,1,1)
    autoclickToggle.BackgroundColor3 = themeColor
    autoclickToggle.Parent = contentFrame
    Instance.new("UICorner", autoclickToggle).CornerRadius = UDim.new(0,4)

    autoclickToggle.MouseButton1Click:Connect(function()
        autoclickEnabled = not autoclickEnabled
        autoclickToggle.Text = "Autoclick: "..(autoclickEnabled and "Ativado" or "Desativado")
        if autoclickEnabled then
            spawn(autoclick)
        end
    end)

    -- Cor da GUI - slider RGB simples
    local function createColorPickerLabel(text, posY)
        local lbl = Instance.new("TextLabel")
        lbl.Text = text
        lbl.Size = UDim2.new(0, 50, 0, 20)
        lbl.Position = UDim2.new(0, 10, 0, posY)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.BackgroundTransparency = 1
        lbl.Parent = contentFrame
        return lbl
    end

    local function createColorSlider(posY, colorComponent)
        local slider = Instance.new("Frame")
        slider.Size = UDim2.new(1, -80, 0, 20)
        slider.Position = UDim2.new(0, 60, 0, posY)
        slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        slider.Parent = contentFrame
        Instance.new("UICorner", slider).CornerRadius = UDim.new(0,4)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 15, 1, 0)
        knob.Position = UDim2.new(themeColor[colorComponent], 0, 0, 0)
        knob.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        knob.Parent = slider
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 7)

        local dragging = false

        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        knob.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativeX = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
                local scale = relativeX / slider.AbsoluteSize.X
                knob.Position = UDim2.new(scale, 0, 0, 0)

                local r,g,b = themeColor.R, themeColor.G, themeColor.B
                if colorComponent == "R" then r = scale
                elseif colorComponent == "G" then g = scale
                elseif colorComponent == "B" then b = scale
                end

                themeColor = Color3.new(r,g,b)
                uiStroke.Color = themeColor
                titleText.TextColor3 = themeColor

                -- Atualizar cor dos botões da sidebar ativos
                for _, b in pairs(tabButtons) do
                    if b.BackgroundColor3 == themeColor then
                        b.BackgroundColor3 = themeColor
                    end
                end
            end
        end)

        return slider
    end

    createColorPickerLabel("R", 140)
    createColorPickerLabel("G", 180)
    createColorPickerLabel("B", 220)
    createColorSlider(140, "R")
    createColorSlider(180, "G")
    createColorSlider(220, "B")
end

-- Chamar aba inicial (Home)
tabButtons[1].BackgroundColor3 = themeColor
setTab("home")

-- Correção do drag para mover GUI (falta UserInputService no seu original)
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
