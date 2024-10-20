local replicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(replicatedStorage.Packages.knit)

Knit.Start():andThen(function()
    print("Knit server started")
end):catch(warn)