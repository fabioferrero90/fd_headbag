local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("fd_headbag:serverAdd", function(closestPlayer)
    TriggerClientEvent("fd_headbag:StartThread", closestPlayer)
end)

RegisterNetEvent("fd_headbag:serverRemove", function(BaggedPlayer)
    TriggerClientEvent("fd_headbag:RemoveHeadBag", BaggedPlayer)
end)

QBCore.Functions.CreateUseableItem("head_bag", function(source)
    TriggerClientEvent("fd_headbag:CheckThread", source)
end)

QBCore.Functions.CreateCallback('fd_headbag:server:GetCuffState', function(source,cb, id)
    local player = QBCore.Functions.GetPlayer(id)

    if player then
        local handcuffed = player.PlayerData.metadata.ishandcuffed
        cb(handcuffed)
    end
    cb(nil)
end)