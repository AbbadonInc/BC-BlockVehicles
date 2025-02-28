local blockedVehicles = {
    -- Aircrafts
    'cargoplane', 'dodo', 'duster', 'luxor', 'luxor2', 'mammatus', 'miljet', 'shamal', 'jet', 'velum', 'velum2', 'vestra',
    'hydra', 'lazer', 'titan', 'bombushka', 'avenger', 'nokota', 'mogul', 'starling', 'strikeforce', 'besra', 'rogue', 
    'cuban800', 'seabreeze', 'alphaz1', 'microlight',
    -- Helicopters
    'volatus', 'swift', 'swift2', 'supervolito', 'supervolito2', 'frogger', 'frogger2', 'maverick', 'annihilator', 
    'buzzard', 'buzzard2', 'savage', 'valkyrie', 'hunter', 'akula', 'havok', 'cargobob', 'cargobob2', 'cargobob3', 
    'cargobob4',
    -- Police, EMS, Service Vehicles
    'police', 'police2', 'police3', 'police4', 'policeb', 'policet', 'sheriff', 'sheriff2', 'fbi', 'fbi2', 'ambulance',
    'firetruk', 'pbus', 'riot', 'riot2', 'pranger', 'lguard', 'towtruck', 'towtruck2'
}

Citizen.CreateThread(function()
    -- Suppress vehicle models (one-time execution)
    for _, vehicle in ipairs(blockedVehicles) do
        SetVehicleModelIsSuppressed(GetHashKey(vehicle), true)
    end
end)

-- Function to delete already spawned blocked vehicles
function RemoveBlockedVehicles()
    local vehicles = GetGamePool("CVehicle")
    for _, vehicle in ipairs(vehicles) do
        local model = GetEntityModel(vehicle)
        for _, blocked in ipairs(blockedVehicles) do
            if model == GetHashKey(blocked) then
                DeleteEntity(vehicle)
            end
        end
    end
end

-- Check for and remove blocked vehicles every 5 seconds
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Optimized wait time
        RemoveBlockedVehicles()
    end
end)
