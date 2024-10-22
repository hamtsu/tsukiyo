local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animations = game:GetService("ReplicatedStorage"):WaitForChild("Animations")
local animator = humanoid:WaitForChild("Animator")

local AnimationController = Knit.CreateController { Name = "AnimationController" }

------ CONTROLLER VARIABLES ------

AnimationController.loadedAnimations = {}

------ PRIVATE METHODS ------

local function initAnimations()
	character:WaitForChild("Animate"):Destroy()
    
    -- TODO load all animations in subfolders
	for _, animation in pairs(animations:WaitForChild("Female"):GetChildren()) do
		if animation:IsA("Animation") then
			AnimationController.loadedAnimations[string.upper(animation.Name)] = animator:LoadAnimation(animation)
            print("Loaded animation: ", animation.Name)
		end
	end
end

------ PUBLIC METHODS ------

function AnimationController:Play(name: string, reverse: boolean, speed: number)
	name = string.upper(name)

	if self.loadedAnimations[name] then
		if speed then
			self.loadedAnimations[name]:AdjustSpeed(speed)
		end
		
		if reverse then
			self.loadedAnimations[name]:Play(0.100000001, 1, -1)
		else
			self.loadedAnimations[name]:Play()
		end
	else
		warn("AnimationController: Could not PLAY animation of name: ", name)
	end
end

function AnimationController:Stop(name: string)
    name = string.upper(name)

    if self.loadedAnimations[name] then
        self.loadedAnimations[name]:Stop()
    else
        warn("AnimationController: Could not STOP animation of name: ", name)
    end
end

function AnimationController:ListCurrentAnimations()
	for _, animation in animator:GetPlayingAnimationTracks() do
		print(animation)
	end
end

------ LIFECYCLE METHODS ------

function AnimationController:KnitInit()
    initAnimations()
    print("AnimationController initialized")
end

function AnimationController:KnitStart()
    print("AnimationController started")
end

return AnimationController