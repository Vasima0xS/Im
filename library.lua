local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local Container = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Настройка GUI
    ScreenGui.Name = "XenoMenu"
    ScreenGui.Parent = game.CoreGui

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Active = true
    MainFrame.Draggable = true -- Простое перетаскивание

    TitleLabel.Parent = MainFrame
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18

    Container.Parent = MainFrame
    Container.Position = UDim2.new(0, 5, 0, 45)
    Container.Size = UDim2.new(1, -10, 1, -50)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 2

    UIListLayout.Parent = Container
    UIListLayout.Padding = UDim.new(0, 5)

    local Elements = {}

    -- Функция добавления кнопки
    function Elements:AddButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Container
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(230, 230, 230)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        
        Button.MouseButton1Click:Connect(function()
            callback()
        end)
    end

    return Elements
end

return Library
