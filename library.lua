local MenuSystem = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Color scheme
MenuSystem.Colors = {
    Background = Color3.fromRGB(20, 20, 30),
    Accent = Color3.fromRGB(100, 80, 255),
    Secondary = Color3.fromRGB(35, 35, 50),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(160, 160, 180),
    Hover = Color3.fromRGB(45, 45, 60),
    ToggleOn = Color3.fromRGB(100, 80, 255),
    ToggleOff = Color3.fromRGB(50, 50, 65),
    Button = Color3.fromRGB(100, 80, 255),
    Danger = Color3.fromRGB(255, 70, 70),
    Success = Color3.fromRGB(70, 200, 100)
}

-- Create notification system
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationContainer"
NotificationFrame.Size = UDim2.new(0, 250, 1, 0)
NotificationFrame.Position = UDim2.new(1, -260, 0, 0)
NotificationFrame.BackgroundTransparency = 1
NotificationFrame.Parent = CoreGui

local NotificationLayout = Instance.new("UIListLayout")
NotificationLayout.Padding = UDim.new(0, 5)
NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationLayout.Parent = NotificationFrame

function MenuSystem:CreateNotification(title, message, duration)
    duration = duration or 3
    
    local Notification = Instance.new("Frame")
    Notification.Size = UDim2.new(1, 0, 0, 55)
    Notification.BackgroundColor3 = MenuSystem.Colors.Secondary
    Notification.BorderSizePixel = 0
    Notification.ClipsDescendants = true
    Notification.Parent = NotificationFrame
    
    local NotCorner = Instance.new("UICorner")
    NotCorner.CornerRadius = UDim.new(0, 6)
    NotCorner.Parent = Notification
    
    -- Accent bar
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = MenuSystem.Colors.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Notification
    
    local NotTitle = Instance.new("TextLabel")
    NotTitle.Size = UDim2.new(1, -20, 0, 20)
    NotTitle.Position = UDim2.new(0, 15, 0, 5)
    NotTitle.BackgroundTransparency = 1
    NotTitle.Text = title
    NotTitle.Font = Enum.Font.GothamBold
    NotTitle.TextSize = 13
    NotTitle.TextColor3 = MenuSystem.Colors.Text
    NotTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotTitle.Parent = Notification
    
    local NotMessage = Instance.new("TextLabel")
    NotMessage.Size = UDim2.new(1, -20, 0, 25)
    NotMessage.Position = UDim2.new(0, 15, 0, 25)
    NotMessage.BackgroundTransparency = 1
    NotMessage.Text = message
    NotMessage.Font = Enum.Font.Gotham
    NotMessage.TextSize = 11
    NotMessage.TextColor3 = MenuSystem.Colors.TextSecondary
    NotMessage.TextXAlignment = Enum.TextXAlignment.Left
    NotMessage.TextWrapped = true
    NotMessage.Parent = Notification
    
    -- Animation
    Notification.Size = UDim2.new(0, 0, 0, 55)
    TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(1, 0, 0, 55)
    }):Play()
    
    delay(duration, function()
        TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 0, 0, 55)
        }):Play()
        wait(0.3)
        Notification:Destroy()
    end)
end

