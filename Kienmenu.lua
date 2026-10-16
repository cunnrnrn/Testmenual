-- KING LOP 94 - PHANTOM OVERDRIVE | TRAN 3
-- PHAN 1/2 - CORE UI
-- Dat trong StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("PhantomOverdriveUI")
if oldGui then
    oldGui:Destroy()
end

local COLORS = {
    Background = Color3.fromRGB(10, 12, 20),
    Panel = Color3.fromRGB(17, 20, 32),
    Surface = Color3.fromRGB(24, 28, 43),
    SurfaceHover = Color3.fromRGB(34, 39, 58),
    Purple = Color3.fromRGB(155, 92, 255),
    Cyan = Color3.fromRGB(50, 225, 255),
    White = Color3.fromRGB(240, 243, 255),
    Muted = Color3.fromRGB(139, 148, 174),
    Green = Color3.fromRGB(75, 235, 160),
    Red = Color3.fromRGB(255, 91, 116),
    Border = Color3.fromRGB(53, 58, 82)
}

local settings = {
    Notifications = true,
    NeonEffects = true,
    ShowClock = true,
    CompactMode = false,
    DemoToggle = false,
    Intensity = 50,
    UITransparency = 0
}

local gui = Instance.new("ScreenGui")
gui.Name = "PhantomOverdriveUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.DisplayOrder = 50
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function create(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props or {}) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local function round(parent, radius)
    return create("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, parent)
end

local function stroke(parent, color, thickness, transparency)
    return create("UIStroke", {
        Color = color or COLORS.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, parent)
end

local function padding(parent, left, right, top, bottom)
    return create("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0)
    }, parent)
end

local function makeLabel(parent, text, size, color, font)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextSize = size or 14,
        TextColor3 = color or COLORS.White,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Size = UDim2.new(1, 0, 0, 22)
    }, parent)
end

local function makeButton(parent, text, size)
    local button = create("TextButton", {
        AutoButtonColor = false,
        Text = text,
        TextSize = 13,
        TextColor3 = COLORS.White,
        Font = Enum.Font.GothamSemibold,
        BackgroundColor3 = COLORS.Surface,
        Size = size or UDim2.new(1, 0, 0, 38)
    }, parent)
    round(button, 9)
    stroke(button, COLORS.Border, 1, 0.3)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = COLORS.SurfaceHover
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = COLORS.Surface
        }):Play()
    end)

    return button
end

local function tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    animation:Play()
    return animation
end

-- Main window
local main = create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(590, 410),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
round(main, 16)
stroke(main, COLORS.Purple, 1.4, 0.15)

local mainGradient = create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 17, 29)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(9, 12, 21))
    }),
    Rotation = 35
}, main)

-- Neon top line
local neonLine = create("Frame", {
    Name = "NeonLine",
    BorderSizePixel = 0,
    BackgroundColor3 = COLORS.Cyan,
    Position = UDim2.new(0, 18, 0, 0),
    Size = UDim2.new(1, -36, 0, 3)
}, main)
round(neonLine, 3)

-- Header
local header = create("Frame", {
    Name = "Header",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(16, 10),
    Size = UDim2.new(1, -32, 0, 57)
}, main)

local logo = create("Frame", {
    BackgroundColor3 = COLORS.Purple,
    Position = UDim2.fromOffset(0, 5),
    Size = UDim2.fromOffset(42, 42)
}, header)
round(logo, 12)

create("UIGradient", {
    Color = ColorSequence.new(COLORS.Purple, COLORS.Cyan),
    Rotation = 35
}, logo)

create("TextLabel", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Text = "K94",
    TextColor3 = COLORS.White,
    TextSize = 15,
    Font = Enum.Font.GothamBlack
}, logo)

