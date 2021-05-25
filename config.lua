plt_illegalsatis = {}
local PLT = plt_illegalsatis
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)


PLT.U = Lang["EN"]               -- You can change "EN" or "Custom" or more, if you edit on locale.lua
PLT.PoliceNeed = 0               -- haw many police need for sale
PLT.Item = {
  title    = PLT.U["interact"],  -- title
  sellItem = {
    ["adrenaline_shot"] = {      -- item db name
      price = 130,               -- price
      bekleme = 24,              -- How many seconds to wait for 1 piece
      max = 50                   -- The maximum number of pieces that can be sold at once
    },
    ["doping"] = { 
      price = 1000,
      bekleme = 120,
      max = 10
    },
    ["mucevher"] = { 
      price = 110,
      bekleme = 6,
      max = 200
    }
  },
}