local map = {
	["3200010305"] = "bs",
	["2797881676"] = "finan",
	["2625195454"] = "depo",
	["3590667014"] = "lh",
	["2951213182"] = "wd",
	["4518266946"] = "sci",
	["4661507759"] = "scrs",
	["4768829954"] = "bd",
	["2215221144"] = "kh",
	["4134003540"] = "auc",
	["3925577908"] = "gala",
	["4388762338"] = "cac",
	["5071816792"] = "set",
	["5188855685"] = "lock",
	["5862433299"] = "score",
	["7799530284"] = "cc"
}

local specialNPCs = {
	["SC Commander"] = Color3.new(0.5, 0.5, 1),
	["Falcon"] = Color3.new(0.5, 0.5, 1),
	["Rivera"] = Color3.new(1, 0.5, 0.5),
	["Jade"] = Color3.new(1, 0.5, 0.5),
	["Manager"] = Color3.new(0.5, 0.5, 1),
	["Auctioneer"] = Color3.new(0.5, 0.5, 1),
	["Civilian"] = Color3.new(1, 1, 1),
	["Ryan"] = Color3.new(0.5, 0.5, 1),
	["Elite Operative"] = Color3.new(0, 0, 0),
	["Janitor"] = Color3.new(1, 1, 1),
	["Employee"] = Color3.new(1, 1, 1),
	["Tech"] = Color3.new(0.5, 0.5, 0.5),
	["Analyst"] = Color3.new(1, 1, 1),
	["Rose"] = Color3.new(0.25, 0, 0),
	["SWAT"] = Color3.new(0, 0, 0),
	["TRU"] = Color3.new(0, 0, 0),
	["ETF"] = Color3.new(0, 0, 0),
	["SC Soldier"] = Color3.new(0, 0, 0),
	["SC Shredder"] = Color3.new(0.5, 0.5, 0.5),
	["Juggernaut"] = Color3.new(0.5, 0.5, 0.5),
	["ETF Aegis"] = Color3.new(0.5, 0.5, 0.5),
	["TRU Aegis"] = Color3.new(0.5, 0.5, 0.5),
	["Aegis Unit"] = Color3.new(0.5, 0.5, 0.5)
}
local police = {
	["Police"] = Color3.new(1, 0.5, 0.5),
}
local operative = {
	["Halcyon Operative"] = Color3.new(0, 0, 0)
}

map = map[tostring(game.PlaceId)]


local _2ics = {
	["Halcyon Operative"] = Color3.new(0.5, 1, 0.5),
	["Phoenix Operative"] = Color3.new(0.5, 1, 0.5),
	["Programmer"] = Color3.new(1, 1, 0.5),
	["Workshop Tech"] = Color3.new(1, 0.5, 0),
	["Tech"] = Color3.new(1, 0.5, 0),
	["Agent Hemlock"] = Color3.new(0.5, 1, 0.5),
	["Agent Nightshade"] = Color3.new(0.5, 1, 0.5),
	["SC Guard"] = Color3.new(0.5, 1, 0.5)
}

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

local HeadOff = Vector3.new(0, 0.5, 0)
local LegOff = Vector3.new(0, 3, 0)

