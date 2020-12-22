ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_shop:acheterpain')
AddEventHandler('hs0_shop:acheterpain', function(v, quantite)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= 10 then
		xPlayer.addInventoryItem('bread', 1)
		xPlayer.removeMoney(10)
		TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~Pain ~s~!")
	else
		TriggerClientEvent('esx:showNotification', source, "Il vous manque ~r~10$ ~s~!")
	end
end)

RegisterNetEvent('hs0_shop:achetereau')
AddEventHandler('hs0_shop:achetereau', function(v, quantite)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= 10 then
		xPlayer.addInventoryItem('water', 1)
		xPlayer.removeMoney(10)
		TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~Eau ~s~! ")
	else
		TriggerClientEvent('esx:showNotification', source, "Il vous manque ~r~10$ ~s~!")	
	end	
end)