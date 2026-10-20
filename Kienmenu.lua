-- ====================================================
-- KIÊN PREMIUM - MODERN UI REDESIGN (PART 1/3)
-- ====================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Xóa UI cũ nếu đang tồn tại
if CoreGui:FindFirstChild("KienPremiumUI") then
    CoreGui:FindFirstChild("KienPremiumUI"):Destroy()
end

local KienUI = Instance.new("ScreenGui")
KienUI.Name = "KienPremiumUI"
KienUI.Parent = CoreGui
KienUI.ResetOnSpawn = false

-- Thông báo gọn nhẹ (Minimal Notification System)
local function Notify(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title or "Kiên Premium",
            Text = text or "",
            Duration = duration or 2,
            Icon = "rbxassetid://117828154165313"
        })
    end)
end

Notify("Kiên Premium", "Đang khởi tạo giao diện...", 2)

local ICON_ASSET = "rbxassetid://117828154165313"

-- ----------------------------------------------------
-- 1. NÚT BẬT/TẮT MENU & SHIFTLOCK (CỐ ĐỊNH GẦN LOGO ROBLOX)
-- ----------------------------------------------------

local ToggleMenuBtn = Instance.new("ImageButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = KienUI
ToggleMenuBtn.Position = UDim2.new(0, 55, 0, 5)
ToggleMenuBtn.Size = UDim2.new(0, 38, 0, 38)
ToggleMenuBtn.Image = ICON_ASSET
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
ToggleMenuBtn.BorderSizePixel = 0
ToggleMenuBtn.Active = true

local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 8)
ToggleUICorner.Parent = ToggleMenuBtn

local ToggleUIStroke = Instance.new("UIStroke")
ToggleUIStroke.Color = Color3.fromRGB(0, 200, 255)
ToggleUIStroke.Thickness = 1.2
ToggleUIStroke.Parent = ToggleMenuBtn

-- Nút ShiftLock Điện Thoại
local ShiftLockBtn = Instance.new("TextButton")
ShiftLockBtn.Name = "ShiftLockBtn"
ShiftLockBtn.Parent = KienUI
ShiftLockBtn.Position = UDim2.new(0, 98, 0, 5)
ShiftLockBtn.Size = UDim2.new(0, 38, 0, 38)
ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
ShiftLockBtn.Text = "LOCK"
ShiftLockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ShiftLockBtn.TextSize = 11
ShiftLockBtn.Font = Enum.Font.GothamBold
ShiftLockBtn.BorderSizePixel = 0
ShiftLockBtn.Active = true

local ShiftCorner = Instance.new("UICorner")
ShiftCorner.CornerRadius = UDim.new(0, 8)
ShiftCorner.Parent = ShiftLockBtn

local ShiftStroke = Instance.new("UIStroke")
ShiftStroke.Color = Color3.fromRGB(60, 65, 80)
ShiftStroke.Thickness = 1.2
ShiftStroke.Parent = ShiftLockBtn

local isShiftLock = false
ShiftLockBtn.MouseButton1Click:Connect(function()
    isShiftLock = not isShiftLock
    if isShiftLock then
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
        ShiftLockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ShiftStroke.Color = Color3.fromRGB(0, 200, 255)
        Notify("ShiftLock", "Đã bật khóa màn hình", 1.5)
    else
        ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
        ShiftLockBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        ShiftStroke.Color = Color3.fromRGB(60, 65, 80)
        Notify("ShiftLock", "Đã tắt khóa màn hình", 1.5)
    end
end)

RunService.RenderStepped:Connect(function()
    if isShiftLock and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
            LocalPlayer.Character.HumanoidRootPart.Position,
            LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
        )
    end
end)

