local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Debug = f
local Folder = Debug and game.ReplicatedStorage["shibas.cc"] or game:GetObjects("rbxassetid://8656054228")[1]
local function tween(object,property)
	local info = TweenInfo.new(
		0.2,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out
	)
	game:GetService("TweenService"):Create(object,info,property):Play()
end
local function tweenslider(object,property)
	local info = TweenInfo.new(
		0.08,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out
	)
	game:GetService("TweenService"):Create(object,info,property):Play()
end
local function tweendrag(object,property)
	local info = TweenInfo.new(
		0.1,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out
	)
	game:GetService("TweenService"):Create(object,info,property):Play()
end



local function MakeDraggable(ClickObject,Object)
	local ObjectPosition = UDim2.new(0,0,0,0)
	local StartPosition = Vector2.new(0,0)
	local Moving = false
	ClickObject.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			StartPosition = UserInputService:GetMouseLocation()
			ObjectPosition = Object.Position
			Moving = true
		end
	end)
	UserInputService.InputChanged:Connect(function(Input)
		if Moving and Input.UserInputType == Enum.UserInputType.MouseMovement then
			local Delta = UserInputService:GetMouseLocation() - StartPosition
			tweendrag(Object,{Position = UDim2.new(ObjectPosition.X.Scale, ObjectPosition.X.Offset + Delta.X, ObjectPosition.Y.Scale, ObjectPosition.Y.Offset + Delta.Y)})
		end
	end)
	ClickObject.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			ObjectPosition = UDim2.new(0,0,0,0)
			StartPosition = Vector2.new(0,0)
			Moving = false
		end
	end)
end

local function ChooseTabSide(Option,Tab)
	if Option == "Longest" then
		if Tab.Left.UIListLayout.AbsoluteContentSize.Y > Tab.Right.UIListLayout.AbsoluteContentSize.Y then
			return Tab.Left
		else
			return Tab.Right
		end
	elseif Option == "Left" then
		return Tab.Left
	elseif Option == "Right" then
		return Tab.Right
	else
		if Tab.Left.UIListLayout.AbsoluteContentSize.Y > Tab.Right.UIListLayout.AbsoluteContentSize.Y then
			return Tab.Right
		else
			return Tab.Left
		end
	end
end

