local PLT = plt_illegalsatis
ESX = nil
local Islemde = false
local Durum = false
local Saniye = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('plt_illegalsatis:craftBaslat')
AddEventHandler('plt_illegalsatis:craftBaslat', function(exportItemName,exportItemLabel,amount)
        if Islemde == false and Durum == false then 
                Islemde = true
                TriggerClientEvent("plt_illegalsatis:islem",-1)
                if AnyCops() >= PLT.PoliceNeed  then 
                        
                        local xPlayer = ESX.GetPlayerFromId(source)
                        local label = ESX.GetItemLabel(exportItemName)

                        if xPlayer.getInventoryItem(exportItemName).count >= amount then
                                xPlayer.removeInventoryItem(exportItemName,amount)
                                --TriggerEvent('plt_soygunlog',source,"log_blok","blok item koydu",(amount.." adet "..exportItemName))
                                local totalbekleme = amount * PLT.Item.sellItem[exportItemName].bekleme
                                Saniye = totalbekleme
                                Durum = amount * PLT.Item.sellItem[exportItemName].price
                                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = PLT.U["success"], length = 20000})                        
                        else
                                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = PLT.U["dony_have"]..label.."' !", length = 7500})  
                        end
                else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = PLT.U["no_police"], length = 7500})  
                end
                Islemde = false
                TriggerClientEvent("plt_illegalsatis:islem",-1)
        else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = PLT.U["other_action"], length = 7500})
        end
end)

RegisterServerEvent('plt_illegalsatis:ParaAl')
AddEventHandler('plt_illegalsatis:ParaAl', function()
        if Islemde == false and Durum then
                Islemde = true
                TriggerClientEvent("plt_illegalsatis:islem",-1)

                if Saniye <= 1 then 
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = Durum..PLT.U["take_money"], length = 7500})
                        local xPlayer = ESX.GetPlayerFromId(source)
                        xPlayer.addMoney(Durum)
                        
                        --TriggerEvent('plt_soygunlog',source,"log_blok","para aldı",Durum)
                        Durum = false
                        Saniye = false
                else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "why you try do bug FUCK OFF ", length = 7500})  
                end
                Islemde = false
                TriggerClientEvent("plt_illegalsatis:islem",-1)
        else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = PLT.U["other_action"], length = 7500})
        end
end)


Citizen.CreateThread(function() 
        while true do Citizen.Wait(1000)
                if Saniye ~= false and Saniye >= 1 then 
                        Saniye = Saniye - 1 
                        TriggerClientEvent("plt_illegalsatis:islem",-1)
                end    
        end   
end)

ESX.RegisterServerCallback('plt_illegalsatis:CheckDurum', function(source, cb, arg) 
  cb({Islemde = Islemde , Durum = Durum , Saniye = Saniye})
end) 


ESX.RegisterServerCallback('plt_illegalsatis:itemlabel', function(source, cb, item) 
        cb(ESX.GetItemLabel(item))
end) 



function AnyCops()
        local anycops = 0
        local playerList = GetPlayers()

        for i = 1, #playerList, 1 do
                local _source = playerList[i]
                local xPlayer = ESX.GetPlayerFromId(_source)
                if xPlayer ~= nil then 
                        if xPlayer.job.name == 'police' then
                                anycops = anycops + 1
                        end
                end
        end
        return anycops
end

ESX.RegisterServerCallback('plt_illegalsatis:Checkkoord', function(source, cb, arg) 
      cb(vector3(873.5278, -2200.485, 30.51937))
end) 
---------------------------------------------------