for i, v in pairs(game.Workspace.Level.Actors:GetChildren()) do
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = Color3.new(0, 0, 0)
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false
	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = Color3.new(1, 0.5, 0.5)
	Box.Thickness = 1
	Box.Transparency = 1
	Box.Filled = false
	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if v:FindFirstChild("Character") and v.Character:FindFirstChild("Humanoid").Health > 0 then
				local Vector, onScreen = camera:worldToViewportPoint(v:FindFirstChild("Character"):FindFirstChild("HumanoidRootPart")
					.Position)
				local RootPart = v.Character.HumanoidRootPart
				local Head = v.Character:FindFirstChild("Head")
				local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
				local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
				local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)
				if onScreen then
					BoxOutline.Size = Vector2.new(2000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
					BoxOutline.Visible = true
					Box.Size = Vector2.new(2000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
					Box.Visible = true
					local isSpecial = specialNPCs[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value
						]
					local isPolice = police[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					local isOperative = operative[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value
						]
					if isSpecial and (not v.Character.Inventory:FindFirstChild("KeycardHS") or isSpecial == Color3.new(0.5, 0.5, 1)) then
						Box.Color = isSpecial
					elseif v.Character.Inventory:FindFirstChild("KeycardHS") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					elseif v.Character.Inventory:FindFirstChild("KeycardBlue") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
						if string.find(v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value, "Agent") and
							v.Character.Inventory:FindFirstChild("USB") then
							Box.Color = Color3.new(0.5, 0.5, 1)
						end
					elseif v.Character.Inventory:FindFirstChild("KeycardRed") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					end
					if isPolice then
						if map == "wd" then
							Box.Color = isPolice
						else Box.Color = Color3.new(1, 0.5, 0.5)
						end
					end
					if isOperative then
						if map == "bd" then
							Box.Color = isOperative
						else Box.Color = Color3.new(1, 0.5, 0.5)
						end
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
				end
			else
				BoxOutline.Visible = false
				Box.Visible = false
			end
		end)
	end

	coroutine.wrap(boxesp)()
end
game.Workspace.Level.Actors.ChildAdded:Connect(function(v)
	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = Color3.new(0, 0, 0)
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = 1
	BoxOutline.Filled = false

	local Box = Drawing.new("Square")
	Box.Visible = false
	Box.Color = Color3.new(1, 0.5, 0.5)
	Box.Thickness = 1
	Box.Transparency = 1
	Box.Filled = false

	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
			if v:FindFirstChild("Character") and v:FindFirstChild("Character"):FindFirstChild("Humanoid").Health > 0 then
				local Vector, onScreen = camera:worldToViewportPoint(v:FindFirstChild("Character"):FindFirstChild("HumanoidRootPart")
					.Position)

				local RootPart = v.Character.HumanoidRootPart
				local Head = v.Character:FindFirstChild("Head")
				local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
				local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
				local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)

				if onScreen then
					BoxOutline.Size = Vector2.new(2000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2,
						RootPosition.Y - BoxOutline.Size.Y / 2)
					BoxOutline.Visible = true

					Box.Size = Vector2.new(2000 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
					Box.Visible = true

					local isSpecial = specialNPCs[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value
						]
					local isPolice = police[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					local isOperative = operative[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value
						]
					if isSpecial and (not v.Character.Inventory:FindFirstChild("KeycardHS") or isSpecial == Color3.new(0.5, 0.5, 1)) then
						Box.Color = isSpecial
					elseif v.Character.Inventory:FindFirstChild("KeycardHS") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[
							v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					elseif v.Character.Inventory:FindFirstChild("KeycardBlue") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
						if string.find(v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value, "Agent") and
							v.Character.Inventory:FindFirstChild("USB") then
							Box.Color = Color3.new(0.5, 0.5, 1)
						end
					elseif v.Character.Inventory:FindFirstChild("KeycardRed") and
						_2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value] then
						Box.Color = _2ics[v:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName").Value]
					end
					if isPolice then
						if map == "wd" then
							Box.Color = isPolice
						else Box.Color = Color3.new(1, 0.5, 0.5)
						end
					end
					if isOperative then
						if map == "bd" then
							Box.Color = isOperative
						else Box.Color = Color3.new(1, 0.5, 0.5)
						end
					end
				else
					BoxOutline.Visible = false
					Box.Visible = false
				end
			else
				BoxOutline.Visible = false
				Box.Visible = false
			end
		end)
	end

	coroutine.wrap(boxesp)()
end)


local WCACTIVE = true
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local gameStage = ReplicatedStorage:WaitForChild("GameState"):WaitForChild("Stage")
Players = game:GetService("Players")
local plr = Players.LocalPlayer
local actors = workspace.Level.Actors
local gameDifficulty = ReplicatedStorage:WaitForChild("GameState"):WaitForChild("Difficulty").Value

local NPCs = {
	guard = { "Guard", "Base Security", "Elite Guard", "Security", "Bodyguard", "SC Guard", "Janitor", "Elite Operative",
		"Evidence Custodian", "Phoenix Operative", "Falcon" },
	worker = { "Employee", "Staff", "Manager's Assisstant", "Tech", "Analyst", "Programmer", "Workshop Tech" },
	vip = { "Police Captain", "Falcon", "Manager", "Auctioneer", "Ryan", "SC Commander", "Agent Hemlock", "Agent Nightshade",
		"Detective" },
	rose = { "Rose", "Rivera", "Jade" },
	civilian = { "Civilian" },
	enemy = { "SWAT", "Aegis Unit", "ETF", "TRU", "SC Soldier", "SC Shredder", "Juggernaut", "Onyx Unit" },
	mixed = { "Police", "Halcyon Operative" }
}

if map == "wd" then
	table.insert(NPCs.enemy, "Police")
elseif map == "sci" then
	table.insert(NPCs.guard, "Halcyon Operative")
elseif map == "bd" then
	table.insert(NPCs.enemy, "Halcyon Operative")
elseif map == "lock" then
	table.insert(NPCs.guard, "Police")
end


local countW = Instance.new("IntValue")
countW.Value = 0
local countT = Instance.new("IntValue")
countT.Value = 0
local countA = Instance.new("IntValue")
countA.Value = 1
local countN = Instance.new("IntValue")
countN.Value = 0
local function killcountCheck(npc)
	local hum = npc:WaitForChild("Character"):WaitForChild("Humanoid")
	local plusminus = false
	if npc.Name == "NPC0" then
		local objName = npc:WaitForChild("Character"):WaitForChild("Interact"):WaitForChild("ObjectName")
		local primary = npc:WaitForChild("Status"):WaitForChild("Primary")
		local swatSniper = npc:WaitForChild("Status"):WaitForChild("Weapons"):WaitForChild("SwatSniper")
		while not primary.Value do task.wait() end
		if map ~= "sci" then
			if (
				objName.Value == "SWAT" or objName.Value == "ETF" or objName.Value == "SC Soldier" or
					objName.Value == "Halcyon Operative") and primary.Value ~= swatSniper then
				countN.Value = countN.Value + 1
				plusminus = true
			end
		else
			if (objName.Value == "TRU") and primary.Value ~= swatSniper then
				countN.Value = countN.Value + 1
				plusminus = true
			end
		end
	end
	local done = false
	hum:GetPropertyChangedSignal("Health"):Connect(function()
		if hum.Health <= 0 and not done then
			done = true
			countT.Value = countT.Value + 1
			if plusminus then
				countW.Value = countW.Value + 1
				countN.Value = countN.Value - 1
			end
		end
	end)
end

local image = Drawing.new("Image")
local text1 = Drawing.new("Text")
local textCount = Drawing.new("Text")
local text2 = Drawing.new("Text")
local textWave = Drawing.new("Text")
local text3 = Drawing.new("Text")
local textTotal = Drawing.new("Text")
local textTimer = Drawing.new("Text")


image.Size = Vector2.new(286, 185.825)
image.Position = Vector2.new(816, 633.175)
image.Transparency = 0.6
image.Visible = true
image.Rounding = 0

textTimer.Position = Vector2.new(815, 587.219)
textTimer.Size = 18
textTimer.Font = Drawing.Fonts.UI
textTimer.Text = "Waiting for loud"
textTimer.Visible = true


text1.Position = Vector2.new(816, 633.175)
text1.Size = 18
text1.Font = Drawing.Fonts.UI
text1.Text = "Current Wave Deaths"
text1.Visible = true


textCount.Position = Vector2.new(816, 652)
textCount.Size = 18
textCount.Font = Drawing.Fonts.UI
textCount.Text = "0"
textCount.Visible = true

text2.Position = Vector2.new(816, 693.837)
text2.Size = 18
text2.Font = Drawing.Fonts.UI
text2.Text = "Current Wave"
text2.Visible = true


textWave.Position = Vector2.new(816, 715)
textWave.Size = 18
textWave.Font = Drawing.Fonts.UI
textWave.Text = "1"
textWave.Visible = true


text3.Position = Vector2.new(816, 754.5)
text3.Size = 18
text3.Font = Drawing.Fonts.UI
text3.Text = "Total Deaths"
text3.Visible = true

textTotal.Position = Vector2.new(816, 775)
textTotal.Size = 18
textTotal.Font = Drawing.Fonts.UI
textTotal.Text = "0"
textTotal.Visible = true


local wavecountInfo = { 0, 0, 0, 0 }
if (map == "bs" or map == "lh" or map == "bd") then
	if gameDifficulty <= 3 then
		wavecountInfo = { 24, 21, 0, 13 }
	else
		wavecountInfo = { 40, 37, 0, 13 }
	end
else
	if gameDifficulty <= 3 then
		wavecountInfo = { 18, 15, 0, 26 }
	else
		wavecountInfo = { 30, 27, 0, 26 }
	end
end
countT.Changed:Connect(function()
	textTotal.Text = tostring(countT.Value)
end)
countW.Changed:Connect(function()
	if countW.Value < wavecountInfo[1] then
		textCount.Text = tostring(countW.Value)
	else
		countW.Value = 0
		textCount.Text = tostring(countW.Value)
		countA.Value = countA.Value + 1
	end
	if countW.Value == wavecountInfo[2] - wavecountInfo[3] then
		coroutine.wrap(function()
			local timer = wavecountInfo[4]
			textTimer.Text = "Wavebreak"
			timer = timer - 1
			while timer >= 0 do
				task.wait(1)
				if timer >= 10 then
					textTimer.Text = "0:" .. tostring(timer)
				else
					textTimer.Text = "0:0" .. tostring(timer)
				end
				timer = timer - 1
			end
			textTimer.Text = "WAVE IN PROGRESS"
		end)()
	end
end)
countA.Changed:Connect(function()
	textWave.Text = tostring(countA.Value)
	if gameDifficulty == 3 and countA.Value >= 2 then
		if (map == "bs" or map == "lh" or map == "bd") then
			wavecountInfo = { 40, 37, 0, 13 }
		else
			wavecountInfo[1] = 30
			wavecountInfo[2] = 27
		end
	end
end)
for i, v in pairs(actors:GetChildren()) do
	killcountCheck(v)
end
actors.ChildAdded:Connect(killcountCheck)
gameStage.Changed:Connect(function(v)
	if v == 0 then
		textTimer.Text = "Waiting for loud"
	elseif v == 1 then
		textTimer.Text = "Loud started"
	elseif v == 2 then
		textTimer.Text = "WAVE IN PROGRESS"
	end
	if map == "wd" then
		coroutine.wrap(function()
			while (function()
				for i, v in pairs(actors:GetChildren()) do
					local char = v:FindFirstChild("Character")
					if char then
						local inter = char:FindFirstChild("Interact")
						if inter then
							local objen = inter:FindFirstChild("ObjectName")
							if objen and objen.Value == "SWAT" then
								return false
							end
						end
					end
				end
				return true
			end)() do task.wait() end
			for i, v in pairs(actors:GetChildren()) do
				local char = v:FindFirstChild("Character")
				if char then
					local inter = char:FindFirstChild("Interact")
					if inter then
						local objen = inter:FindFirstChild("ObjectName")
						if objen and objen.Value == "Police" then
							wavecountInfo[3] = wavecountInfo[3] + 1
						end
					end
				end
			end
		end)()
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Semicolon then
		if WCACTIVE == false then
			WCACTIVE = true
			image.Visible = true
			text1.Visible = true
			textCount.Visible = true
			text2.Visible = true
			textWave.Visible = true
			text3.Visible = true
			textTotal.Visible = true
			textTimer.Visible = true
		elseif WCACTIVE == true then
			WCACTIVE = false
			image.Visible = false
			text1.Visible = false
			textCount.Visible = false
			text2.Visible = false
			textWave.Visible = false
			text3.Visible = false
			textTotal.Visible = false
			textTimer.Visible = false
		end
	end
end)