local function ChooseTab(Screen,Tab,TabButton)
	for Index, Element in pairs(Screen:GetChildren()) do
		if Element.Name == "ColorPicker" then
			Element.Visible = false
		end
	end
	for Index, LocalTab in pairs(Screen.Main.Content:GetChildren()) do
		if LocalTab:IsA("ScrollingFrame") then
			LocalTab.Visible = true
			if LocalTab ~= Tab then
				LocalTab.Visible = false
			end
		end
	end
	for Index, LocalTabButton in pairs(Screen.Main.Navigation.Holder:GetChildren()) do
		if LocalTabButton:IsA("TextButton") then
			if LocalTabButton ~= TabButton then
				tween(LocalTabButton,{BackgroundColor3 = Color3.fromRGB(46, 46, 46)})
				tween(LocalTabButton,{TextColor3 = Color3.fromRGB(173, 173, 173)})
				-- unSelected tab
			else
				tween(LocalTabButton,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
				tween(LocalTabButton,{TextColor3 = Color3.fromRGB(247,247,247)})
				-- Selected tab
			end
		end
	end
end

return function() local Window = {TabSelected = nil,RainbowHue = 0}
	local LocalScreen = Folder.Screen:Clone()
	if syn then
		syn.protect_gui(LocalScreen)
	end
	LocalScreen.Parent = Debug and game.Players.LocalPlayer.PlayerGui or game:GetService("CoreGui")
	-- fancy animations for loader and then

	
	MakeDraggable(LocalScreen.Main.Navigation,LocalScreen.Main)
	MakeDraggable(LocalScreen.Main.Title,LocalScreen.Main)
	UserInputService.InputBegan:Connect(function(key,typing)
		if not typing then
			if key.KeyCode == Enum.KeyCode.RightAlt then
				LocalScreen.Main.Visible = not LocalScreen.Main.Visible
			end
		end
	end)
	LocalScreen.Main.Navigation.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		LocalScreen.Main.Navigation.Holder.CanvasSize = UDim2.new(0,LocalScreen.Main.Navigation.Holder.UIListLayout.AbsoluteContentSize.X,0,0)
		if LocalScreen.Main.Navigation.Holder.UIListLayout.AbsoluteContentSize.X > 340 then
			LocalScreen.Main.Navigation.Holder.AutomaticCanvasSize = Enum.AutomaticSize.None
		else
			LocalScreen.Main.Navigation.Holder.AutomaticCanvasSize = Enum.AutomaticSize.X
		end
	end)
	RunService.Heartbeat:Connect(function()
		if Window.RainbowHue < 1 then
			Window.RainbowHue  = Window.RainbowHue + 0.001
		else
			Window.RainbowHue = 0
		end
	end)
	
	function Window:CreateTab(Name) local Tab = {}
		local LocalTab = Folder.Tab:Clone()
		LocalTab.Parent = LocalScreen.Main.Content
		LocalTab.Visible = false
		local LocalTabButton = Folder.TabButton:Clone()
		LocalTabButton.Parent = LocalScreen.Main.Navigation.Holder
		LocalTabButton.Text = Name
		LocalTabButton.Size = UDim2.new(0,LocalTabButton.TextBounds.X + 10,1,0)
		
		LocalTab.Left.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if ChooseTabSide("Longest", LocalTab) == LocalTab.Left then
				LocalTab.CanvasSize = UDim2.new(0,0,0,LocalTab.Left.UIListLayout.AbsoluteContentSize.Y + 10)
			else
				LocalTab.CanvasSize = UDim2.new(0,0,0,LocalTab.Right.UIListLayout.AbsoluteContentSize.Y + 10)
			end
		end)
		LocalTab.Right.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if ChooseTabSide("Longest", LocalTab) == LocalTab.Left then
				LocalTab.CanvasSize = UDim2.new(0,0,0,LocalTab.Left.UIListLayout.AbsoluteContentSize.Y + 10)
			else
				LocalTab.CanvasSize = UDim2.new(0,0,0,LocalTab.Right.UIListLayout.AbsoluteContentSize.Y + 10)
			end
		end)
		LocalTabButton.MouseButton1Click:Connect(function()
			Window.TabSelected = LocalTab
			ChooseTab(LocalScreen,LocalTab,LocalTabButton)
		end)
		LocalTabButton.MouseEnter:Connect(function()
			tween(LocalTabButton,{TextColor3 = Window.TabSelected == LocalTab and Color3.fromRGB(247,247,247) or Color3.fromRGB(247, 166, 236)})
		end)
		LocalTabButton.MouseLeave:Connect(function()
			tween(LocalTabButton,{TextColor3 = Window.TabSelected == LocalTab and Color3.fromRGB(247,247,247) or Color3.fromRGB(173, 173, 173)})
		end)
		if #LocalScreen.Main.Content:GetChildren() == 2 then
			Window.TabSelected = LocalTab
			ChooseTab(LocalScreen,LocalTab,LocalTabButton)
		end
		
		function Tab:CreateSection(Name,Default,TabSide) local Section = {Toggled = Default,Size = nil}
			local LocalSection = Folder.Section:Clone()
			LocalSection.Parent = ChooseTabSide(TabSide,LocalTab)
			LocalSection.Label.Text = Name
			if Default == nil then Section.Toggled = true end
			
			local function checkToggle()
				Section.Size = UDim2.new(1,0,0,LocalSection.SectionContent.UIListLayout.AbsoluteContentSize.Y + 36)
				if Section.Toggled then
					if LocalSection.SectionContent.UIListLayout.AbsoluteContentSize.Y ~= 0 then
						tween(LocalSection.openclose,{Rotation = 0})
						tween(LocalSection,{Size = Section.Size})
					else
						tween(LocalSection.openclose,{Rotation = 90})
						tween(LocalSection,{Size = UDim2.new(1,0,0,26)})
					end
				else
					tween(LocalSection.openclose,{Rotation = 90})
					tween(LocalSection,{Size = UDim2.new(1,0,0,26)})
				end
			end
			checkToggle()
			LocalSection.openclose.MouseEnter:Connect(function()
				tween(LocalSection.openclose,{ImageColor3 = Color3.fromRGB(247, 166, 236)})
			end)
			LocalSection.openclose.MouseLeave:Connect(function()
				tween(LocalSection.openclose,{ImageColor3 = Color3.fromRGB(173, 173, 173)})
			end)
			LocalSection.SectionContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Size = UDim2.new(1,0,0,LocalSection.SectionContent.UIListLayout.AbsoluteContentSize.Y + 36)
				checkToggle()
			end)
			
			LocalSection.openclose.MouseButton1Click:Connect(function()
				Section.Toggled = not Section.Toggled
				checkToggle()
			end)
			
			function Section:CreateButton(Name, Callback) local Button = {Hovered = false}
				local LocalButton = Folder.Button:Clone()
				LocalButton.Parent = LocalSection.SectionContent
				LocalButton.Title.Text = Name
				
				LocalButton.MouseButton1Click:Connect(function()
					Callback()
				end)
				LocalButton.MouseButton1Down:Connect(function()
					tween(LocalButton,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
					tween(LocalButton.icon,{ImageColor3 = Color3.fromRGB(247, 247, 247)})
					tween(LocalButton.Title,{TextColor3 = Color3.fromRGB(247, 247, 247)})
				end)
				LocalButton.MouseButton1Up:Connect(function()
					tween(LocalButton,{BackgroundColor3 = Color3.fromRGB(46, 46, 46)})
					if Button.Hovered then
						tween(LocalButton.icon,{ImageColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalButton.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
					else
						tween(LocalButton.icon,{ImageColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalButton.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
					end
				end)
				LocalButton.MouseEnter:Connect(function()
					Button.Hovered = true
					tween(LocalButton.icon,{ImageColor3 = Color3.fromRGB(247, 166, 236)})
					tween(LocalButton.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
				end)
				LocalButton.MouseLeave:Connect(function()
					Button.Hovered = false
					tween(LocalButton,{BackgroundColor3 = Color3.fromRGB(46, 46, 46)})
					tween(LocalButton.icon,{ImageColor3 = Color3.fromRGB(173, 173, 173)})
					tween(LocalButton.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
				end)
				return Button
			end
			function Section:CreateTextBox(Text,PlaceHolder,NumbersOnly,Callback) local TextBox = {Focused = false}
				local LocalTextBox = Folder.TextBox:Clone()
				LocalTextBox.Parent = LocalSection.SectionContent
				LocalTextBox.InputFrame.Input.Text = Text or ""
				LocalTextBox.InputFrame.Input.PlaceholderText = PlaceHolder or "Text here..."
				if NumbersOnly == nil then NumbersOnly = false end
				LocalTextBox.InputFrame.Input.FocusLost:Connect(function()
					TextBox.Focused = false
					tween(LocalTextBox.InputFrame.UIStroke,{Transparency = 1})
					tween(LocalTextBox.icon,{ImageColor3 = Color3.fromRGB(173, 173, 173)})
					if NumbersOnly and tonumber(LocalTextBox.InputFrame.Input.Text) then
						Callback(tonumber(LocalTextBox.InputFrame.Input.Text))
						--LocalTextbox.Background.Input.Text = ""
					elseif NumbersOnly and not tonumber(LocalTextBox.InputFrame.Input.Text) then
						LocalTextBox.Background.Input.Text = ""
					else
						Callback(LocalTextBox.InputFrame.Input.Text)
						--LocalTextbox.Background.Input.Text = ""
					end
				end)
				LocalTextBox.InputFrame.Input.Focused:Connect(function()
					TextBox.Focused = true
					tween(LocalTextBox.icon,{ImageColor3 = Color3.fromRGB(247, 166, 236)})
					tween(LocalTextBox.InputFrame.UIStroke,{Transparency = 0})
				end)
				--[[
				LocalTextBox.MouseEnter:Connect(function()
					tween(LocalTextBox.icon,{ImageColor3 = TextBox.Focused and Color3.fromRGB(173, 173, 173) or Color3.fromRGB(247, 166, 236)})
					tween(LocalTextBox.InputFrame.UIStroke,{Transparency = TextBox.Focused and 1 or 0})
				end)
				LocalTextBox.MouseLeave:Connect(function()
					tween(LocalTextBox.icon,{ImageColor3 = TextBox.Focused and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
					tween(LocalTextBox.InputFrame.UIStroke,{Transparency = TextBox.Focused and 1 or 0})
				end)
				]]
				return TextBox
			end
			function Section:CreateToggle(Name,Default,Callback) local Toggle = {Toggled = Default,Hovered = false}
				local LocalToggle = Folder.Toggle:Clone()
				LocalToggle.Parent = LocalSection.SectionContent
				LocalToggle.Title.Text = Name
				if Default == nil then Toggle.Toggled = false end
				
				local function setVisual(State)
					if State then
						tween(LocalToggle.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalToggle.ToggleBack.Clickable,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalToggle.ToggleBack.Clickable,{Position = UDim2.new(0,13,0,0)})
					else
						tween(LocalToggle.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalToggle.ToggleBack.Clickable,{BackgroundColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalToggle.ToggleBack.Clickable,{Position = UDim2.new(0,0,0,0)})
					end
				end
				setVisual(Default)
				LocalToggle.MouseButton1Click:Connect(function()
					Toggle.Toggled = not Toggle.Toggled
					Callback(Toggle.Toggled)
					setVisual(Toggle.Toggled)
				end)
				LocalToggle.MouseEnter:Connect(function()
					Toggle.Hovered = true
					tween(LocalToggle.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
				end)
				LocalToggle.MouseLeave:Connect(function()
					Toggle.Hovered = false
					tween(LocalToggle.Title,{TextColor3 = Toggle.Toggled and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
				end)
				
				function Toggle:CreateKeybind(Key,Mouse,Callback,Blacklist) local Keybind = {WaitingForBind = false}
					local LocalKeybind = LocalToggle.Indicator
					LocalKeybind.Visible = true
					LocalKeybind.Text = Key
					LocalKeybind.Size = UDim2.new(0,LocalKeybind.TextBounds.X + 10,0,14)
					if Blacklist == nil then Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"} end

					LocalKeybind.MouseButton1Click:Connect(function()
						Keybind.WaitingForBind = true
						LocalKeybind.Text = "?"
						tween(LocalKeybind,{Size = UDim2.new(0,14,0,14)})
						tween(LocalKeybind.UIStroke,{Transparency = 0})
						tween(LocalKeybind,{TextColor3 = Color3.fromRGB(247, 166, 236)})
					end)
					UserInputService.InputBegan:Connect(function(Input)
						if Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.Keyboard then
							local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
							if not table.find(Blacklist, Key2) then
								LocalKeybind.Text = Key2
								--LocalKeybind.Size = UDim2.new(0,14,0,14)
								tween(LocalKeybind,{Size = UDim2.new(0,LocalKeybind.TextBounds.X + 10,0,14)})
								tween(LocalKeybind.UIStroke,{Transparency = 1})
								tween(LocalKeybind,{TextColor3 = Color3.fromRGB(173, 173, 173)})
								Key = Key2
							else
								LocalKeybind.Text = "NONE"
								--LocalKeybind.Size = UDim2.new(0,14,0,14)
								tween(LocalKeybind,{Size = UDim2.new(0,LocalKeybind.TextBounds.X + 10,0,14)})
								tween(LocalKeybind.UIStroke,{Transparency = 1})
								tween(LocalKeybind,{TextColor3 = Color3.fromRGB(173, 173, 173)})
								Key = nil
							end
							Keybind.WaitingForBind = false
							Callback(false, Key)
						elseif Input.UserInputType == Enum.UserInputType.Keyboard then
							local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
							if Key2 == Key then
								Toggle.Toggled = not Toggle.Toggled
								Callback(Toggle.Toggled,Key)
								setVisual(Toggle.Toggled)
							end
						end
						if Mouse then
							if Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton1 or Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton2 or Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton3 then
								local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
								LocalKeybind.Text = Key2
								tween(LocalKeybind,{Size = UDim2.new(0,LocalKeybind.TextBounds.X + 10,0,14)})
								tween(LocalKeybind.UIStroke,{Transparency = 1})
								tween(LocalKeybind,{TextColor3 = Color3.fromRGB(173, 173, 173)})
								Key = Key2
								Keybind.WaitingForBind = false
								Callback(false, Key)
							elseif Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.MouseButton3 then
								local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
								if Key2 == Key then
									Toggle.Toggled = not Toggle.Toggled
									Callback(Toggle.Toggled,Key)
									setVisual(Toggle.Toggled)
								end
							end
						end
					end)
					--[[
					UserInputService.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.Keyboard then
							local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
							if Key2 == Key then
								Callback(false, Key)
							end
						end
						if Mouse then
							if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.MouseButton3 then
								local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
								if Key2 == Key then
									Callback(false, Key)
								end
							end
						end
					end)
					]]
					return Keybind
				end
					
				return Toggle
			end
			function Section:CreateSlider(Name,Min,Max,Default,Precise,Callback) local Slider = {Value = Default or Min / Max,Active = false,Hovered = false}
				local LocalSlider = Folder.Slider:Clone()
				LocalSlider.Parent = LocalSection.SectionContent
				LocalSlider.Title.Text = Name
				Slider.Value = string.format("%." .. Precise .. "f", Slider.Value)
				LocalSlider.Value.Text = Slider.Value
				tween(LocalSlider.SliderHolder.SliderFiller,{Size = UDim2.new((Slider.Value - Min) / (Max - Min),0,1,0)})
				
				local function ChangeValue(Value)
					Slider.Value = tonumber(string.format("%." .. Precise .. "f", Value))
					tweenslider(LocalSlider.SliderHolder.SliderFiller,{Size = UDim2.new((Slider.Value - Min) / (Max - Min),0,1,0)})
					LocalSlider.Value.Text = Slider.Value
					Callback(Slider.Value)
				end
local function AttachToMouse(Input)
    local XScale = math.clamp((Input.Position.X - LocalSlider.SliderHolder.AbsolutePosition.X) / LocalSlider.SliderHolder.AbsoluteSize.X,0,1)
    --local SliderPrecise = ((XScale * Max) / Max) * (Max - Min) + Min
    local SliderPrecise = math.clamp(XScale * (Max - Min) + Min,Min,Max)
    ChangeValue(SliderPrecise)
end
				LocalSlider.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						tween(LocalSlider.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalSlider.Value,{TextColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalSlider.SliderHolder.SliderFiller.Dot.Expand,{Transparency = 0.7})
						tween(LocalSlider.SliderHolder.SliderFiller.Dot.Expand,{Size = UDim2.new(2,-2,2,-2)})
						AttachToMouse(Input)
						Slider.Active = true
					end
				end)
				LocalSlider.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						tween(LocalSlider.Title,{TextColor3 = Slider.Hovered and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
						tween(LocalSlider.Value,{TextColor3 = Slider.Hovered and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
						tween(LocalSlider.SliderHolder.SliderFiller.Dot.Expand,{Transparency = 1})
						tween(LocalSlider.SliderHolder.SliderFiller.Dot.Expand,{Size = UDim2.new(0,0,0,0)})
						Slider.Active = false
					end
				end)
				UserInputService.InputChanged:Connect(function(Input)
					if Slider.Active and Input.UserInputType == Enum.UserInputType.MouseMovement then
						AttachToMouse(Input)
					end
				end)
				LocalSlider.MouseEnter:Connect(function()
					Slider.Hovered = true
					tween(LocalSlider.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
					tween(LocalSlider.Value,{TextColor3 = Color3.fromRGB(247, 166, 236)})
				end)
				LocalSlider.MouseLeave:Connect(function()
					Slider.Hovered = false
					tween(LocalSlider.Title,{TextColor3 = Slider.Active and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
					tween(LocalSlider.Value,{TextColor3 = Slider.Active and Color3.fromRGB(247, 166, 236) or Color3.fromRGB(173, 173, 173)})
				end)
				return Slider
			end
			function Section:CreateKeybind(Name,Key,Mouse,Callback,Blacklist) local Keybind = {WaitingForBind = false,Key = nil}
				local LocalKeybind = Folder.Keybind:Clone()
				LocalKeybind.Parent = LocalSection.SectionContent
				LocalKeybind.Title.Text = Name
				LocalKeybind.Indicator.Text = Key
				LocalKeybind.Indicator.Size = UDim2.new(0,LocalKeybind.Indicator.TextBounds.X + 10,0,14)
				if Blacklist == nil then Blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"} end
				
				LocalKeybind.MouseButton1Click:Connect(function()
					Keybind.WaitingForBind = true
					LocalKeybind.Indicator.Text = "?"
					tween(LocalKeybind.Indicator,{Size = UDim2.new(0,14,0,14)})
					tween(LocalKeybind.Indicator.UIStroke,{Transparency = 0})
					tween(LocalKeybind.Indicator,{TextColor3 = Color3.fromRGB(247, 166, 236)})
				end)
				UserInputService.InputBegan:Connect(function(Input)
					if Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.Keyboard then
						local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
						if not table.find(Blacklist, Key2) then
							LocalKeybind.Indicator.Text = Key2
							--LocalKeybind.Indicator.Size = UDim2.new(0,14,0,14)
							tween(LocalKeybind.Indicator,{Size = UDim2.new(0,LocalKeybind.Indicator.TextBounds.X + 10,0,14)})
							tween(LocalKeybind.Indicator.UIStroke,{Transparency = 1})
							tween(LocalKeybind.Indicator,{TextColor3 = Color3.fromRGB(173, 173, 173)})
							Key = Key2
						else
							LocalKeybind.Indicator.Text = "NONE"
							--LocalKeybind.Indicator.Size = UDim2.new(0,14,0,14)
							tween(LocalKeybind.Indicator,{Size = UDim2.new(0,LocalKeybind.Indicator.TextBounds.X + 10,0,14)})
							tween(LocalKeybind.Indicator.UIStroke,{Transparency = 1})
							tween(LocalKeybind.Indicator,{TextColor3 = Color3.fromRGB(173, 173, 173)})
							Key = nil
						end
						Keybind.WaitingForBind = false
						Callback(false, Key)
					elseif Input.UserInputType == Enum.UserInputType.Keyboard then
						local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
						if Key2 == Key then
							Callback(true, Key)
						end
					end
					if Mouse then
						if Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton1 or Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton2 or Keybind.WaitingForBind and Input.UserInputType == Enum.UserInputType.MouseButton3 then
							local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
							LocalKeybind.Indicator.Text = Key2
							tween(LocalKeybind.Indicator,{Size = UDim2.new(0,LocalKeybind.Indicator.TextBounds.X + 10,0,14)})
							tween(LocalKeybind.Indicator.UIStroke,{Transparency = 1})
							tween(LocalKeybind.Indicator,{TextColor3 = Color3.fromRGB(173, 173, 173)})
							Key = Key2
							Keybind.WaitingForBind = false
							Callback(false, Key)
						elseif Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.MouseButton3 then
							local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
							if Key2 == Key then
								Callback(true, Key)
							end
						end
					end
				end)
				UserInputService.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.Keyboard then
						local Key2 = tostring(Input.KeyCode):gsub("Enum.KeyCode.", "")
						if Key2 == Key then
							Callback(false, Key)
						end
					end
					if Mouse then
						if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseButton2 or Input.UserInputType == Enum.UserInputType.MouseButton3 then
							local Key2 = tostring(Input.UserInputType):gsub("Enum.UserInputType.", "")
							if Key2 == Key then
								Callback(false, Key)
							end
						end
					end
				end)
				
				return Keybind
			end
			function Section:CreateDropdown(Name,List,Default,Callback) local Dropdown = {Toggled = false,Selected = nil}
				local LocalDropdown = Folder.Dropdown:Clone()
				LocalDropdown.Parent = LocalSection.SectionContent
				LocalDropdown.Title.Text =  Name
				
				LocalDropdown.openclose.MouseButton1Click:Connect(function()
					Dropdown.Toggled = not Dropdown.Toggled
					if Dropdown.Toggled then
						if LocalDropdown.ItemHolder.UIListLayout.AbsoluteContentSize.Y ~= 0 then
							tween(LocalDropdown.openclose,{ImageColor3 = Color3.fromRGB(247, 166, 236)})
							tween(LocalDropdown.openclose,{Rotation = 0})
							tween(LocalDropdown.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
							tween(LocalDropdown,{Size = UDim2.new(1,0,0,LocalDropdown.ItemHolder.UIListLayout.AbsoluteContentSize.Y + 25)})
						end
					else
						tween(LocalDropdown.openclose,{ImageColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalDropdown.openclose,{Rotation = 90})
						tween(LocalDropdown.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalDropdown,{Size = UDim2.new(1,0,0,20)})
					end
				end)
				
				local function resetSelected()
					for Index,Value in pairs(LocalDropdown.ItemHolder:GetChildren()) do
						if Value:IsA("TextButton") and Value.Text ~= Dropdown.Selected then
							tween(Value,{BackgroundColor3 = Color3.fromRGB(38, 38, 38)})
							tween(Value,{TextColor3 = Color3.fromRGB(173, 173, 173)})
						end
					end
				end
				
				if List then
					for Index,Value in pairs(List) do
						local LocalItem = Folder.Item:Clone()
						LocalItem.Parent = LocalDropdown.ItemHolder
						LocalItem.Text = Value
						LocalItem.MouseButton1Click:Connect(function()
							Dropdown.Selected = Value
							resetSelected()
							LocalDropdown.Title.Text = Name .. " - " .. Value
							tween(LocalItem,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
							tween(LocalItem,{TextColor3 = Color3.fromRGB(247, 247, 247)})
							Callback(Value)
						end)
					end
				end
				if Default then
					for Index,Value in pairs(LocalDropdown.ItemHolder:GetChildren()) do
						if Value:IsA("TextButton") and Value.Text == Default then
							Dropdown.Selected = Default
							LocalDropdown.Title.Text = Name .. " - " .. Default
							tween(Value,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
							tween(Value,{TextColor3 = Color3.fromRGB(247, 247, 247)})
						end
					end
				end
				function Dropdown:Update(Table)
					for Index,Value in pairs(LocalDropdown.ItemHolder:GetChildren()) do
						if Value:IsA("TextButton") then
							Value:Destroy()
						end
					end
					for Index,Value in pairs(List) do
						local LocalItem = Folder.Item:Clone()
						LocalItem.Parent = LocalDropdown.ItemHolder
						LocalItem.Text = Value
						LocalItem.MouseButton1Click:Connect(function()
							Dropdown.Selected = Value
							resetSelected()
							LocalDropdown.Title.Text = Name .. " - " .. Value
							tween(LocalItem,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
							tween(LocalItem,{TextColor3 = Color3.fromRGB(247, 247, 247)})
							Callback(Value)
						end)
					end
				end
				return Dropdown
			end
			function Section:CreateColorPicker(Name,Color,Callback) local ColorPicker = {Toggled = false}
				local LocalColorPicker = Folder.ColorPicker:Clone()
				LocalColorPicker.Parent = LocalSection.SectionContent
				LocalColorPicker.Title.Text = Name
				local PickerRender = nil
				local HueRender = nil
				local Hue, Saturation, Value = Color:ToHSV()
				local HSV = {
					Hue = Hue,
					Saturation = Saturation,
					Value = Value
				}
				
				local function Update()
					LocalColorPicker.icon.ImageColor3 = Color
					LocalColorPicker.picker.PickerArea.BackgroundColor3 = Color3.fromHSV(HSV.Hue,1,1)
					LocalColorPicker.picker.PickerArea.Value.Position = UDim2.new(HSV.Saturation,0,1-HSV.Value,0)
					LocalColorPicker.picker.HueArea.Value.Position = UDim2.new(0.5,0,1-HSV.Hue,0)
					LocalColorPicker.picker.R.PlaceholderText = math.round(Color.R * 255)
					LocalColorPicker.picker.G.PlaceholderText = math.round(Color.G * 255)
					LocalColorPicker.picker.B.PlaceholderText = math.round(Color.B * 255)
					Callback(Color)
				end
				Update()
				LocalColorPicker.MouseButton1Click:Connect(function()
					ColorPicker.Toggled = not ColorPicker.Toggled
					if ColorPicker.Toggled then
						tween(LocalColorPicker,{Size = UDim2.new(1,0,0,195)})
					else
						tween(LocalColorPicker,{Size = UDim2.new(1,0,0,20)})
					end
				end)
				LocalColorPicker.picker.PickerArea.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if PickerRender then
							PickerRender:Disconnect()
						end
						PickerRender = RunService.RenderStepped:Connect(function()
							if not LocalColorPicker.Visible then PickerRender:Disconnect() end
							local Mouse = UserInputService:GetMouseLocation()
							local ColorX = math.clamp(Mouse.X - LocalColorPicker.picker.PickerArea.AbsolutePosition.X, 0, LocalColorPicker.picker.PickerArea.AbsoluteSize.X) / LocalColorPicker.picker.PickerArea.AbsoluteSize.X
							local ColorY = math.clamp((Mouse.Y - 37) - LocalColorPicker.picker.PickerArea.AbsolutePosition.Y, 0, LocalColorPicker.picker.PickerArea.AbsoluteSize.Y) / LocalColorPicker.picker.PickerArea.AbsoluteSize.Y
							LocalColorPicker.picker.PickerArea.Value.Position = UDim2.new(ColorX,0,ColorY,0)
							HSV.Saturation = ColorX
							HSV.Value = 1 - ColorY
							Color = Color3.fromHSV(HSV.Hue,HSV.Saturation,HSV.Value)
							Update()
						end)
					end
				end)
				LocalColorPicker.picker.PickerArea.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if PickerRender then
							PickerRender:Disconnect()
						end
					end
				end)
				LocalColorPicker.picker.HueArea.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueRender then
							HueRender:Disconnect()
						end
						HueRender = RunService.RenderStepped:Connect(function()
							if not LocalColorPicker.Visible then HueRender:Disconnect() end
							local Mouse = UserInputService:GetMouseLocation()
							local ColorX = math.clamp((Mouse.Y - 37) - LocalColorPicker.picker.HueArea.AbsolutePosition.Y, 0, LocalColorPicker.picker.HueArea.AbsoluteSize.Y) / LocalColorPicker.picker.HueArea.AbsoluteSize.Y
							LocalColorPicker.picker.HueArea.Value.Position = UDim2.new(ColorX,0,0.5,0)
							HSV.Hue = 1 - ColorX
							Color = Color3.fromHSV(HSV.Hue,HSV.Saturation,HSV.Value)
							Update()
						end)
					end
				end)
				LocalColorPicker.picker.HueArea.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueRender then
							HueRender:Disconnect()
						end
					end
				end)
				LocalColorPicker.picker.PickBtn.MouseButton1Click:Connect(function()
					Color = Color3.fromRGB(LocalColorPicker.R.Text,LocalColorPicker.G.Text,LocalColorPicker.B.Text)
					Hue, Saturation, Value = Color:ToHSV()
					HSV = {
						Hue = Hue,
						Saturation = Saturation,
						Value = Value
					}
					Update()
				end)
				LocalColorPicker.MouseEnter:Connect(function()
					tween(LocalColorPicker.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
				end)
				LocalColorPicker.MouseLeave:Connect(function()
					tween(LocalColorPicker.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
				end)
				
				local RainbowToggle = false
				LocalColorPicker.picker.RToggle.MouseButton1Click:Connect(function()
					RainbowToggle = not RainbowToggle
					if RainbowToggle then
						tween(LocalColorPicker.picker.RToggle.Title,{TextColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalColorPicker.picker.RToggle.ToggleBack.Clickable,{BackgroundColor3 = Color3.fromRGB(247, 166, 236)})
						tween(LocalColorPicker.picker.RToggle.ToggleBack.Clickable,{Position = UDim2.new(0,13,0,0)})
					else
						tween(LocalColorPicker.picker.RToggle.Title,{TextColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalColorPicker.picker.RToggle.ToggleBack.Clickable,{BackgroundColor3 = Color3.fromRGB(173, 173, 173)})
						tween(LocalColorPicker.picker.RToggle.ToggleBack.Clickable,{Position = UDim2.new(0,0,0,0)})
					end
				end)
				RunService.Heartbeat:Connect(function()
					if RainbowToggle then
						if ColorPicker.Toggled then
							Color = Color3.fromHSV(Window.RainbowHue,1,1)
							Hue, Saturation, Value = Color:ToHSV()
							HSV = {
								Hue = Hue,
								Saturation = Saturation,
								Value = Value
							}
							Update()
						else
							Color = Color3.fromHSV(Window.RainbowHue,1,1)
							Hue, Saturation, Value = Color:ToHSV()
							HSV = {
								Hue = Hue,
								Saturation = Saturation,
								Value = Value
							}
							
							LocalColorPicker.icon.ImageColor3 = Color
							Callback(Color)
						end
					end
				end)
				
				return ColorPicker
			end
			return Section
		end
		return Tab
	end
	return Window
end
