local showEdit = false

RegisterCommand("hud", function()
    showEdit = not showEdit
    SetNuiFocus(showEdit, showEdit)
    SendNUIMessage({action="edit", state=showEdit})
end, false)

RegisterNUICallback("close", function(data, cb)
    showEdit = false
    SetNuiFocus(false, false)
    cb("ok")
end)

CreateThread(function()
    while true do
        Wait(200)
        DisplayRadar(0)
        local ped = PlayerPedId()
        local health = math.max(0, GetEntityHealth(ped) - 100)
        local maxHealth = GetEntityMaxHealth(ped) - 100
        local healthPercent = maxHealth > 0 and math.floor((health / maxHealth) * 100) or 0
        local armor = GetPedArmour(ped)
        SendNUIMessage({
            action = "update",
            health = healthPercent,
            armor = armor
        })
    end
end)


RegisterCommand('armour', function(source, args)
    local amount = tonumber(args[1])

    if amount == nil then
        print("Použití: /armour [0-100]")
        return
    end

    if amount < 0 then amount = 0 end
    if amount > 100 then amount = 100 end

    local ped = PlayerPedId()
    SetPedArmour(ped, amount)

    TriggerEvent('chat:addMessage', {
        args = { '^2ARMOUR', 'Nastaveno na ' .. amount }
    })
end, false)


RegisterCommand("carabine", function()
    local ped = PlayerPedId()

    local weapon = GetHashKey("WEAPON_CARBINERIFLE")

    GiveWeaponToPed(ped, weapon, 250, false, true)
end, false)