--[[
[-]:This isn't gui2lua
[-]:Please don't skids it
[-]:The console doesn't fully works, it doesn't fully log if too long, if you can fix, please do
[-]:That's all
[-]:TBX out :)
]]--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.5, 0, 0.5, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Frame_2 = Instance.new("Frame")
Frame_2.Size = UDim2.new(0.98, 0, 0.98, 0)
Frame_2.Position = UDim2.new(0.01, 0, 0.01, 0)
Frame_2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame_2.Parent = Frame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0.95, 0, 0.1, 0)
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
TextLabel.Text = "Console"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = Frame_2

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(0.05, 0, 0.1, 0)
TextButton.Position = UDim2.new(0.95, 0, 0, 0)
TextButton.Text = "X"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
TextButton.Parent = Frame_2

local TextButton_2 = Instance.new("TextButton")
TextButton_2.Size = UDim2.new(0.2, 0, 0.1, 0)
TextButton_2.Position = UDim2.new(0, 0, 0.15, 0)
TextButton_2.Text = "Execute"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
TextButton_2.Parent = Frame_2

local TextButton_3 = Instance.new("TextButton")
TextButton_3.Size = UDim2.new(0.2, 0, 0.1, 0)
TextButton_3.Position = UDim2.new(0, 0, 0.27, 0)
TextButton_3.Text = "Clear"
TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.BackgroundColor3 = Color3.fromRGB(150, 150, 30)
TextButton_3.Parent = Frame_2

local TextButton_4 = Instance.new("TextButton")
TextButton_4.Size = UDim2.new(0.2, 0, 0.1, 0)
TextButton_4.Position = UDim2.new(0, 0, 0.39, 0)
TextButton_4.Text = "Clear Logs"
TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
TextButton_4.Parent = Frame_2

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(0.75, 0, 0.4, 0)
ScrollingFrame.Position = UDim2.new(0.22, 0, 0.15, 0)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.Parent = Frame_2

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.75, 0, 0.1, 0)
TextBox.Position = UDim2.new(0.22, 0, 0.56, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextWrapped = true
TextBox.Text = ""
TextBox.PlaceholderText = "print('Yo')"
TextBox.MultiLine = true
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame_2

local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.Size = UDim2.new(0.05, 0, 0.1, 0)
TextLabel_2.Position = UDim2.new(0.17, 0, 0.56, 0)
TextLabel_2.Text = ">"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_2.Parent = Frame_2

local function AddLogEntry(Message)
    local Time = os.date("%H:%M:%S")
    
    for Line in Message:gmatch("[^\n]+") do
        local NewLog = Instance.new("TextLabel")
        NewLog.BackgroundTransparency = 1
        NewLog.TextColor3 = Color3.fromRGB(255, 255, 255)
        NewLog.TextWrapped = true
        NewLog.TextXAlignment = Enum.TextXAlignment.Left
        NewLog.Text = "[" .. Time .. "]: " .. Line
        NewLog.Size = UDim2.new(1, 0, 0, NewLog.TextBounds.Y + 5)
        NewLog.Parent = ScrollingFrame
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
    ScrollingFrame.CanvasPosition = Vector2.new(0, ScrollingFrame.CanvasSize.Y.Offset)
end

TextButton_2.MouseButton1Click:Connect(function()
    local Command = TextBox.Text
    local Success, ErrorMessage = pcall(function()
        local Result = loadstring(Command)()
        if Result then
            print(Result)
        end
    end)

    if not Success then
        error(ErrorMessage)
    end

    AddLogEntry(Command)
    TextBox.Text = ""
end)

TextButton_3.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

TextButton_4.MouseButton1Click:Connect(function()
    for _, Child in pairs(ScrollingFrame:GetChildren()) do
        if Child:IsA("TextLabel") then
            Child:Destroy()
        end
    end
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end)

TextButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

game:GetService("LogService").MessageOut:Connect(function(Message, MessageType)
    AddLogEntry(Message)
end)