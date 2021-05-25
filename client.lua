ESX              = nil
local PLT = plt_illegalsatis
local Yenile = false
local Bilgi = "notReady"
local kalan = nil
local islemyok = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(100)
  end
end)

Citizen.CreateThread(function() 
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(100)
  end
  local pltkoords = "notReady"
  ESX.TriggerServerCallback('plt_illegalsatis:Checkkoord', function(cb) pltkoords = cb end)
  while pltkoords == "notReady"  do Citizen.Wait(10) end
  while true do Citizen.Wait(0)
    Yenile = false
    playercoords = GetEntityCoords(GetPlayerPed(-1))
    if (GetDistanceBetweenCoords(playercoords, pltkoords, true) < 10) and not Yenile then
      Bilgi = "notReady"
      ESX.TriggerServerCallback('plt_illegalsatis:CheckDurum', function(cb) Bilgi = cb end)
      while Bilgi == "notReady"  do Citizen.Wait(10) end
      if Bilgi.Islemde == false then 
        while Bilgi.Durum == false and Bilgi.Saniye == false and not Yenile do Citizen.Wait(0)
          playercoords = GetEntityCoords(GetPlayerPed(-1))
          DrawMarker(27, pltkoords.x,pltkoords.y,pltkoords.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
          if (GetDistanceBetweenCoords(playercoords, pltkoords, true) < 1)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~(~o~-~g~E~o~-~r~) ~r~[~o~- ~b~"..PLT.Item.title.." ~o~-~r~]")
            if IsControlPressed(0,46) and islemyok then
              islemyok = false
              OpenMenu()
            end
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 11)  then
            break
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 1)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~[~o~- ~b~"..PLT.Item.title.." ~o~-~r~]")
          end	
        end
        while type(Bilgi.Durum) == type(123) and type(Bilgi.Saniye) == type(123) and Bilgi.Saniye >= 1 and not Yenile do Citizen.Wait(0)
          kalan = SecondsToClock(Bilgi.Saniye)
          playercoords = GetEntityCoords(GetPlayerPed(-1))
          DrawMarker(27, pltkoords.x,pltkoords.y,pltkoords.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
          if (GetDistanceBetweenCoords(playercoords, pltkoords, true) < 2)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~[~o~- ~g~ "..kalan.." ~o~-~r~]")
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 11) then
            break
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 1)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~[~o~- ~b~ "..PLT.U["delivery_now"].."~o~-~r~]")
          end	
        end
        while type(Bilgi.Durum) == type(123) and Bilgi.Saniye <= 1 and not Yenile do Citizen.Wait(0)
          playercoords = GetEntityCoords(GetPlayerPed(-1))
          DrawMarker(27, pltkoords.x,pltkoords.y,pltkoords.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)  
          if (GetDistanceBetweenCoords(playercoords, pltkoords, true) < 1)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~(~o~-~g~E~o~-~r~) ~r~[~o~- ~b~ "..PLT.U["take_money1"].." ~o~-~r~]")
            if IsControlPressed(0,46) then
              TriggerServerEvent('plt_illegalsatis:ParaAl')
              Citizen.Wait(1000)
              break
            end
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 11) then
            break
          elseif (GetDistanceBetweenCoords(playercoords, pltkoords, true) > 1)  then
            DrawText3Ds(pltkoords.x,pltkoords.y,pltkoords.z, 0.35, 0.35,  "~r~[~o~- ~b~ "..PLT.U["tooke_money"].." ~o~-~r~]")
          end	
        end
      else
        Citizen.Wait(1000)
      end
    else
      Citizen.Wait(1000)
    end
  end
end)

local bekleme = false
  function OpenMenu(npcTh)
    ESX.UI.Menu.CloseAll()
    local elemanlar = {}
    for itemV,itemK in pairs(PLT.Item.sellItem) do 
      bekleme = false
      ESX.TriggerServerCallback('plt_illegalsatis:itemlabel', function(cb)
        if cb == nil then 
          table.insert(elemanlar, {label = itemV, value = itemV})
        else
          table.insert(elemanlar, {label = cb, value = itemV})
        end
        bekleme = true
      end,itemV)
      while not bekleme do Citizen.Wait(10) end
    end
    table.insert(elemanlar, {label = PLT.U["cancel"], value = "iptal"})
   ESX.UI.Menu.Open('default', "plt_illegalsatis", 'letcraft', {
		title    = PLT.Item.title,
    align    = 'top-left',
    elements = elemanlar
  }, function(data, menu)
      menu.close()
      if data.current.value ~= 'iptal' then
        local tercih = data.current.value
        local tercihadi = data.current.label
        ESX.UI.Menu.Open('dialog', "PLT_ILLEGALSATIS", 'PLT_ILLEGALSATIS', { title = PLT.U["how_many"] }, function(data2, menu2)
          local amount = tonumber(data2.value)
          if amount == nil or amount < 1 or amount >  PLT.Item.sellItem[tercih].max then
            if amount > PLT.Item.sellItem[tercih].max then 
              exports['mythic_notify']:DoCustomHudText('error', PLT.U["please_value1"]..PLT.Item.sellItem[tercih].max..PLT.U["please_value2"] ,2500)
            else
              exports['mythic_notify']:DoCustomHudText('error', PLT.U["Invalid_value"] ,2500)
            end
          else
            menu2.close()
            TriggerServerEvent('plt_illegalsatis:craftBaslat',tercih,tercihadi,amount)
            Citizen.Wait(2500)
            islemyok = true
          end
        end, function(data2, menu2)
          exports['mythic_notify']:DoCustomHudText('error', PLT.U["cancelled"]  ,2500)
          menu2.close()
          Citizen.Wait(2500)
          islemyok = true
        end)
      else
        islemyok = true
      end
  end, function(data, menu)
    islemyok = true
		menu.close()
  end)
end

function CloseMenu()
  ESX.UI.Menu.CloseAll()
end

RegisterNetEvent("plt_illegalsatis:islem")
AddEventHandler("plt_illegalsatis:islem", function(deger)
  Yenile = true
end)

function SecondsToClock(seconds)
  local seconds = tonumber(seconds)
  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

function DrawText3Ds(x,y,z, sx, sy, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(sx, sy)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 500
	DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end