local title = create("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(54, 2),
    Size = UDim2.new(1, -155, 0, 25),
    Text = "PHANTOM OVERDRIVE",
    TextColor3 = COLORS.White,
    TextSize = 17,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local subtitle = create("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(55, 27),
    Size = UDim2.new(1, -155, 0, 19),
    Text = "KING LOP 94  /  TRAN 03",
    TextColor3 = COLORS.Cyan,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local minimizeButton = makeButton(
    header, "—", UDim2.fromOffset(32, 30)
)
minimizeButton.Position = UDim2.new(1, -70, 0, 8)
minimizeButton.TextSize = 17

local closeButton = makeButton(
    header, "×", UDim2.fromOffset(32, 30)
)
closeButton.Position = UDim2.new(1, -34, 0, 8)
closeButton.TextSize = 21
closeButton.TextColor3 = COLORS.Red

local divider = create("Frame", {
    BackgroundColor3 = COLORS.Border,
    BackgroundTransparency = 0.25,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(16, 72),
    Size = UDim2.new(1, -32, 0, 1)
}, main)

-- Main content area
local content = create("Frame", {
    Name = "Content",
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(14, 84),
    Size = UDim2.new(1, -28, 1, -98)
}, main)

local sidebar = create("Frame", {
    Name = "Sidebar",
    BackgroundColor3 = COLORS.Panel,
    Size = UDim2.new(0, 130, 1, 0)
}, content)
round(sidebar, 12)
stroke(sidebar, COLORS.Border, 1, 0.45)
padding(sidebar, 8, 8, 10, 8)

local tabList = create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local page = create("ScrollingFrame", {
    Name = "Page",
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 142, 0, 0),
    Size = UDim2.new(1, -142, 1, 0),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLORS.Cyan
}, content)
round(page, 12)
stroke(page, COLORS.Border, 1, 0.45)
padding(page, 14, 14, 13, 14)

local pageLayout = create("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
}, page)

local tabs = {}
local currentTab = nil
local minimized = false
local windowClosed = false
local savedWindowSize = UDim2.fromOffset(590, 410)

local function clearPage()
    for _, child in ipairs(page:GetChildren()) do
        if child ~= pageLayout and child.Name ~= "UIPadding" then
            child:Destroy()
        end
    end
end

local function addTab(name, iconText)
    local button = makeButton(
        sidebar,
        iconText .. "  " .. name,
        UDim2.new(1, 0, 0, 37)
    )
    button.Name = name .. "Tab"
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.TextSize = 11
    button.LayoutOrder = #tabs + 1
    padding(button, 9, 4, 0, 0)

    tabs[#tabs + 1] = {
        Name = name,
        Icon = iconText,
        Button = button
    }

    return button
end

-- PHAN 1 KET THUC TAI DAY.
-- Dan tiep PHAN 2/2 ngay sau dong nay.
-- KING LOP 94 - PHANTOM OVERDRIVE | TRAN 3
-- PHAN 2/2 - COMPONENTS & STARTUP

-- Toast notification
local toast = create("Frame", {
    Name = "Toast",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -18, 0, 18),
    Size = UDim2.fromOffset(245, 66),
    BackgroundColor3 = COLORS.Surface,
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 20
}, gui)
round(toast, 12)
stroke(toast, COLORS.Cyan, 1, 0.2)

local toastTitle = create("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(12, 7),
    Size = UDim2.new(1, -24, 0, 20),
    Text = "PHANTOM SYSTEM",
    TextColor3 = COLORS.Cyan,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 21
}, toast)

local toastMessage = create("TextLabel", {
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(12, 29),
    Size = UDim2.new(1, -24, 0, 25),
    Text = "",
    TextColor3 = COLORS.White,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 21
}, toast)

local toastVersion = 0

local function notify(message, titleText)
    if not settings.Notifications then
        return
    end

    toastVersion += 1
    local thisVersion = toastVersion

    toastTitle.Text = titleText or "PHANTOM SYSTEM"
    toastMessage.Text = tostring(message)
    toast.Visible = true
    toast.BackgroundTransparency = 1
    toast.Position = UDim2.new(1, 15, 0, 18)

    tween(toast, 0.22, {
        BackgroundTransparency = 0,
        Position = UDim2.new(1, -18, 0, 18)
    })

    task.delay(2.5, function()
        if thisVersion ~= toastVersion or not toast.Parent then
            return
        end

        tween(toast, 0.2, {
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 15, 0, 18)
        })

        task.wait(0.22)

        if thisVersion == toastVersion and toast.Parent then
            toast.Visible = false
        end
    end)
