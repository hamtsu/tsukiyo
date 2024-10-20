local UserInputService = game:GetService("UserInputService")
local Knit = require(game:GetService("ReplicatedStorage").Packages.knit)

local MovementController = Knit.CreateController { Name = "MovementController" }

-- TODO manage animations here

function MovementController:KnitInit()
    print("MovementController initialized")
end

function MovementController:KnitStart()
    print("MovementController started")
end

return MovementController