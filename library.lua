local MenuSystem = {}

-- Сервисы
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Переменные
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Цветовая схема (можно менять)
MenuSystem.Colors = {
    Background = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(130, 100, 255),
    Secondary = Color3.fromRGB(45, 45, 60),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    Hover = Color3.fromRGB(35, 35, 50),
    ToggleOn = Color3.fromRGB(130, 100, 255),
    ToggleOff = Color3.fromRGB(60, 60, 75),
    Button = Color3.fromRGB(130, 100, 255),
    Danger = Color3.fromRGB(255, 80, 80),
    Success = Color3.fromRGB(80, 200, 100)
}

-- Создание GUI
function MenuSystem:CreateWindow(title, subtitle)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MenuSystem"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    
    -- Главный контейнер
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = MenuSystem.Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Скругление углов
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Тень
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.7
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(99, 99, 99, 99)
    Shadow.Parent = MainFrame
    
    -- Верхняя панель
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = MenuSystem.Colors.Accent
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar
    
    -- Заголовок
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -20, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "Меню"
    TitleLabel.TextColor3 = MenuSystem.Colors.Text
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = MenuSystem.Colors.Text
    CloseButton.Parent = TopBar
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = MenuSystem.Colors.Text,
            BackgroundTransparency = 1
        }):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Боковая панель (табы)
    local SideBar = Instance.new("Frame")
    SideBar.Name = "SideBar"
    SideBar.Size = UDim2.new(0, 180, 1, -40)
    SideBar.Position = UDim2.new(0, 0, 0, 40)
    SideBar.BackgroundColor3 = MenuSystem.Colors.Secondary
    SideBar.BorderSizePixel = 0
    SideBar.Parent = MainFrame
    
    -- Контейнер для кнопок табов
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 2
    TabList.ScrollBarImageColor3 = MenuSystem.Colors.Accent
    TabList.Parent = SideBar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabList
    
    -- Контейнер для контента таба
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -180, 1, -40)
    ContentFrame.Position = UDim2.new(0, 180, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    local Tabs = {}
    
    -- Создание таба
    function MenuSystem:CreateTab(tabName, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.BackgroundColor3 = MenuSystem.Colors.Hover
        TabButton.BorderSizePixel = 0
        TabButton.Text = (icon or "") .. "  " .. tabName
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.TextSize = 14
        TabButton.TextColor3 = MenuSystem.Colors.TextSecondary
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = TabList
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 5)
        TabCorner.Parent = TabButton
        
        -- Контейнер для контента таба
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = MenuSystem.Colors.Accent
        TabContent.Visible = false
        TabContent.Parent = ContentFrame
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.Parent = TabContent
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Content.Visible = false
                TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = MenuSystem.Colors.Hover,
                    TextColor3 = MenuSystem.Colors.TextSecondary
                }):Play()
            end
            TabContent.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = MenuSystem.Colors.Accent,
                TextColor3 = MenuSystem.Colors.Text
            }):Play()
        end)
        
        local tab = {Button = TabButton, Content = TabContent, Name = tabName}
        table.insert(Tabs, tab)
        
        -- Первый таб активен по умолчанию
        if #Tabs == 1 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = MenuSystem.Colors.Accent
            TabButton.TextColor3 = MenuSystem.Colors.Text
        end
        
        local tabFunctions = {}
        
        -- Заголовок секции
        function tabFunctions:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName
            Section.Size = UDim2.new(1, 0, 0, 30)
            Section.BackgroundColor3 = MenuSystem.Colors.Accent
            Section.BackgroundTransparency = 0.8
            Section.BorderSizePixel = 0
            Section.Parent = TabContent
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 4)
            SectionCorner.Parent = Section
            
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, -10, 1, 0)
            SectionLabel.Position = UDim2.new(0, 10, 0, 0)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = sectionName
            SectionLabel.TextColor3 = MenuSystem.Colors.Text
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextSize = 13
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = Section
            
            return Section
        end
        
        -- Кнопка
        function tabFunctions:CreateButton(name, callback)
            local Button = Instance.new("TextButton")
            Button.Name = name
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.BackgroundColor3 = MenuSystem.Colors.Button
            Button.BorderSizePixel = 0
            Button.Text = name
            Button.Font = Enum.Font.GothamSemibold
            Button.TextSize = 14
            Button.TextColor3 = MenuSystem.Colors.Text
            Button.Parent = TabContent
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = MenuSystem.Colors.Accent:lerp(Color3.fromRGB(255, 255, 255), 0.1)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = MenuSystem.Colors.Button
                }):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    Size = UDim2.new(0.95, 0, 0, 33)
                }):Play()
                wait(0.1)
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    Size = UDim2.new(1, 0, 0, 35)
                }):Play()
            end)
            
            return Button
        end
        
        -- Тоггл
        function tabFunctions:CreateToggle(name, defaultState, callback)
            local Toggle = Instance.new("Frame")
            Toggle.Name = name
            Toggle.Size = UDim2.new(1, 0, 0, 35)
            Toggle.BackgroundColor3 = MenuSystem.Colors.Secondary
            Toggle.BorderSizePixel = 0
            Toggle.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Parent = Toggle
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = name
            ToggleLabel.TextColor3 = MenuSystem.Colors.Text
            ToggleLabel.Font = Enum.Font.GothamSemibold
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = Toggle
            
            local ToggleButton = Instance.new("Frame")
            ToggleButton.Size = UDim2.new(0, 44, 0, 22)
            ToggleButton.Position = UDim2.new(1, -54, 0.5, -11)
            ToggleButton.BackgroundColor3 = defaultState and MenuSystem.Colors.ToggleOn or MenuSystem.Colors.ToggleOff
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Parent = Toggle
            
            local ToggleButtonCorner = Instance.new("UICorner")
            ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonCorner.Parent = ToggleButton
            
            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 18, 0, 18)
            Circle.Position = defaultState and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.BorderSizePixel = 0
            Circle.Parent = ToggleButton
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = Circle
            
            local toggled = defaultState or false
            
            local function update()
                TweenService:Create(Circle, TweenInfo.new(0.3), {
                    Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
                }):Play()
                TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = toggled and MenuSystem.Colors.ToggleOn or MenuSystem.Colors.ToggleOff
                }):Play()
            end
            
            Toggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggled = not toggled
                    update()
                    if callback then
                        callback(toggled)
                    end
                end
            end)
            
            return {
                SetState = function(state)
                    toggled = state
                    update()
                end,
                GetState = function()
                    return toggled
                end
            }
        end
        
        -- Слайдер
        function tabFunctions:CreateSlider(name, min, max, default, callback)
            local Slider = Instance.new("Frame")
            Slider.Name = name
            Slider.Size = UDim2.new(1, 0, 0, 60)
            Slider.BackgroundColor3 = MenuSystem.Colors.Secondary
            Slider.BorderSizePixel = 0
            Slider.Parent = TabContent
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 5)
            SliderCorner.Parent = Slider
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -20, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = name .. ": " .. default
            SliderLabel.TextColor3 = MenuSystem.Colors.Text
            SliderLabel.Font = Enum.Font.GothamSemibold
            SliderLabel.TextSize = 13
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = Slider
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -20, 0, 4)
            SliderBar.Position = UDim2.new(0, 10, 0, 35)
            SliderBar.BackgroundColor3 = MenuSystem.Colors.ToggleOff
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = Slider
            
            local SliderBarCorner = Instance.new("UICorner")
            SliderBarCorner.CornerRadius = UDim.new(1, 0)
            SliderBarCorner.Parent = SliderBar
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = MenuSystem.Colors.Accent
            Fill.BorderSizePixel = 0
            Fill.Parent = SliderBar
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill
            
            local Thumb = Instance.new("TextButton")
            Thumb.Size = UDim2.new(0, 14, 0, 14)
            Thumb.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
            Thumb.BackgroundColor3 = MenuSystem.Colors.Accent
            Thumb.BorderSizePixel = 0
            Thumb.Text = ""
            Thumb.Parent = SliderBar
            
            local ThumbCorner = Instance.new("UICorner")
            ThumbCorner.CornerRadius = UDim.new(1, 0)
            ThumbCorner.Parent = Thumb
            
            dragging = false
            
            Thumb.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if input == Mouse and dragging then
                    local percent = math.clamp((input.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + ((max - min) * percent))
                    Thumb.Position = UDim2.new(percent, -7, 0.5, -7)
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderLabel.Text = name .. ": " .. value
                    if callback then
                        callback(value)
                    end
                end
            end)
            
            return Slider
        end
        
        -- Выпадающий список
        function tabFunctions:CreateDropdown(name, options, callback)
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = name
            Dropdown.Size = UDim2.new(1, 0, 0, 35)
            Dropdown.BackgroundColor3 = MenuSystem.Colors.Secondary
            Dropdown.BorderSizePixel = 0
            Dropdown.Parent = TabContent
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Parent = Dropdown
            
            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Size = UDim2.new(1, -10, 1, 0)
            DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = name .. ": " .. (options[1] or "Выберите")
            DropdownLabel.TextColor3 = MenuSystem.Colors.Text
            DropdownLabel.Font = Enum.Font.GothamSemibold
            DropdownLabel.TextSize = 14
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = Dropdown
            
            local isOpen = false
            
            Dropdown.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isOpen = not isOpen
                    Dropdown.Size = isOpen and UDim2.new(1, 0, 0, 35 * (#options + 1)) or UDim2.new(1, 0, 0, 35)
                end
            end)
            
            for i, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 35)
                OptionButton.Position = UDim2.new(0, 0, 0, 35 * i)
                OptionButton.BackgroundColor3 = MenuSystem.Colors.Hover
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.TextSize = 13
                OptionButton.TextColor3 = MenuSystem.Colors.Text
                OptionButton.Visible = isOpen
                OptionButton.Parent = Dropdown
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropdownLabel.Text = name .. ": " .. option
                    Dropdown.Size = UDim2.new(1, 0, 0, 35)
                    isOpen = false
                    if callback then
                        callback(option)
                    end
                end)
            end
            
            return Dropdown
        end
        
        return tabFunctions
    end
    
    -- Делаем окно перетаскиваемым
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Анимация появления
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 600, 0, 400)
    }):Play()
    
    return MenuSystem