end

-- Reusable section title
local function addSection(text)
    local label = makeLabel(page, text, 12, COLORS.Cyan, Enum.Font.GothamBold)
    label.Size = UDim2.new(1, 0, 0, 24)
    return label
end

-- Reusable description card
local function addCard(titleText, description)
    local card = create("Frame", {
        BackgroundColor3 = COLORS.Surface,
        Size = UDim2.new(1, 0, 0, 70)
    }, page)
    round(card, 10)
    stroke(card, COLORS.Border, 1, 0.45)

    local heading = makeLabel(
        card, titleText, 13, COLORS.White, Enum.Font.GothamBold
    )
    heading.Position = UDim2.fromOffset(12, 8)
    heading.Size = UDim2.new(1, -24, 0, 21)

    local body = makeLabel(
        card, description, 10, COLORS.Muted, Enum.Font.Gotham
    )
    body.Position = UDim2.fromOffset(12, 33)
    body.Size = UDim2.new(1, -24, 0, 27)
    body.TextWrapped = true
    body.TextYAlignment = Enum.TextYAlignment.Top

    return card
end

-- Reusable ON/OFF toggle
local function addToggle(labelText, settingKey, description)
    local row = create("Frame", {
        BackgroundColor3 = COLORS.Surface,
        Size = UDim2.new(1, 0, 0, description and 66 or 48)
    }, page)
    round(row, 10)
    stroke(row, COLORS.Border, 1, 0.5)

    local label = makeLabel(
        row, labelText, 12, COLORS.White, Enum.Font.GothamSemibold
    )
    label.Position = UDim2.fromOffset(12, description and 7 or 0)
    label.Size = UDim2.new(1, -90, 0, 24)

    if description then
        local detail = makeLabel(row, description, 9, COLORS.Muted)
        detail.Position = UDim2.fromOffset(12, 31)
        detail.Size = UDim2.new(1, -90, 0, 22)
    end

    local switch = create("TextButton", {
        AutoButtonColor = false,
        Text = "",
        Position = UDim2.new(1, -59, 0.5, -12),
        Size = UDim2.fromOffset(46, 24),
        BackgroundColor3 = COLORS.Border
    }, row)
    round(switch, 12)

    local knob = create("Frame", {
        BackgroundColor3 = COLORS.White,
        Position = UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(18, 18)
    }, switch)
    round(knob, 10)

    local function refresh(instant)
        local enabled = settings[settingKey] == true
        local targetColor = enabled and COLORS.Purple or COLORS.Border
        local targetPosition = enabled
            and UDim2.new(1, -21, 0, 3)
            or UDim2.fromOffset(3, 3)

        if instant then
            switch.BackgroundColor3 = targetColor
            knob.Position = targetPosition
        else
            tween(switch, 0.16, {
                BackgroundColor3 = targetColor
            })
            tween(knob, 0.16, {
                Position = targetPosition
            })
        end
    end

    switch.Activated:Connect(function()
        settings[settingKey] = not settings[settingKey]
        refresh(false)
        notify(labelText .. ": " ..
            (settings[settingKey] and "ON" or "OFF"))

        if settingKey == "NeonEffects" then
            neonLine.Visible = settings.NeonEffects
        end

        if settingKey == "ShowClock" and currentTab == "HOME" then
            -- Clock visibility is updated when HOME is rendered.
        end
    end)

    refresh(true)
    return row
end