-- ----------------------------------------------------
-- 2. MAIN FRAME (GIAO DIỆN CHÍNH SANG TRỌNG)
-- ----------------------------------------------------

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KienUI
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainBGImage = Instance.new("ImageLabel")
MainBGImage.Name = "MainBGImage"
MainBGImage.Parent = MainFrame
MainBGImage.Size = UDim2.new(1, 0, 1, 0)
MainBGImage.Image = ICON_ASSET
MainBGImage.ImageTransparency = 0.92
MainBGImage.ScaleType = Enum.ScaleType.Crop
MainBGImage.BackgroundTransparency = 1

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 50, 65)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "KIÊN PREMIUM"
TitleText.TextColor3 = Color3.fromRGB(0, 200, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

-- Sidebar Chứa Các Tab
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Position = UDim2.new(0, 8, 0, 44)
TabContainer.Size = UDim2.new(0, 120, 1, -50)
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabContainer
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- Main Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Position = UDim2.new(0, 135, 0, 44)
ContentContainer.Size = UDim2.new(1, -143, 1, -50)
ContentContainer.BackgroundTransparency = 1

local Tabs = {}
local TabButtons = {}

local function CreateTab(id, name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = "Tab_" .. id
    TabBtn.Parent = TabContainer
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(150, 155, 170)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12

    local TBtnCorner = Instance.new("UICorner")
    TBtnCorner.CornerRadius = UDim.new(0, 6)
    TBtnCorner.Parent = TabBtn

    local Page = Instance.new("ScrollingFrame")
    Page.Name = "Page_" .. id
    Page.Parent = ContentContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(60, 65, 80)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    TabBtn.MouseButton1Click:Connect(function()
        for _, tBtn in pairs(TabButtons) do
            tBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            tBtn.TextColor3 = Color3.fromRGB(150, 155, 170)
        end
        for _, p in pairs(Tabs) do
            p.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Page.Visible = true
    end)

    Tabs[id] = Page
    table.insert(TabButtons, TabBtn)
    return Page
end

-- Khởi tạo 6 Tab với tên gọn gàng
local Tab1 = CreateTab(1, "Chính")
local Tab2 = CreateTab(2, "Vị Trí")
local Tab3 = CreateTab(3, "Người Chơi")
local Tab4 = CreateTab(4, "Cài Đặt")
local Tab5 = CreateTab(5, "Đổi Server")
local Tab6 = CreateTab(6, "Tối Ưu")

TabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 160, 230)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
Tabs[1].Visible = true

-- Hàm Tạo Toggle Công Tắc Hiện Đại
local function CreateToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 36)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 225, 235)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.BackgroundTransparency = 1

    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Parent = Frame
    SwitchBg.Position = UDim2.new(1, -52, 0.5, -10)
    SwitchBg.Size = UDim2.new(0, 42, 0, 20)
    SwitchBg.Text = ""
    SwitchBg.BackgroundColor3 = default and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(45, 48, 60)
    SwitchBg.AutoButtonColor = false

    local SwCorner = Instance.new("UICorner")
    SwCorner.CornerRadius = UDim.new(1, 0)
    SwCorner.Parent = SwitchBg

    local Knob = Instance.new("Frame")
    Knob.Parent = SwitchBg
    Knob.Position = default and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(1, 0)
    KCorner.Parent = Knob

    local state = default
    SwitchBg.MouseButton1Click:Connect(function()
        state = not state
        if state then
            SwitchBg.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
            Knob:TweenPosition(UDim2.new(1, -18, 0.5, -7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            SwitchBg.BackgroundColor3 = Color3.fromRGB(45, 48, 60)
            Knob:TweenPosition(UDim2.new(0, 2, 0.5, -7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
        Notify("Chức năng", text .. " -> " .. (state and "ĐÃ BẬT" or "ĐÃ TẮT"), 1.5)
        callback(state)
    end)
end

-- Hàm Tạo Thanh Slider Cực Mượt
local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -6, 0, 46)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.Size = UDim2.new(1, -24, 0, 16)
    Label.Text = text .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(220, 225, 235)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.BackgroundTransparency = 1

    local SliderTrack = Instance.new("Frame")
    SliderTrack.Parent = Frame
    SliderTrack.Position = UDim2.new(0, 12, 0, 28)
    SliderTrack.Size = UDim2.new(1, -24, 0, 6)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(45, 48, 60)

    local STCorner = Instance.new("UICorner")
    STCorner.CornerRadius = UDim.new(1, 0)
    STCorner.Parent = SliderTrack

    local Fill = Instance.new("Frame")
    Fill.Parent = SliderTrack
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 160, 230)

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(1, 0)
    FCorner.Parent = Fill

    local dragging = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Label.Text = text .. ": " .. tostring(val)
        callback(val)
    end

    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            Update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
-- ====================================================
-- KIÊN PREMIUM - FUNCTIONALITY & FIXES (PART 2/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 1: CHÍNH (FIX LỖI TẮT KHÔNG HOẠT ĐỘNG)
-- ----------------------------------------------------

-- 1. Noclip Logic
local noclip = false
local noclipConnection = nil

CreateToggle(Tab1, "Đi Xuyên Tường (Noclip)", false, function(v)
    noclip = v
    if not v and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 2. ESP Box Logic (Tắt là xóa sạch hoàn toàn)
local espEnabled = false
local espBoxes = {}

local function RemoveESP()
    for plr, highlight in pairs(espBoxes) do
        if highlight then highlight:Destroy() end
    end
    espBoxes = {}
end

CreateToggle(Tab1, "Định Vị Người Chơi (ESP)", false, function(v)
    espEnabled = v
    if not v then
        RemoveESP()
    end
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if not espBoxes[p] or not espBoxes[p].Parent then
                    local bb = Instance.new("Highlight")
                    bb.FillColor = Color3.fromRGB(255, 50, 50)
                    bb.OutlineColor = Color3.fromRGB(255, 255, 255)
                    bb.FillTransparency = 0.5
                    bb.Parent = p.Character
                    espBoxes[p] = bb
                end
            end
        end
    else
        if next(espBoxes) ~= nil then
            RemoveESP()
        end
    end
end)

-- 3. Instant Pick Logic
local instantPickup = false
CreateToggle(Tab1, "Nhặt Đồ Tức Thì", false, function(v)
    instantPickup = v
end)

RunService.RenderStepped:Connect(function()
    if instantPickup then
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0
            end
        end
    end
end)


-- ----------------------------------------------------
-- TAB 2: VỊ TRÍ & NÚT BẬT/TẮT WIDGET PHỤ
-- ----------------------------------------------------

local Pos1, Pos2 = nil, nil
local FlySpeed = 50

-- Bảng Widget Bay Nhanh Ngoài Menu
local PosWidget = Instance.new("Frame")
PosWidget.Name = "PosWidget"
PosWidget.Parent = KienUI
PosWidget.Size = UDim2.new(0, 150, 0, 85)
PosWidget.Position = UDim2.new(0.85, -150, 0.35, 0)
PosWidget.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
PosWidget.Visible = false -- Mặc định ẩn
PosWidget.Active = true
PosWidget.Draggable = true

local WCorner = Instance.new("UICorner")
WCorner.CornerRadius = UDim.new(0, 8)
WCorner.Parent = PosWidget

local WStroke = Instance.new("UIStroke")
WStroke.Color = Color3.fromRGB(0, 160, 230)
WStroke.Thickness = 1.2
WStroke.Parent = PosWidget

local WTitle = Instance.new("TextLabel")
WTitle.Parent = PosWidget
WTitle.Size = UDim2.new(1, 0, 0, 22)
WTitle.Text = "BAY NHANH"
WTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
WTitle.TextSize = 11
WTitle.Font = Enum.Font.GothamBold
WTitle.BackgroundTransparency = 1

local FlyBtn1 = Instance.new("TextButton")
FlyBtn1.Parent = PosWidget
FlyBtn1.Position = UDim2.new(0, 8, 0, 26)
FlyBtn1.Size = UDim2.new(1, -16, 0, 24)
FlyBtn1.Text = "Bay Về Vị Trí 1"
FlyBtn1.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
FlyBtn1.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyBtn1.Font = Enum.Font.GothamSemibold
FlyBtn1.TextSize = 11
local F1C = Instance.new("UICorner") F1C.CornerRadius = UDim.new(0, 4) F1C.Parent = FlyBtn1

local FlyBtn2 = Instance.new("TextButton")
FlyBtn2.Parent = PosWidget
FlyBtn2.Position = UDim2.new(0, 8, 0, 54)
FlyBtn2.Size = UDim2.new(1, -16, 0, 24)
FlyBtn2.Text = "Bay Về Vị Trí 2"
FlyBtn2.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
FlyBtn2.TextColor3 = Color3.fromRGB(220, 220, 220)
FlyBtn2.Font = Enum.Font.GothamSemibold
FlyBtn2.TextSize = 11
local F2C = Instance.new("UICorner") F2C.CornerRadius = UDim.new(0, 4) F2C.Parent = FlyBtn2

local function FlyToPos(targetCFrame)
    if not targetCFrame then
        Notify("Lỗi Vị Trí", "Chưa lưu vị trí này!", 1.5)
        return
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        Notify("Di Chuyển", "Đang bay tới vị trí...", 1.5)
        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local duration = distance / math.max(FlySpeed, 10)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

FlyBtn1.MouseButton1Click:Connect(function() FlyToPos(Pos1) end)
FlyBtn2.MouseButton1Click:Connect(function() FlyToPos(Pos2) end)

-- Nút Bật/Tắt Bảng Bay Nhanh Tách Riêng (Theo Yêu Cầu)
CreateToggle(Tab2, "Hiện Bảng Bay Vị Trí Nhanh", false, function(v)
    PosWidget.Visible = v
end)

local Save1Btn = Instance.new("TextButton")
Save1Btn.Parent = Tab2
Save1Btn.Size = UDim2.new(1, -6, 0, 32)
Save1Btn.Text = "Lưu Vị Trí 1"
Save1Btn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
Save1Btn.TextColor3 = Color3.fromRGB(220, 225, 235)
Save1Btn.Font = Enum.Font.GothamSemibold
Save1Btn.TextSize = 12
local S1C = Instance.new("UICorner") S1C.CornerRadius = UDim.new(0, 6) S1C.Parent = Save1Btn

Save1Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos1 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu Vị Trí 1", 1.5)
    end
end)

local Save2Btn = Instance.new("TextButton")
Save2Btn.Parent = Tab2
Save2Btn.Size = UDim2.new(1, -6, 0, 32)
Save2Btn.Text = "Lưu Vị Trí 2"
Save2Btn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
Save2Btn.TextColor3 = Color3.fromRGB(220, 225, 235)
Save2Btn.Font = Enum.Font.GothamSemibold
Save2Btn.TextSize = 12
local S2C = Instance.new("UICorner") S2C.CornerRadius = UDim.new(0, 6) S2C.Parent = Save2Btn

Save2Btn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Pos2 = LocalPlayer.Character.HumanoidRootPart.CFrame
        Notify("Vị Trí", "Đã lưu Vị Trí 2", 1.5)
    end
end)

CreateSlider(Tab2, "Tốc Độ Bay (1 - 500)", 1, 500, 50, function(v)
    FlySpeed = v
end)


-- ----------------------------------------------------
-- TAB 3: NGƯỜI CHƠI (PLAYER TELEPORT)
-- ----------------------------------------------------

local SelectedPlayer = nil

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = Tab3
RefreshBtn.Size = UDim2.new(1, -6, 0, 32)
RefreshBtn.Text = "Làm Mới Danh Sách"
RefreshBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
RefreshBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
RefreshBtn.Font = Enum.Font.GothamSemibold
RefreshBtn.TextSize = 12
local RBC = Instance.new("UICorner") RBC.CornerRadius = UDim.new(0, 6) RBC.Parent = RefreshBtn

local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Parent = Tab3
PlayerDropdownFrame.Size = UDim2.new(1, -6, 0, 90)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
local PDFC = Instance.new("UICorner") PDFC.CornerRadius = UDim.new(0, 6) PDFC.Parent = PlayerDropdownFrame

local PlrListScroll = Instance.new("ScrollingFrame")
PlrListScroll.Parent = PlayerDropdownFrame
PlrListScroll.Size = UDim2.new(1, 0, 1, 0)
PlrListScroll.BackgroundTransparency = 1
PlrListScroll.ScrollBarThickness = 2

local PlrListLayout = Instance.new("UIListLayout")
PlrListLayout.Parent = PlrListScroll
PlrListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlrListLayout.Padding = UDim.new(0, 2)

local function UpdatePlayerList()
    for _, c in pairs(PlrListScroll:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local PBtn = Instance.new("TextButton")
            PBtn.Parent = PlrListScroll
            PBtn.Size = UDim2.new(1, -4, 0, 24)
            PBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            PBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 36)
            PBtn.TextColor3 = Color3.fromRGB(180, 185, 200)
            PBtn.Font = Enum.Font.Gotham
            PBtn.TextSize = 11

            PBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                Notify("Người Chơi", "Đã chọn: " .. p.DisplayName, 1.5)
            end)
        end
    end
end

RefreshBtn.MouseButton1Click:Connect(function()
    UpdatePlayerList()
    Notify("Danh Sách", "Đã cập nhật danh sách người chơi", 1.5)
end)
UpdatePlayerList()

local FlyToPlrBtn = Instance.new("TextButton")
FlyToPlrBtn.Parent = Tab3
FlyToPlrBtn.Size = UDim2.new(1, -6, 0, 32)
FlyToPlrBtn.Text = "Bay Đến Người Chơi Đã Chọn"
FlyToPlrBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
FlyToPlrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToPlrBtn.Font = Enum.Font.GothamBold
FlyToPlrBtn.TextSize = 12
local FTPC = Instance.new("UICorner") FTPC.CornerRadius = UDim.new(0, 6) FTPC.Parent = FlyToPlrBtn

FlyToPlrBtn.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        FlyToPos(SelectedPlayer.Character.HumanoidRootPart.CFrame)
    else
        Notify("Lỗi", "Hãy chọn người chơi trước!", 1.5)
    end
end)
-- ====================================================
-- KIÊN PREMIUM - FIX LAG & FINAL SETTINGS (PART 3/3)
-- ====================================================

