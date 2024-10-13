local ui = {}

function ui:Win(Title, Subtitle)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("TextLabel")
    local DestroyButton = Instance.new("TextButton")
    local TabHolder = Instance.new("ScrollingFrame")

    ScreenGui.Name = "CustomUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0.5, 0, 0.7, 0)
    MainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(70, 130, 180)

    local mainFrameCorner = Instance.new("UICorner")
    mainFrameCorner.Parent = MainFrame

    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0.1, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    TitleBar.Text = Title .. " - " .. Subtitle
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.Code

    DestroyButton.Parent = MainFrame
    DestroyButton.Size = UDim2.new(0.1, 0, 0.1, 0)
    DestroyButton.Position = UDim2.new(0.9, 0, 0, 0)
    DestroyButton.Text = "X"
    DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DestroyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    local destroyButtonCorner = Instance.new("UICorner")
    destroyButtonCorner.Parent = DestroyButton

    DestroyButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    TabHolder.Parent = MainFrame
    TabHolder.Size = UDim2.new(1, 0, 0.1, 0)
    TabHolder.Position = UDim2.new(0, 0, 0.1, 0)
    TabHolder.CanvasSize = UDim2.new(2, 0, 0, 0)
    TabHolder.ScrollBarThickness = 6
    TabHolder.ScrollingDirection = Enum.ScrollingDirection.X

    local self = {
        Tabs = {},
        MainFrame = MainFrame,
        TabHolder = TabHolder,
        TabCount = 0
    }

    function self:Tab(TabName)
        local Tab = {}
        self.TabCount = self.TabCount + 1

        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabHolder
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Position = UDim2.new(0, (self.TabCount - 1) * 110, 0, 0)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
        TabButton.Font = Enum.Font.Code

        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.Parent = TabButton

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Parent = MainFrame
        TabFrame.Size = UDim2.new(1, 0, 0.8, 0)
        TabFrame.Position = UDim2.new(0, 0, 0.2, 0)
        TabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        TabFrame.ScrollBarThickness = 6
        TabFrame.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.TabFrame.Visible = false
            end
            TabFrame.Visible = true
        end)

        Tab.TabFrame = TabFrame
        table.insert(self.Tabs, Tab)

        Tab.NextPositionY = 0

        function Tab:Button(params)
            local Button = Instance.new("TextButton")
            Button.Parent = TabFrame
            Button.Size = UDim2.new(0.9, 0, 0.1, 0)
            Button.Position = UDim2.new(0.05, 0, Tab.NextPositionY, 0)
            Button.Text = params.Name
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
            Button.Font = Enum.Font.Code

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                params.Callback()
            end)

            Tab.NextPositionY = Tab.NextPositionY + 0.1
        end

        function Tab:Label(Text)
            local Label = Instance.new("TextLabel")
            Label.Parent = TabFrame
            Label.Size = UDim2.new(0.9, 0, 0.1, 0)
            Label.Position = UDim2.new(0.05, 0, Tab.NextPositionY, 0)
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
            Label.Font = Enum.Font.Code

            local labelCorner = Instance.new("UICorner")
            labelCorner.Parent = Label

            Tab.NextPositionY = Tab.NextPositionY + 0.1
        end

        function Tab:Textbox(params)
            local TextBox = Instance.new("TextBox")
            TextBox.Parent = TabFrame
            TextBox.Size = UDim2.new(0.9, 0, 0.1, 0)
            TextBox.Position = UDim2.new(0.05, 0, Tab.NextPositionY, 0)
            TextBox.Text = params.Placeholder or ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
            TextBox.Font = Enum.Font.Code

            local previousText = TextBox.Text
            TextBox.Changed:Connect(function()
                if TextBox.Text ~= previousText then
                    previousText = TextBox.Text
                    params.Callback(previousText)
                end
            end)

            local textboxCorner = Instance.new("UICorner")
            textboxCorner.Parent = TextBox

            Tab.NextPositionY = Tab.NextPositionY + 0.1
        end

        function Tab:Toggle(params)
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = TabFrame
            ToggleButton.Size = UDim2.new(0.9, 0, 0.1, 0)
            ToggleButton.Position = UDim2.new(0.05, 0, Tab.NextPositionY, 0)
            ToggleButton.Text = params.Name .. ": OFF"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
            ToggleButton.Font = Enum.Font.Code

            local toggleButtonCorner = Instance.new("UICorner")
            toggleButtonCorner.Parent = ToggleButton

            local isToggled = false
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                ToggleButton.Text = params.Name .. ": " .. (isToggled and "ON" or "OFF")
                params.Callback(isToggled)
            end)

            Tab.NextPositionY = Tab.NextPositionY + 0.1
        end

        return Tab
    end

    return self
end

return ui