-- Reusable slider
local function addSlider(labelText, settingKey, minValue, maxValue)
    local card = create("Frame", {
        BackgroundColor3 = COLORS.Surface,
        Size = UDim2.new(1, 0, 0, 76)
    }, page)
    round(card, 10)
    stroke(card, COLORS.Border, 1, 0.5)

    local label = makeLabel(
        card, labelText, 12, COLORS.White, Enum.Font.GothamSemibold
    )
    label.Position = UDim2.fromOffset(12, 7)
    label.Size = UDim2.new(1, -75, 0, 23)

    local valueLabel = makeLabel(
        card, tostring(settings[settingKey]), 11,
        COLORS.Cyan, Enum.Font.GothamBold
    )
    valueLabel.Position = UDim2.new(1, -60, 0, 7)
    valueLabel.Size = UDim2.fromOffset(48, 23)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    local bar = create("Frame", {
        BackgroundColor3 = COLORS.Border,
        Position = UDim2.new(0, 12, 0, 46),
        Size = UDim2.new(1, -24, 0, 7)
    }, card)
    round(bar, 5)

    local fill = create("Frame", {
        BackgroundColor3 = COLORS.Purple,
        Size = UDim2.new(0, 0, 1, 0)
    }, bar)
    round(fill, 5)

    local knob = create("Frame", {
        BackgroundColor3 = COLORS.Cyan,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(15, 15)
    }, bar)
    round(knob, 10)
    stroke(knob, COLORS.White, 1, 0.35)

    local function setValue(value)
        value = math.clamp(
            math.floor(value + 0.5),
            minValue,
            maxValue
        )

        settings[settingKey] = value
        local alpha = (value - minValue) / (maxValue - minValue)

        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        valueLabel.Text = tostring(value)
    end

    local draggingSlider = false

    local function updateFromInput(input)
        local width = bar.AbsoluteSize.X
        if width <= 0 then
            return
        end

        local alpha = math.clamp(
            (input.Position.X - bar.AbsolutePosition.X) / width,
            0, 1
        )

        setValue(minValue + alpha * (maxValue - minValue))
    end

    local hitArea = create("TextButton", {
        Name = "SliderInput",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 35),
        ZIndex = 5
    }, card)

    hitArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            updateFromInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not draggingSlider then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            updateFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)

    setValue(settings[settingKey])
    return card
end

-- Page renderers
local function renderHome()
    addSection("SYSTEM OVERVIEW")
    addCard(
        "PHANTOM OVERDRIVE",
        "Premium interface system for your own Roblox experience."
    )

    addCard(
        "PLAYER",
        "Welcome, " .. player.DisplayName .. ". Your UI is ready."
    )

    local clockCard = addCard("LOCAL SESSION CLOCK", "Loading clock...")
    local clockText = makeLabel(
        clockCard, "--:--:--", 15, COLORS.Cyan, Enum.Font.GothamBold
    )
    clockText.Position = UDim2.fromOffset(12, 34)
    clockText.Size = UDim2.new(1, -24, 0, 25)
    clockText.Visible = settings.ShowClock

    local clockConnection
    clockConnection = RunService.Heartbeat:Connect(function()
        if not clockCard.Parent then
            clockConnection:Disconnect()
            return
        end

        clockText.Visible = settings.ShowClock
        if settings.ShowClock then
            clockText.Text = os.date("%H:%M:%S")
        end
    end)

    addSection("QUICK CONTROLS")
    addToggle("Neon accent", "NeonEffects", "Toggle the cyan accent line.")
    addToggle("Notifications", "Notifications", "Enable or silence UI toasts.")
end

local function renderPlayer()
    addSection("PLAYER SETTINGS")

    addCard(
        "SAFE LOCAL SETTINGS",
        "These controls change this interface only. They do not modify other players."
    )

    addToggle(
        "Demo switch",
        "DemoToggle",
        "Example toggle for wiring your own game feature."
    )

    addSlider("Interface intensity", "Intensity", 0, 100)

    addSlider("UI transparency", "UITransparency", 0, 80)

    local applyButton = makeButton(
        page, "APPLY UI SETTINGS", UDim2.new(1, 0, 0, 39)
    )

    applyButton.Activated:Connect(function()
        local transparency = settings.UITransparency / 100
        main.BackgroundTransparency = transparency * 0.45
        notify(
            "Intensity " .. settings.Intensity ..
            "% | Transparency " .. settings.UITransparency .. "%",
            "SETTINGS APPLIED"
        )
    end)
end