-- Create window function
function MenuSystem:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MenuSystem_" .. title
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    
    -- Main container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
    MainFrame.BackgroundColor3 = MenuSystem.Colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Top bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = MenuSystem.Colors.Accent
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = MenuSystem.Colors.Text
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "Close"
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    CloseButton.BackgroundTransparency = 0
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.TextColor3 = MenuSystem.Colors.Text
    CloseButton.ZIndex = 10
    CloseButton.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        }):Play()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        wait(0.25)
        ScreenGui:Destroy()
    end)
    
    -- Side bar
    local SideBar = Instance.new("Frame")
    SideBar.Name = "SideBar"
    SideBar.Size = UDim2.new(0, 150, 1, -35)
    SideBar.Position = UDim2.new(0, 0, 0, 35)
    SideBar.BackgroundColor3 = MenuSystem.Colors.Secondary
    SideBar.BorderSizePixel = 0
    SideBar.Parent = MainFrame
    
    -- Tab buttons container
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.BackgroundTransparency = 1
    TabList.ScrollBarThickness = 2
    TabList.ScrollBarImageColor3 = MenuSystem.Colors.Accent
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.Parent = SideBar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 4)
    TabListLayout.Parent = TabList
    
    -- Content container
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -150, 1, -35)
    ContentFrame.Position = UDim2.new(0, 150, 0, 35)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Separator line
    local Separator = Instance.new("Frame")
    Separator.Size = UDim2.new(0, 2, 1, 0)
    Separator.Position = UDim2.new(0, 149, 0, 35)
    Separator.BackgroundColor3 = MenuSystem.Colors.Accent
    Separator.BorderSizePixel = 0
    Separator.Parent = MainFrame
    
    local Tabs = {}
    local ActiveTab = nil
    
    -- Create tab function
    function MenuSystem:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.BackgroundColor3 = MenuSystem.Colors.Hover
        TabButton.BorderSizePixel = 0
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.TextSize = 13
        TabButton.TextColor3 = MenuSystem.Colors.TextSecondary
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.TextTruncate = Enum.TextTruncate.AtEnd
        TabButton.Parent = TabList
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 5)
        TabCorner.Parent = TabButton
        
        -- Tab content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = MenuSystem.Colors.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentFrame
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent
        
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.Content.Visible = false
                TweenService:Create(ActiveTab.Button, TweenInfo.new(0.15), {
                    BackgroundColor3 = MenuSystem.Colors.Hover,
                    TextColor3 = MenuSystem.Colors.TextSecondary
                }):Play()
            end
            TabContent.Visible = true
            ActiveTab = {Button = TabButton, Content = TabContent}
            TweenService:Create(TabButton, TweenInfo.new(0.15), {
                BackgroundColor3 = MenuSystem.Colors.Accent,
                TextColor3 = MenuSystem.Colors.Text
            }):Play()
        end)
        
        -- Auto select first tab
        if #Tabs == 0 then
            TabContent.Visible = true
            ActiveTab = {Button = TabButton, Content = TabContent}
            TabButton.BackgroundColor3 = MenuSystem.Colors.Accent
            TabButton.TextColor3 = MenuSystem.Colors.Text
        end
        
        table.insert(Tabs, {Button = TabButton, Content = TabContent})
        
        local tabFunctions = {}
        
        -- Create section
        function tabFunctions:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName
            Section.Size = UDim2.new(1, 0, 0, 28)
            Section.BackgroundColor3 = MenuSystem.Colors.Accent
            Section.BackgroundTransparency = 0.85
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
            SectionLabel.TextSize = 12
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = Section
            
            return Section
        end
        
        -- Create button
        function tabFunctions:CreateButton(name, callback)
            local Button = Instance.new("TextButton")
            Button.Name = name
            Button.Size = UDim2.new(1, 0, 0, 32)
            Button.BackgroundColor3 = MenuSystem.Colors.Button
            Button.BorderSizePixel = 0
            Button.Text = name
            Button.Font = Enum.Font.GothamSemibold
            Button.TextSize = 13
            Button.TextColor3 = MenuSystem.Colors.Text
            Button.AutoButtonColor = false
            Button.Parent = TabContent
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = MenuSystem.Colors.Accent:lerp(Color3.fromRGB(255, 255, 255), 0.15)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.1), {
                    BackgroundColor3 = MenuSystem.Colors.Button
                }):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                spawn(function()
                    if callback then
                        callback()
                    end
                end)
            end)
            
            return Button
        end
        
        -- Create toggle
        function tabFunctions:CreateToggle(name, defaultState, callback)
            local toggled = defaultState or false
            
            local Toggle = Instance.new("Frame")
            Toggle.Name = name
            Toggle.Size = UDim2.new(1, 0, 0, 32)
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
            ToggleLabel.TextSize = 13
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = Toggle
            
            local ToggleButton = Instance.new("Frame")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = toggled and MenuSystem.Colors.ToggleOn or MenuSystem.Colors.ToggleOff
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Parent = Toggle
            
            local ToggleButtonCorner = Instance.new("UICorner")
            ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonCorner.Parent = ToggleButton
            
            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 16, 0, 16)
            Circle.Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.BorderSizePixel = 0
            Circle.Parent = ToggleButton
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = Circle
            
            local function update()
                TweenService:Create(Circle, TweenInfo.new(0.2), {
                    Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                }):Play()
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggled and MenuSystem.Colors.ToggleOn or MenuSystem.Colors.ToggleOff
                }):Play()
            end
            
            Toggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggled = not toggled
                    update()
                    spawn(function()
                        if callback then
                            callback(toggled)
                        end
                    end)
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
        
        -- Create slider
        function tabFunctions:CreateSlider(name, min, max, default, callback)
            local currentValue = default or min
            
            local Slider = Instance.new("Frame")
            Slider.Name = name
            Slider.Size = UDim2.new(1, 0, 0, 55)
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
            SliderLabel.Text = name .. ": " .. currentValue
            SliderLabel.TextColor3 = MenuSystem.Colors.Text
            SliderLabel.Font = Enum.Font.GothamSemibold
            SliderLabel.TextSize = 12
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = Slider
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -20, 0, 4)
            SliderBar.Position = UDim2.new(0, 10, 0, 32)
            SliderBar.BackgroundColor3 = MenuSystem.Colors.ToggleOff
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = Slider
            
            local SliderBarCorner = Instance.new("UICorner")
            SliderBarCorner.CornerRadius = UDim.new(1, 0)
            SliderBarCorner.Parent = SliderBar
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = MenuSystem.Colors.Accent
            Fill.BorderSizePixel = 0
            Fill.Parent = SliderBar
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill
            
            local dragged = false
            
            Slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragged = true
                    local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    currentValue = math.floor(min + ((max - min) * percent))
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderLabel.Text = name .. ": " .. currentValue
                    spawn(function()
                        if callback then
                            callback(currentValue)
                        end
                    end)
                end
            end)
            
            Slider.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragged = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragged and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    currentValue = math.floor(min + ((max - min) * percent))
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderLabel.Text = name .. ": " .. currentValue
                    spawn(function()
                        if callback then
                            callback(currentValue)
                        end
                    end)
                end
            end)
            
            return Slider
        end
        
        -- Create dropdown
        function tabFunctions:CreateDropdown(name, options, callback)
            local isOpen = false
            local selectedOption = options[1] or "Select"
            local optionButtons = {}
            
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = name
            Dropdown.Size = UDim2.new(1, 0, 0, 32)
            Dropdown.BackgroundColor3 = MenuSystem.Colors.Secondary
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Parent = TabContent
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Parent = Dropdown
            
            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Size = UDim2.new(1, -30, 1, 0)
            DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = name .. ": " .. selectedOption
            DropdownLabel.TextColor3 = MenuSystem.Colors.Text
            DropdownLabel.Font = Enum.Font.GothamSemibold
            DropdownLabel.TextSize = 13
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = Dropdown
            
            -- Arrow indicator
            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 0, 20)
            Arrow.Position = UDim2.new(1, -25, 0.5, -10)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "v"
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 14
            Arrow.TextColor3 = MenuSystem.Colors.Text
            Arrow.Parent = Dropdown
            
            Dropdown.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isOpen = not isOpen
                    if isOpen then
                        Dropdown.Size = UDim2.new(1, 0, 0, 32 * (#options + 1))
                        Arrow.Text = "^"
                        for _, btn in ipairs(optionButtons) do
                            btn.Visible = true
                        end
                    else
                        Dropdown.Size = UDim2.new(1, 0, 0, 32)
                        Arrow.Text = "v"
                        for _, btn in ipairs(optionButtons) do
                            btn.Visible = false
                        end
                    end
                end
            end)
            
            for i, option in ipairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 32)
                OptionButton.Position = UDim2.new(0, 0, 0, 32 * i)
                OptionButton.BackgroundColor3 = MenuSystem.Colors.Hover
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.TextSize = 12
                OptionButton.TextColor3 = MenuSystem.Colors.Text
                OptionButton.AutoButtonColor = false
                OptionButton.Visible = false
                OptionButton.ZIndex = 5
                OptionButton.Parent = Dropdown
                
                table.insert(optionButtons, OptionButton)
                
                OptionButton.MouseButton1Click:Connect(function()
                    selectedOption = option
                    DropdownLabel.Text = name .. ": " .. selectedOption
                    Dropdown.Size = UDim2.new(1, 0, 0, 32)
                    Arrow.Text = "v"
                    isOpen = false
                    for _, btn in ipairs(optionButtons) do
                        btn.Visible = false
                    end
                    spawn(function()
                        if callback then
                            callback(selectedOption)
                        end
                    end)
                end)
            end
            
            return Dropdown
        end
        
        -- Create label
        function tabFunctions:CreateLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = MenuSystem.Colors.TextSecondary
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.Parent = TabContent
            
            return Label
        end
        
        return tabFunctions
    end
    
    -- Make window draggable
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
    
    -- Entrance animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 550, 0, 380)
    }):Play()
    
    return MenuSystem
end

-- Destroy old menu if exists
if CoreGui:FindFirstChild("MenuSystem_" .. "My Menu") then
    CoreGui["MenuSystem_" .. "My Menu"]:Destroy()
end
if CoreGui:FindFirstChild("NotificationContainer") then
    CoreGui["NotificationContainer"]:Destroy()
end

return MenuSystem
