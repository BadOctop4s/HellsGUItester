--// CONFIGURAÇÕES
local ScriptVersion = "1.0"
local Criadores = {"SeuNome", "OutroCriador"}
local DoacaoLink = "https://seulink.com" -- Coloque seu link de doação

--// EFEITO BLUR NO CARREGAMENTO
local Lighting = game:GetService("Lighting")
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 24

task.wait(2) -- tempo de "loading"

Blur:Destroy()

--// SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

-- Container principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Parent = ScreenGui
MainFrame.Visible = true

-- Gradiente animado
local UIGradient = Instance.new("UIGradient", MainFrame)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 127)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}
UIGradient.Rotation = 0

task.spawn(function()
    while task.wait(0.05) do
        UIGradient.Rotation = UIGradient.Rotation + 1
    end
end)

-- Título
local Title = Instance.new("TextLabel")
Title.Text = "Painel - Main"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- Informações
local Info = Instance.new("TextLabel")
Info.Text = "Usuário: " .. game.Players.LocalPlayer.Name ..
            "\nVersão: " .. ScriptVersion ..
            "\nCriadores: " .. table.concat(Criadores, ", ")
Info.Font = Enum.Font.Gotham
Info.TextSize = 16
Info.TextColor3 = Color3.fromRGB(200,200,200)
Info.Size = UDim2.new(1, -20, 0, 80)
Info.Position = UDim2.new(0, 10, 0, 50)
Info.BackgroundTransparency = 1
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = MainFrame

-- Botão de Doação
local DonateButton = Instance.new("TextButton")
DonateButton.Text = "💖 Apoiar Projeto"
DonateButton.Font = Enum.Font.GothamBold
DonateButton.TextSize = 18
DonateButton.TextColor3 = Color3.fromRGB(255,255,255)
DonateButton.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
DonateButton.Size = UDim2.new(0, 180, 0, 40)
DonateButton.Position = UDim2.new(0.5, -90, 1, -50)
DonateButton.Parent = MainFrame

-- Efeito hover no botão
DonateButton.MouseEnter:Connect(function()
    DonateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
end)
DonateButton.MouseLeave:Connect(function()
    DonateButton.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
end)

-- Ao clicar, abrir link
DonateButton.MouseButton1Click:Connect(function()
    setclipboard(DoacaoLink)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Doação",
        Text = "Link de doação copiado!"
    })
end)

--// Atalho para abrir/fechar (CTRL direito)
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gp)
    if not gp and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.RightControl then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)