end

-- Уведомления
function MenuSystem:CreateNotification(title, message, duration)
    duration = duration or 3
    
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(0, 250, 0, 60)
    Notification.Position = UDim2.new(1, 10, 1, -10)
    Notification.BackgroundColor3 = MenuSystem.Colors.Secondary
    Notification.BorderSizePixel = 0
    Notification.Parent = CoreGui
    
    local NotCorner = Instance.new("UICorner")
    NotCorner.CornerRadius = UDim.new(0, 6)
    NotCorner.Parent = Notification
    
    local NotTitle = Instance.new("TextLabel")
    NotTitle.Size = UDim2.new(1, -10, 0, 20)
    NotTitle.Position = UDim2.new(0, 10, 0, 5)
    NotTitle.BackgroundTransparency = 1
    NotTitle.Text = title
    NotTitle.Font = Enum.Font.GothamBold
    NotTitle.TextSize = 14
    NotTitle.TextColor3 = MenuSystem.Colors.Text
    NotTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotTitle.Parent = Notification
    
    local NotMessage = Instance.new("TextLabel")
    NotMessage.Size = UDim2.new(1, -10, 0, 30)
    NotMessage.Position = UDim2.new(0, 10, 0, 25)
    NotMessage.BackgroundTransparency = 1
    NotMessage.Text = message
    NotMessage.Font = Enum.Font.Gotham
    NotMessage.TextSize = 12
    NotMessage.TextColor3 = MenuSystem.Colors.TextSecondary
    NotMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotMessage.Parent = Notification
    
    -- Анимация
    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Position = UDim2.new(1, -260, 1, -10)
    }):Play()
    
    wait(duration)
    
    TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Position = UDim2.new(1, 10, 1, -10)
    }):Play()
    
    wait(0.5)
    Notification:Destroy()
end

return MenuSystem
