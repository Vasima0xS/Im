-- // UI Library Module
-- // SInAray UI Library v1.0

local UI = {}
UI.__index = UI

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- // Цвета по умолчанию
UI.DefaultSettings = {
    MainColor = Color3.fromRGB(20, 20, 25),
    SecondColor = Color3.fromRGB(30, 30, 40),
    AccentColor = Color3.fromRGB(100, 50, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(200, 200, 200)
}

-- // Создание окна
function UI.CreateWindow(title, version)
    local Window = {}
    setmetatable(Window, UI)
    
    local GUI = Instance.new("ScreenGui")
    GUI.Name = title .. "UI"
    GUI.Parent = CoreGui
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.BackgroundColor3 = UI.DefaultSettings.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = GUI
    
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MainFrame).Color = UI.DefaultSettings.AccentColor
    
    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = UI.DefaultSettings.SecondColor
    TitleBar.BorderSizePixel = 0
    
    local Title = Instance.new("TextLabel", TitleBar)
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title .. " v" .. (version or "1.0")
    Title.TextColor3 = UI.DefaultSettings.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local Close = Instance.new("TextButton", TitleBar)
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -30, 0, 0)
    Close.BackgroundTransparency = 1
    Close.Text = "✕"
    Close.TextColor3 = UI.DefaultSettings.TextColor
    Close.Font = Enum.Font.GothamBold
    Close.TextSize = 14
    
    Window.GUI = GUI
    Window.MainFrame = MainFrame
    Window.TitleBar = TitleBar
    Window.Close = Close
    Window.Tabs = {}
    
    -- Drag system
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    Close.MouseButton1Click:Connect(function()
        GUI:Destroy()
    end)
    
    -- Animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 600, 0, 400)
    }):Play()
    
    return Window
end

-- // Создание вкладки
function UI:CreateTab(name)
    local TabFrame = Instance.new("Frame", self.MainFrame)
    TabFrame.Size = UDim2.new(0, 120, 1, -30)
    TabFrame.Position = UDim2.new(0, 0, 0, 30)
    TabFrame.BackgroundColor3 = UI.DefaultSettings.SecondColor
    TabFrame.BorderSizePixel = 0
    
    local TabButton = Instance.new("TextButton", TabFrame)
    TabButton.Size = UDim2.new(1, -10, 0, 30)
    TabButton.Position = UDim2.new(0, 5, 0, 10 + (#self.Tabs * 35))
    TabButton.BackgroundColor3 = UI.DefaultSettings.AccentColor
    TabButton.Text = name
    TabButton.TextColor3 = UI.DefaultSettings.TextColor
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 12
    TabButton.BorderSizePixel = 0
    
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 4)
    
    local Content = Instance.new("ScrollingFrame", self.MainFrame)
    Content.Size = UDim2.new(1, -130, 1, -35)
    Content.Position = UDim2.new(0, 125, 0, 35)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 4
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.Visible = #self.Tabs == 0
    
    local UIList = Instance.new("UIListLayout", Content)
    UIList.Padding = UDim.new(0, 5)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    
    table.insert(self.Tabs, {
        Button = TabButton,
        Content = Content
    })
    
    TabButton.MouseButton1Click:Connect(function()
        for _, tab in ipairs(self.Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = UI.DefaultSettings.SecondColor
        end
        Content.Visible = true
        TabButton.BackgroundColor3 = UI.DefaultSettings.AccentColor
    end)
    
    return Content
end

-- // Создание секции
function UI:CreateSection(parent, name)
    local Section = Instance.new("Frame", parent)
    Section.Size = UDim2.new(1, -10, 0, 25)
    Section.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", Section)
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = UI.DefaultSettings.AccentColor
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    return Section
end

-- // Создание кнопки
function UI:CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton", parent)
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.BackgroundColor3 = UI.DefaultSettings.SecondColor
    Button.Text = name
    Button.TextColor3 = UI.DefaultSettings.TextColor
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.BorderSizePixel = 0
    
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 4)
    
    Button.MouseButton1Click:Connect(callback or function() end)
    
    return Button
end

-- // Создание чекбокса
function UI:CreateCheckbox(parent, name, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundTransparency = 1
    
    local Box = Instance.new("TextButton", Frame)
    Box.Size = UDim2.new(0, 20, 0, 20)
    Box.Position = UDim2.new(0, 0, 0, 5)
    Box.BackgroundColor3 = default and UI.DefaultSettings.AccentColor or UI.DefaultSettings.SecondColor
    Box.Text = ""
    Box.BorderSizePixel = 0
    
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 3)
    
    local Check = Instance.new("TextLabel", Box)
    Check.Size = UDim2.new(1, 0, 1, 0)
    Check.BackgroundTransparency = 1
    Check.Text = "✓"
    Check.TextColor3 = UI.DefaultSettings.TextColor
    Check.Font = Enum.Font.GothamBold
    Check.TextSize = 14
    Check.Visible = default or false
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, -30, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = UI.DefaultSettings.SubTextColor
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = default or false
    Box.MouseButton1Click:Connect(function()
        state = not state
        Box.BackgroundColor3 = state and UI.DefaultSettings.AccentColor or UI.DefaultSettings.SecondColor
        Check.Visible = state
        if callback then callback(state) end
    end)
    
    return {Toggle = Box, State = state}
end

-- // Создание слайдера
function UI:CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. (default or min)
    Label.TextColor3 = UI.DefaultSettings.SubTextColor
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderBg = Instance.new("Frame", Frame)
    SliderBg.Size = UDim2.new(1, 0, 0, 6)
    SliderBg.Position = UDim2.new(0, 0, 0, 25)
    SliderBg.BackgroundColor3 = UI.DefaultSettings.SecondColor
    SliderBg.BorderSizePixel = 0
    
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
    
    local Fill = Instance.new("Frame", SliderBg)
    local percent = ((default or min) - min) / (max - min)
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = UI.DefaultSettings.AccentColor
    Fill.BorderSizePixel = 0
    
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    
    local Knob = Instance.new("TextButton", SliderBg)
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new(percent, -6, 0, -3)
    Knob.BackgroundColor3 = UI.DefaultSettings.TextColor
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    
    local sliding = false
    
    local function update(input)
        local size = SliderBg.AbsoluteSize.X
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / size, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, -6, 0, -3)
        Label.Text = name .. ": " .. value
        
        if callback then callback(value) end
    end
    
    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
        end
    end)
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            update(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = false
        end
    end)
    
    return {Slider = SliderBg, Value = default or min}