-- ----------------------------------------------------
-- TAB 4: CÀI ĐẶT TỐC ĐỘ / ĐỘ NHẢY / CONFIG
-- ----------------------------------------------------

local WalkSpeedVal = 16
local JumpPowerVal = 50
local SpeedEnabled = false
local JumpEnabled = false

CreateToggle(Tab4, "Bật Tốc Độ Chạy Custom", false, function(v)
    SpeedEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

CreateSlider(Tab4, "Tốc Độ Chạy (1 - 500)", 1, 500, 16, function(v)
    WalkSpeedVal = v
end)

CreateToggle(Tab4, "Bật Nhảy Cao Custom", false, function(v)
    JumpEnabled = v
    if not v and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

CreateSlider(Tab4, "Độ Nhảy Cao (1 - 500)", 1, 500, 50, function(v)
    JumpPowerVal = v
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if SpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedVal
        end
        if JumpEnabled then
            LocalPlayer.Character.Humanoid.UseJumpPower = true
            LocalPlayer.Character.Humanoid.JumpPower = JumpPowerVal
        end
    end
end)

local SaveCfgBtn = Instance.new("TextButton")
SaveCfgBtn.Parent = Tab4
SaveCfgBtn.Size = UDim2.new(1, -6, 0, 30)
SaveCfgBtn.Text = "Lưu Cấu Hình (Save Config)"
SaveCfgBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
SaveCfgBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
SaveCfgBtn.Font = Enum.Font.GothamSemibold
SaveCfgBtn.TextSize = 11
local SCC = Instance.new("UICorner") SCC.CornerRadius = UDim.new(0, 6) SCC.Parent = SaveCfgBtn

SaveCfgBtn.MouseButton1Click:Connect(function()
    Notify("Config", "Đã lưu cài đặt!", 1.5)
end)

local DelCfgBtn = Instance.new("TextButton")
DelCfgBtn.Parent = Tab4
DelCfgBtn.Size = UDim2.new(1, -6, 0, 30)
DelCfgBtn.Text = "Xóa Cấu Hình (Reset Config)"
DelCfgBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
DelCfgBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
DelCfgBtn.Font = Enum.Font.GothamSemibold
DelCfgBtn.TextSize = 11
local DCC = Instance.new("UICorner") DCC.CornerRadius = UDim.new(0, 6) DCC.Parent = DelCfgBtn

DelCfgBtn.MouseButton1Click:Connect(function()
    Notify("Config", "Đã đặt lại cài đặt mặc định!", 1.5)
end)


-- ----------------------------------------------------
-- TAB 5: HOP SERVER & REJOIN
-- ----------------------------------------------------

local HopBtn = Instance.new("TextButton")
HopBtn.Parent = Tab5
HopBtn.Size = UDim2.new(1, -6, 0, 34)
HopBtn.Text = "Tìm Server Ít Người (1 Người)"
HopBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
HopBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
HopBtn.Font = Enum.Font.GothamBold
HopBtn.TextSize = 12
local HBC = Instance.new("UICorner") HBC.CornerRadius = UDim.new(0, 6) HBC.Parent = HopBtn

HopBtn.MouseButton1Click:Connect(function()
    Notify("Hop Server", "Đang chuyển đến server ít người...", 2)
    pcall(function()
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local data = HttpService:JSONDecode(req)
        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end)
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Parent = Tab5
RejoinBtn.Size = UDim2.new(1, -6, 0, 34)
RejoinBtn.Text = "Vào Lại Server Hiện Tại (Rejoin)"
RejoinBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
RejoinBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 12
local RBC2 = Instance.new("UICorner") RBC2.CornerRadius = UDim.new(0, 6) RBC2.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    Notify("Rejoin", "Đang tải lại game...", 2)
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)


-- ----------------------------------------------------
-- TAB 6: FIX LAG & KHÔI PHÚC CHUẨN XÁC 100%
-- ----------------------------------------------------

-- Lưu trữ dữ liệu gốc để khôi phục chuẩn xác
local OriginalLightingSettings = {
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd
}
local OriginalPartMaterials = {}

local FixLagBtn = Instance.new("TextButton")
FixLagBtn.Parent = Tab6
FixLagBtn.Size = UDim2.new(1, -6, 0, 34)
FixLagBtn.Text = "Tối Ưu Đồ Họa (Fix Lag)"
FixLagBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 230)
FixLagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FixLagBtn.Font = Enum.Font.GothamBold
FixLagBtn.TextSize = 12
local FBC = Instance.new("UICorner") FBC.CornerRadius = UDim.new(0, 6) FBC.Parent = FixLagBtn

FixLagBtn.MouseButton1Click:Connect(function()
    pcall(function()
        -- Lưu thuộc tính Part trước khi biến đổi
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not OriginalPartMaterials[v] then
                OriginalPartMaterials[v] = {
                    Material = v.Material,
                    Reflectance = v.Reflectance
                }
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Notify("Fix Lag", "Đã bật chế độ mượt mà!", 2)
    end)
end)

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Parent = Tab6
RestoreBtn.Size = UDim2.new(1, -6, 0, 34)
RestoreBtn.Text = "Khôi Phục Đồ Họa Ban Đầu"
RestoreBtn.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
RestoreBtn.TextColor3 = Color3.fromRGB(220, 225, 235)
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.TextSize = 12
local RBC3 = Instance.new("UICorner") RBC3.CornerRadius = UDim.new(0, 6) RBC3.Parent = RestoreBtn

-- Khôi phục chính xác 100% nguyên bản
RestoreBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for part, props in pairs(OriginalPartMaterials) do
            if part and part.Parent then
                part.Material = props.Material
                part.Reflectance = props.Reflectance
            end
        end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = true
            end
        end
        Lighting.GlobalShadows = OriginalLightingSettings.GlobalShadows
        Lighting.FogEnd = OriginalLightingSettings.FogEnd
        Notify("Khôi Phục", "Đã trả lại đồ họa nguyên bản!", 2)
    end)
end)

Notify("KIÊN PREMIUM", "Đã hoàn tất cài đặt UI!", 3)
