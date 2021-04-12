local ESX = nil
local Password = "test" --Set  your password
local PasswordAttemptedMax = 3 -- Set the Number of tries
local PasswordAttemptedMax = PasswordAttemptedMax - 1

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterNetEvent('Password:EntryServer')
AddEventHandler('Password:EntryServer', function(PasswordClient, PasswordAttempted)
    if PasswordAttempted < PasswordAttemptedMax then
        if PasswordClient ~= nil then
            if PasswordClient == Password then
                local PasswordAttempted = PasswordAttempted
                TriggerClientEvent('Password:ActualizeAttempt', source, PasswordAttempted, false, true)
                TriggerClientEvent('esx:showNotification', source, "~g~Mot de Passe Validé~w~~n~ Bon Jeux sur notre serveur !")
            else
                local PasswordAttempted = PasswordAttempted + 1
                TriggerClientEvent('Password:ActualizeAttempt', source, PasswordAttempted, true, false)
                TriggerClientEvent('esx:showNotification', source, "~r~Mot de passe invalide~w~~n~Tentative restante: "..PasswordAttemptedMax - PasswordAttempted + 1)
            end
        else
            local PasswordAttempted = PasswordAttempted + 1
            TriggerClientEvent('Password:ActualizeAttempt', source, PasswordAttempted, true, false)
            TriggerClientEvent('esx:showNotification', source, "~r~Mot de passe invalide~w~~n~Tentative restante: "..PasswordAttemptedMax - PasswordAttempted + 1)
        end
    else
        DropPlayer(source, "Trop de tentative de Mot de passe")
    end
end)