local function renderVisual()
    addSection("VISUAL CUSTOMIZATION")

    addCard(
        "NEON ACCENT",
        "Control the accent strip at the top of the interface."
    )

    addToggle(
        "Neon effects",
        "NeonEffects",
        "Enable or disable the animated neon accent."
    )

    addToggle(
        "Show clock",
        "ShowClock",
        "Display or hide the HOME clock."
    )

    local colorButton = makeButton(
        page, "CYCLE ACCENT COLOR", UDim2.new(1, 0, 0, 40)
    )

    colorButton.Activated:Connect(function()
        if neonLine.BackgroundColor3 == COLORS.Cyan then
            neonLine.BackgroundColor3 = COLORS.Purple
            notify("Accent changed to purple.")
        else
            neonLine.BackgroundColor3 = COLORS.Cyan
            notify("Accent changed to cyan.")
        end
    end)
end

local function renderTools()
    addSection("TOOLS & UTILITIES")

    addCard(
        "INTERFACE CONTROL",
        "Use these tools to manage the panel and its appearance."
    )

    local toastButton = makeButton(
        page, "TEST NOTIFICATION", UDim2.new(1, 0, 0, 39)
    )

    toastButton.Activated:Connect(function()
        notify("All interface systems are responding.", "SYSTEM CHECK")
    end)

    local resetButton = makeButton(
        page, "RESET UI SETTINGS", UDim2.new(1, 0, 0, 39)
    )

    resetButton.Activated:Connect(function()
        settings.Notifications = true
        settings.NeonEffects = true
        settings.ShowClock = true
        settings.CompactMode = false
        settings.DemoToggle = false
        settings.Intensity = 50
        settings.UITransparency = 0

        main.BackgroundTransparency = 0
        neonLine.Visible = true
        neonLine.BackgroundColor3 = COLORS.Cyan

        if currentTab then
            local activeName = currentTab
            currentTab = nil
            local targetButton

            for _, tab in ipairs(tabs) do
                if tab.Name == activeName then
                    targetButton = tab.Button
                    break
                end
            end

            if targetButton then
                targetButton:Activate()
            end
        end

        notify("Default settings restored.", "RESET COMPLETE")
    end)

    local minimizeTool = makeButton(
        page, "MINIMIZE PANEL", UDim2.new(1, 0, 0, 39)
    )

    minimizeTool.Activated:Connect(function()
        minimizeButton:Activate()
    end)
end

local function renderInfo()
    addSection("PROJECT INFORMATION")

    addCard(
        "KING LOP 94",
        "PHANTOM OVERDRIVE | TRAN 3"
    )

    addCard(
        "BUILD",
        "Standalone Roblox LocalScript. No external UI libraries."
    )

    addCard(
        "INPUT SUPPORT",
        "Mouse, keyboard, touchscreen and responsive sizing."
    )

    addCard(
        "SAFETY",
        "UI demonstration only. Connect controls to authorized game systems."
    )

    local infoButton = makeButton(
        page, "SHOW SYSTEM STATUS", UDim2.new(1, 0, 0, 39)
    )

    infoButton.Activated:Connect(function()
        notify(
            "Interface running for " .. player.DisplayName,
            "PHANTOM STATUS"
        )
    end)
end

local renderers = {
    HOME = renderHome,
    PLAYER = renderPlayer,
    VISUAL = renderVisual,
    TOOLS = renderTools,
    INFO = renderInfo
}

local function selectTab(name)
    if not renderers[name] then
        return
    end

    currentTab = name
    clearPage()

    for _, tab in ipairs(tabs) do
        local selected = tab.Name == name
        tab.Button.BackgroundColor3 = selected
            and Color3.fromRGB(48, 36, 75)
            or COLORS.Surface

        local outline = tab.Button:FindFirstChildOfClass("UIStroke")
        if outline then
            outline.Color = selected and COLORS.Purple or COLORS.Border
            outline.Transparency = selected and 0 or 0.45
        end

        tab.Button.TextColor3 = selected and COLORS.Cyan or COLORS.White
    end

    renderers[name]()
    page.CanvasPosition = Vector2.new(0, 0)
end

-- Create navigation tabs
local homeTab = addTab("HOME", "⌂")
local playerTab = addTab("PLAYER", "◈")
local visualTab = addTab("VISUAL", "✧")
local toolsTab = addTab("TOOLS", "⚙")
local infoTab = addTab("INFO", "ⓘ")

homeTab.Activated:Connect(function()
    selectTab("HOME")
end)

playerTab.Activated:Connect(function()
    selectTab("PLAYER")
end)

