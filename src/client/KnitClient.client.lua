local replicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(replicatedStorage.Packages.knit)

-- Load all controllers
Knit.AddControllers(script.Parent.Controllers)

Knit.Start():andThen(function()
    print("Knit client started")
end):catch(warn)