end

-- // Создание выпадающего списка (ИСПРАВЛЕНО - поверх других элементов)
function UI:CreateDropdown(parent, name, options, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 30)
    Frame.BackgroundTransparency = 1
    Frame.ZIndex = 5
    
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, 0, 0, 28)
    Button.BackgroundColor3 = UI.DefaultSettings.SecondColor
    Button.Text = "▼ " .. name
    Button.TextColor3 = UI.DefaultSettings.SubTextColor
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 11
    Button.BorderSizePixel = 0
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.ZIndex = 5
    
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 4)
    
    local List = Instance.new("Frame", Frame)
    List.Size = UDim2.new(1, 0, 0, 0)
    List.Position = UDim2.new(0, 0, 1, 2)
    List.BackgroundColor3 = UI.DefaultSettings.SecondColor
    List.BorderSizePixel = 0
    List.Visible = false
    List.ZIndex = 100 -- ВЫСОКИЙ ZINDEX ДЛЯ ПОВЕРХ ВСЕХ ЭЛЕМЕНТОВ
    List.ClipsDescendants = true
    
    Instance.new("UICorner", List).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", List).Color = UI.DefaultSettings.AccentColor
    
    local open = false
    
    Button.MouseButton1Click:Connect(function()
        open = not open
        List.Visible = open
        if open then
            List.Size = UDim2.new(1, 0, 0, #options * 28)
            Frame.Size = UDim2.new(1, -10, 0, 35 + #options * 28)
        else
            List.Size = UDim2.new(1, 0, 0, 0)
            Frame.Size = UDim2.new(1, -10, 0, 30)
        end
    end)
    
    for i, option in ipairs(options) do
        local OptBtn = Instance.new("TextButton", List)
        OptBtn.Size = UDim2.new(1, 0, 0, 28)
        OptBtn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
        OptBtn.BackgroundColor3 = UI.DefaultSettings.SecondColor
        OptBtn.Text = option
        OptBtn.TextColor3 = UI.DefaultSettings.SubTextColor
        OptBtn.Font = Enum.Font.Gotham
        OptBtn.TextSize = 11
        OptBtn.BorderSizePixel = 0
        OptBtn.ZIndex = 101
        
        OptBtn.MouseButton1Click:Connect(function()
            Button.Text = "▼ " .. option
            open = false
            List.Visible = false
            List.Size = UDim2.new(1, 0, 0, 0)
            Frame.Size = UDim2.new(1, -10, 0, 30)
            if callback then callback(option) end
        end)
    end
    
    return {Button = Button, List = List}
end

-- // Создание переключателя
function UI:CreateToggle(parent, name, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 30)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0, 100, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = UI.DefaultSettings.SubTextColor
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Toggle = Instance.new("TextButton", Frame)
    Toggle.Size = UDim2.new(0, 40, 0, 20)
    Toggle.Position = UDim2.new(1, -40, 0, 5)
    Toggle.BackgroundColor3 = default and UI.DefaultSettings.AccentColor or UI.DefaultSettings.SecondColor
    Toggle.Text = ""
    Toggle.BorderSizePixel = 0
    
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    
    local Knob = Instance.new("Frame", Toggle)
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = default and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
    Knob.BackgroundColor3 = UI.DefaultSettings.TextColor
    Knob.BorderSizePixel = 0
    
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    
    local state = default or false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and UI.DefaultSettings.AccentColor or UI.DefaultSettings.SecondColor
        Knob.Position = state and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
        if callback then callback(state) end
    end)
    
    return {Toggle = Toggle, State = state}
end

return UI
