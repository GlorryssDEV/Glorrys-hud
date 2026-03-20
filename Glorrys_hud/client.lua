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
