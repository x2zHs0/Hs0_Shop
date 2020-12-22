ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


ConfHs0              = {}
ConfHs0.DrawDistance = 100
ConfHs0.Size         = {x = 1.0, y = 1.0, z = 1.0}
ConfHs0.Color        = {r = 87, g = 180, b = 14}
ConfHs0.Type         = 29

local position = {
        {x = 373.875,   y = 325.896,  z = 103.566},
        {x = 2557.458,  y = 382.282,  z = 108.622},
        {x = -3038.939, y = 585.954,  z = 7.908},
        {x = -3241.927, y = 1001.462, z = 12.830},
        {x = 547.431,   y = 2671.710, z = 42.156},
        {x = 1961.464,  y = 3740.672, z = 32.343},
        {x = 2678.916,  y = 3280.671, z = 55.241},
        {x = 1729.216,  y = 6414.131, z = 35.037},
        {x = 1135.808,  y = -982.281,  z = 46.415},
        {x = -1222.915, y = -906.983,  z = 12.326},
        {x = -1487.553, y = -379.107,  z = 40.163},
        {x = -2968.243, y = 390.910,   z = 15.043},
        {x = 1166.024,  y = 2708.930,  z = 38.157},
        {x = 1392.562,  y = 3604.684,  z = 34.980},
        {x = -48.519,   y = -1757.514, z = 29.421},
        {x = 1163.373,  y = -323.801,  z = 69.205},
        {x = -707.501,  y = -914.260,  z = 19.215},
        {x = -1820.523, y = 792.518,   z = 138.118},
        {x = 25.75,     y = -1347.36,  z = 29.5},
        {x = 1698.388,  y = 4924.404,  z = 42.063}          
}  

Citizen.CreateThread(function()
     for k in pairs(position) do
        local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
        SetBlipSprite(blip, 52)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Superette")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (ConfHs0.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < ConfHs0.DrawDistance) then
                DrawMarker(ConfHs0.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfHs0.Size.x, ConfHs0.Size.y, ConfHs0.Size.z, ConfHs0.Color.r, ConfHs0.Color.g, ConfHs0.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('hs0_shop', 'main', RageUI.CreateMenu("Shop", "Venez acheter vos articles."))
RMenu.Add('hs0_shop', 'shop', RageUI.CreateSubMenu(RMenu:Get('hs0_shop', 'main'), "Articles", "Voici nos articles."))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('hs0_shop', 'main'), true, true, true, function()

            RageUI.Button("Parler à Apu", "Pour consulter nos articles.", {RigtLabel = "→→→"},true, function()
            end, RMenu:Get('hs0_shop', 'shop')) 

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('hs0_shop', 'shop'), true, true, true, function()

            RageUI.Button("Acheter Pain", nil, {RightLabel = "~g~10$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                TriggerServerEvent('hs0_shop:acheterpain')
            end
            end)

            RageUI.Button("Acheter Eau", nil, {RightLabel = "~g~10$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                TriggerServerEvent('hs0_shop:achetereau')
            end
            end)


        end, function()
        end)

        Citizen.Wait(0)
    end
end)



Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au shop")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('hs0_shop', 'main'), not RageUI.Visible(RMenu:Get('hs0_shop', 'main')))
                    end   
                end
            end
        end
    end)