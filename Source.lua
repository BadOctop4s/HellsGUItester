local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Icons = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()

local PrimaryColor = Color3.fromHex("#ffffff")
local SecondaryColor = Color3.fromHex("#315dff")

-- Change default icon set
Icons.SetIconsType("geist")
-------------------------------------------------------------SERVICES---------------------------------------------------------
local S = {
    Players = game:GetService("Players"),
    Tween = game:GetService("TweenService"),
    RS = game:GetService("ReplicatedStorage"),
    WS = game:GetService("Workspace"),
    Run = game:GetService("RunService"),
    UI = game:GetService("UserInputService"),
    Sound = game:GetService("SoundService"),
}

--------------------------------------------------- Funções do personagem------------------------------------------------------
local function setSpeed(value)
    local player = S.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
    end
end

local function setJumpPower(value)
    local player = S.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = value
    end
end

-- Função de Teleporte
local function teleportToPlayer(targetPlayer)
    local player = S.Players.LocalPlayer
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
    end
end

local function copySkin(targetPlayer)
    local localPlayer = S.Players.LocalPlayer
    local targetChar = targetPlayer.Character
    local localChar = localPlayer.Character

    if not targetChar or not localChar then return end

    -- Limpa roupas e acessórios atuais (opcional)
    for _, item in pairs(localChar:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("Accessory") then
            item:Destroy()
        end
    end

    -- Copia roupas e acessórios do jogador alvo
    for _, item in pairs(targetChar:GetChildren()) do
        if item:IsA("Shirt") or item:IsA("Pants") or item:IsA("Accessory") then
            local clone = item:Clone()
            clone.Parent = localChar
        end
    end
end
--------------------------------------------------------------INFORMAÇÕES---------------------------------------------------------
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local placeId = game.PlaceId

-- Obter nome do lugar (mapa) via MarketplaceService (pode falhar em alguns jogos)
local placeName = "Carregando..."
local success, err = pcall(function()
    placeName = MarketplaceService:GetProductInfo(placeId).Name
end)
if not success then
    placeName = "Mapa Desconhecido"
end

-- Tempo no servidor (atualizado a cada segundo)
local startTime = os.time()
local timeInServer = 0

-- Atualiza o tempo no servidor
RunService.Heartbeat:Connect(function()
    timeInServer = os.time() - startTime
end)

------------------------------------------------------- Icons --------------------------------------------------------------
local InicioIcon = Icons.Icon("user")
local trolIcon = Icons.Icon("crosshair")
local utilIcon = Icons.Icon("acessibility")
local settingIcon = Icons.Icon("settings-gear")
local UIcon = Icons.Icon("star")
local eye_dashed = Icons.Icon("eye-dashed")
--------------------------------------------------- Translations -----------------------------------------------------------
WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "pt",
    Translations = {
        ["ru"] = {
            ["TittleHub"] = "RoyalHub",
             ["Inicio"] = "You",
            ["WELCOME"] = "Добро пожаловать в RoyalHub!",
            ["LIB_DESC"] = "Библиотека для создания красивых интерфейсов",
            ["SETTINGS"] = "Настройки",
            ["APPEARANCE"] = "Внешний вид",
            ["FEATURES"] = "Функционал",
            ["UTILITIES"] = "Инструменты",
            ["UI_ELEMENTS"] = "UI Элементы",
            ["CONFIGURATION"] = "Конфигурация",
            ["SAVE_CONFIG"] = "Сохранить конфигурацию",
            ["LOAD_CONFIG"] = "Загрузить конфигурацию",
            ["THEME_SELECT"] = "Выберите тему",
        },
        ["en"] = {
            ["TittleHub"] = "RoyalHub demo",
             ["Inicio"] = "You",
            ["WELCOME"] = "Welcome to RoyalHub!",
            ["LIB_DESC"] = "Best universal script for Roblox!",
            ["SETTINGS"] = "Settings",
            ["APPEARANCE"] = "Appearance",
             ["ini_desc"] = "your profile description and etc",
            ["FEATURES"] = "Features",
            ["UTILITIES"] = "Utilities",
            ["UI_ELEMENTS"] = "UI Elements",
            ["CONFIGURATION"] = "Configuration",
            ["SAVE_CONFIG"] = "Save Configuration",
            ["LOAD_CONFIG"] = "Load Configuration",
            ["THEME_SELECT"] = "Select Theme",
        },
        ["es"] = {
            ["TittleHub"] = "RoyalHub demo",
             ["Inicio"] = "Tu perfil",
            ["WELCOME"] = "¡Bienvenido a RoyalHub!",
            ["LIB_DESC"] = "¡Mejor script universal para Roblox!",
            ["SETTINGS"] = "Configuraciones",
            ["APPEARANCE"] = "Apariencia",
            ["FEATURES"] = "Características",
            ["UTILITIES"] = "Utilidades",
            ["UI_ELEMENTS"] = "Elementos de UI",
            ["CONFIGURATION"] = "Configuración",
            ["SAVE_CONFIG"] = "Guardar Configuración",
            ["LOAD_CONFIG"] = "Cargar Configuración",
            ["THEME_SELECT"] = "Seleccionar Tema",
    },
    ["pt"] = {
            ["TittleHub"] = "RoyalHub demo",
             ["Inicio"] = "Seu perfil",
            ["WELCOME"] = "Bem-vindo ao RoyalHub!",
            ["LIB_DESC"] = "Melhor script universal para Roblox!",
            ["SETTINGS"] = "Configuracões",
            ["APPEARANCE"] = "Aparencia",
            ["FEATURES"] = "Novidades",
            ["UTILITIES"] = "Utilidades",
            ["UI_ELEMENTS"] = "UI Elements",
            ["CONFIGURATION"] = "Configurar",
            ["SAVE_CONFIG"] = "Salvar Configuração",
            ["LOAD_CONFIG"] = "Carregar Configuração",
            ["THEME_SELECT"] = "Selecionar Tema",
        }
}})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end
---------------------------------------------- POPUP ------------------------------------------------------------------------
WindUI:Popup({
    Title = gradient("RoyalHub Demo", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    Content = "loc:LIB_DESC",
    Buttons = {
        {
            Title = "Aviso",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})
--------------------------------------------- WINDOW ------------------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "loc:TittleHub",
    Icon = "star",
    Author = "loc:WELCOME",
    Folder = "RoyalHub Demo",
    Size = UDim2.fromOffset(350, 320),
    Theme = "Dark",
     User = {
        Enabled = true,
        Anonymous = false
    }
})

-- TAGS--
Window:Tag({
    Title = "Demo",
    Color = Color3.fromHex("#FFA500")
})
Window:Tag({
    Title = "1.0.9",
    Color = Color3.fromHex("#FFFF00")
})

--------------------------------------------- TOPBAR BUTTONS -------------------------------------------------------------

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Tema alterado",
        Content = "Tema atual:"..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

------------------------------------------------------------- Tabs -----------------------------------------------------------
local home = Window:Tab({
    Title = "loc:Inicio",
    Icon = "user",
    Description = "loc:ini_desc",
})

local Trol = Window:Tab({
    Title = "Trolls",
    Icon = "crosshair",
    Description = "Trolls do RoyalHub",
})
local Roupas = Window:Tab({
    Title = "Roupas",
    Icon = "shirt",
    Description = "Copie roupas e use estilos personalizados!",
})

local Utilities = Window:Tab({
    Title = "loc:UTILITIES",
    Icon = "accessibility",
    Description = "Utilidades do RoyalHub",
})

local setting = Window:Tab({
    Title = "loc:SETTINGS",
    Icon = "settings",
    Description = "Configurações do RoyalHub",
})

------------------------------------------------------ Buttoons -------------------------------------------------------------
 local SpeedSlider = Trol:Slider({
    Title = "Velocidade",
    Step = 1, -- incrementos de 1
    Value = {
        Min = 16,
        Max = 900,
        Default = 16,
    },
    Callback = function(value)
        local player = S.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
})
--------------------------------------------- Pulo ------------------------------------------------------------
local JumpSlider = Trol:Slider({
    Title = "Altura do Pulo",
    Step = 1,
    Value = {
        Min = 10,
        Max = 500,
        Default = 50,
    },
    Callback = function(value)
        local player = S.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
})
---------------------------------------------- Noclip ------------------------------------------------------------
local noclipEnabled = false
local lastCollisionState = {} -- Armazena o estado original das partes

Trol:Toggle({
    Title = "Noclip",
    Description = "Passar por paredes",
    Icon = "eye", -- Ícone corrigido
    DefaultValue = false,
    Callback = function(state)
        noclipEnabled = state
        
        -- Se desativado, restaura a colisão das partes
        if not state then
            local char = S.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and lastCollisionState[part] ~= nil then
                        part.CanCollide = lastCollisionState[part]
                    end
                end
                lastCollisionState = {} -- Limpa o cache
            end
        end
    end
})

S.Run.Stepped:Connect(function()
    local char = S.Players.LocalPlayer.Character
    if noclipEnabled and char then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                -- Salva o estado original da colisão (se não foi salvo antes)
                if lastCollisionState[part] == nil then
                    lastCollisionState[part] = part.CanCollide
                end
                part.CanCollide = false
            end
        end
    end
end)
-------------------------------------------------- Teleport -------------------------------------------------------------
local function GetSafePlayerList()
    local players = {}
    local success, err = pcall(function()
        for _, player in ipairs(S.Players:GetPlayers()) do
            if player ~= S.Players.LocalPlayer and player.Name then
                table.insert(players, player.Name)
            end
        end
    end)
    return players
end

local function CreateTeleportDropdown()
    local playerList = GetSafePlayerList()
    
    return Trol:Dropdown({
        Title = "👥 Teleportar",
        Description = #playerList > 0 and (#playerList.." jogadores") or "Nenhum jogador",
        Options = #playerList > 0 and playerList or {"Nenhum jogador online"},
        Callback = function(selected)
            if selected == "Nenhum jogador online" then return end
            
            local target = S.Players:FindFirstChild(selected)
            if target and target.Character then
                local hrp = target.Character:FindFirstChild("HumanoidRootPart")
                local localChar = S.Players.LocalPlayer.Character
                
                if hrp and localChar and localChar:FindFirstChild("HumanoidRootPart") then
                    localChar.HumanoidRootPart.CFrame = hrp.CFrame
                    WindUI:Notify({
                        Title = "✅ Teleportado!",
                        Content = "Você foi até "..target.Name,
                        Duration = 3
                    })
                end
            end
        end
    })
end

-- Variável global para controle
local CurrentTeleportDropdown = CreateTeleportDropdown()

-- Sistema de atualização robusto
local function UpdateTeleportDropdown()
    local newPlayerList = GetSafePlayerList()
    
    -- Destrói e recria o dropdown (garante compatibilidade)
    CurrentTeleportDropdown:Destroy()
    CurrentTeleportDropdown = CreateTeleportDropdown()
    
    -- Debug opcional
    print("Lista atualizada:", table.concat(newPlayerList, ", "))
end

-- Conexão segura dos eventos
local updateDebounce = false
local function SafeUpdate()
    if updateDebounce then return end
    updateDebounce = true
    
    task.spawn(function()
        pcall(UpdateTeleportDropdown)
        task.wait(1) -- Debounce de 1 segundo
        updateDebounce = false
    end)
end

-- Inicialização segura
task.delay(3, function() -- Espera 3 segundos para o primeiro carregamento
    pcall(SafeUpdate)
end)

-- Conexão dos eventos
S.Players.PlayerAdded:Connect(SafeUpdate)
S.Players.PlayerRemoving:Connect(SafeUpdate)
--------------------------------------------------------Fly-------------------------------------------------------------
local flying = false
local flySpeed = 50
local flyBV

Trol:Toggle({
    Title = "Fly",
    Description = "Ativa ou desativa o voo",
    Default = false,
    Callback = function(state)
        flying = state
        local player = S.Players.LocalPlayer
        local char = player.Character
        if flying and char and char:FindFirstChild("HumanoidRootPart") then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyBV.Velocity = Vector3.new(0, 0, 0)
            flyBV.Parent = char.HumanoidRootPart
        elseif char and char:FindFirstChild("HumanoidRootPart") and flyBV then
            flyBV:Destroy()
        end
    end})

-- Controle do movimento do voo
S.Run.RenderStepped:Connect(function()
    if flying then
        local player = S.Players.LocalPlayer
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local direction = Vector3.new(0,0,0)
            if S.UI:IsKeyDown(Enum.KeyCode.W) then direction = direction + char.HumanoidRootPart.CFrame.LookVector end
            if S.UI:IsKeyDown(Enum.KeyCode.S) then direction = direction - char.HumanoidRootPart.CFrame.LookVector end
            if S.UI:IsKeyDown(Enum.KeyCode.A) then direction = direction - char.HumanoidRootPart.CFrame.RightVector end
            if S.UI:IsKeyDown(Enum.KeyCode.D) then direction = direction + char.HumanoidRootPart.CFrame.RightVector end
            flyBV.Velocity = direction.Unit * flySpeed
        end
    end
end)

-------------------------------------------------- Copiar Skin -------------------------------------------------------------
local clothesDropDown = Roupas:Dropdown({
    Title = "Copiar roupa",
    Description = "Escolha um jogador para copiar a roupa",
    Options = {S.Players.GetPlayers}, -- será preenchido dinamicamente
    Callback = function(selected)
        local target = S.Players:FindFirstChild(selected)
        if target then
            copySkin(target)
        end
    end
})

-- Atualiza lista de jogadores
local function ClothesPlayerList()
    local options = {}
    for _, plr in pairs(S.Players:GetPlayers()) do
        if plr ~= S.Players.LocalPlayer then
            table.insert(options, plr.Name)
        end
    end
    clothesDropDown:UpdateOptions(options)
end

S.Players.PlayerAdded:Connect(ClothesPlayerList)
S.Players.PlayerRemoving:Connect(ClothesPlayerList)
ClothesPlayerList()