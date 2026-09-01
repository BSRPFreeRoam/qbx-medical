local uiVisible = false

local function setMedicalUi(state, seconds)
    uiVisible = state
    SendNUIMessage({ action = state and 'show' or 'hide', status = state and 'critical' or nil, seconds = seconds or 0 })
end

function UpdateMedicalUi(status, seconds)
    SendNUIMessage({ action = 'update', status = status, seconds = seconds or 0 })
end

function HideMedicalUi()
    if uiVisible then setMedicalUi(false) end
end

AddEventHandler('qbx_medical:client:onPlayerLaststand', function()
    setMedicalUi(true, LaststandTime)
end)

AddEventHandler('qbx_medical:client:onPlayerDied', function()
    setMedicalUi(true, DeathTime)
    UpdateMedicalUi('deceased', DeathTime)
end)

AddEventHandler('qbx_medical:client:playerRevived', HideMedicalUi)