visualTab.Activated:Connect(function()
    selectTab("VISUAL")
end)

toolsTab.Activated:Connect(function()
    selectTab("TOOLS")
end)

infoTab.Activated:Connect(function()
    selectTab("INFO")
end)

-- Drag window using mouse or touch
local draggingWindow = false
local dragInput = nil
local dragStart = nil
local startPosition = nil

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        draggingWindow = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingWindow = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingWindow and dragInput and input == dragInput then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Minimize and restore
local function setMinimized(state)
    minimized = state

    if minimized then
        content.Visible = false
        divider.Visible = false
        savedWindowSize = main.Size

        tween(main, 0.2, {
            Size = UDim2.new(0, savedWindowSize.X.Offset, 0, 76)
        })

        minimizeButton.Text = "+"
    else
        content.Visible = true
        divider.Visible = true

        tween(main, 0.2, {
            Size = savedWindowSize
        })

        minimizeButton.Text = "—"
    end
end

minimizeButton.Activated:Connect(function()
    setMinimized(not minimized)
end)

closeButton.Activated:Connect(function()
    windowClosed = true
    gui.Enabled = false
end)

-- Responsive sizing
local function updateResponsiveLayout()
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local viewport = camera.ViewportSize
    local isSmall = viewport.X < 650 or viewport.Y < 460

    if isSmall then
        local width = math.max(280, math.min(viewport.X - 20, 590))
        local height = math.max(260, math.min(viewport.Y - 35, 410))

        main.Size = UDim2.fromOffset(width, height)
        savedWindowSize = main.Size

        local sideWidth = width < 370 and 94 or 112
        sidebar.Size = UDim2.new(0, sideWidth, 1, 0)
        content.Position = UDim2.fromOffset(10, 82)
        content.Size = UDim2.new(1, -20, 1, -92)
        page.Position = UDim2.new(0, sideWidth + 10, 0, 0)
        page.Size = UDim2.new(1, -sideWidth - 10, 1, 0)

        for _, tab in ipairs(tabs) do
            tab.Button.TextSize = width < 370 and 9 or 10
        end

        title.TextSize = width < 370 and 13 or 15
        subtitle.TextSize = 9
    else
        main.Size = UDim2.fromOffset(590, 410)
        savedWindowSize = main.Size
        sidebar.Size = UDim2.new(0, 130, 1, 0)
        content.Position = UDim2.fromOffset(14, 84)
        content.Size = UDim2.new(1, -28, 1, -98)
        page.Position = UDim2.new(0, 142, 0, 0)
        page.Size = UDim2.new(1, -142, 1, 0)

        for _, tab in ipairs(tabs) do
            tab.Button.TextSize = 11
        end

        title.TextSize = 17
        subtitle.TextSize = 10
    end

    if minimized then
        main.Size = UDim2.new(0, savedWindowSize.X.Offset, 0, 76)
    end
end

local function connectCamera(camera)
    if not camera then
        return
    end

    camera:GetPropertyChangedSignal("ViewportSize"):Connect(
        updateResponsiveLayout
    )

    updateResponsiveLayout()
end

if workspace.CurrentCamera then
    connectCamera(workspace.CurrentCamera)
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    connectCamera(workspace.CurrentCamera)
end)

-- Animated neon accent
local neonClock = 0

RunService.RenderStepped:Connect(function(deltaTime)
    if not gui.Parent or not settings.NeonEffects then
        return
    end

    neonClock += deltaTime

    local alpha = (math.sin(neonClock * 1.7) + 1) / 2
    neonLine.BackgroundColor3 = COLORS.Cyan:Lerp(
        COLORS.Purple, alpha
    )
end)

-- Allow reopening after pressing close
local reopenButton = create("TextButton", {
    Name = "ReopenButton",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -16, 1, -16),
    Size = UDim2.fromOffset(112, 40),
    BackgroundColor3 = COLORS.Panel,
    Text = "✧ PHANTOM",
    TextColor3 = COLORS.Cyan,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    Visible = false
}, gui)
round(reopenButton, 12)
stroke(reopenButton, COLORS.Purple, 1.2, 0
