local ESX  = nil
local IsOpen = false
local PasswordAttempted = 0
local PlyPed = GetPlayerPed(-1)

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local PasswordMenu = RageUI.CreateMenu("Mot de Passe", "Yatox#3203")

PasswordMenu.Controls.Back.Enabled = false

PasswordMenu.Closed = function()
    RageUI.Visible(PasswordMenu,false)
    open = false
end

function OpenPasswordMenu()
    if open then 
        open = false 
        RageUI.Visible(PasswordMenu,false)
        return
    else
        open = true 
        RageUI.Visible(PasswordMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(PasswordMenu, function()
                    RageUI.Button('Mot de passe', false , {RightLabel = PasswordResult}, true , {
                        onSelected = function()
                            local Result = KeyboardInput('mdp', 'Mot de passe', '', 30)
                            PasswordResult = Result
                        end
                    })
                    RageUI.Button("Rentrer dans le serveur", false, {RightLabel = "→", Color = {HightLightColor = {0, 155, 0, 150}, BackgroundColor = {38, 85, 150, 160}}}, true, {
                        onSelected = function()
                            TriggerServerEvent('Password:EntryServer', PasswordResult, PasswordAttempted)
                        end
                    })
                end)

                Wait(0)
            end
        end)


    end
end 

RegisterNetEvent('Password:ActualizeAttempt')
AddEventHandler('Password:ActualizeAttempt', function(results, Freeze, GoodPassword)
    PasswordAttempted = results
    FreezeEntityPosition(PlyPed, Freeze)
    if GoodPassword then
        PasswordMenu.Closed()
    end
end)