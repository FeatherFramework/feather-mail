-- Queue all progress tasks to prevent infinite loops and overlap
local state = false
local currentMailIdInUse = nil

function ToggleUI(allAccounts)
    state = not state
    SendNUIMessage({
        type = 'toggle',
        visible = state,
        accounts = allAccounts
    })
end

function sendUIdata(contacts, recMail, isOwner, accountInfo)
    SendNUIMessage({
        type = 'recieveSelectedAccountInfo',
        contacts = contacts,
        recMail = recMail,
        isOwner = isOwner,
        accountType = accountInfo.mail_type,
        allowedIds = json.decode(accountInfo.allowed_to_view),
        accountInfo = accountInfo
    })
end

RegisterNUICallback('updatestate', function(args, nuicb)
    state = args.state
    SetNuiFocus(state, state)
    print('State change received!', state)

    nuicb('ok')
end)

RegisterNUICallback('getSelectedAccountInfo', function(account, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:getSelectedAccountInfo', tonumber(account.account), account.isOwner) --account.account is accessing the nui thingy
end)

RegisterNUICallback('sendMail', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:SendMail', tonumber(data.id_sent_to), data.mail_message)
end)

RegisterNUICallback('deleteMail', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:DeleteMail', tonumber(data.mail_id))
end)

RegisterNUICallback('createContact', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:CreateContact', currentMailIdInUse, tonumber(data.contact_mail_id), data.contact_name)
end)

RegisterNUICallback('contactDeleted', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:DeleteContact', data.ownerId, data.contactId)
end)

RegisterNetEvent("feather-mail:ActivateUI", function(allAccounts)
    ToggleUI(allAccounts)
end)

RegisterNUICallback('createAccount', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:CreateMailAccount', data.type)
end)

RegisterNuiCallback('addAllowedId', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:AddNewAllowedId', data.mail_id, data.allowedId)
end)

RegisterNUICallback('allowedIdDeleted', function(data, cb)
    cb('ok')
    TriggerServerEvent('feather-mail:allowedIdDeleted', tonumber(data.deletedId), tonumber(data.mailId))
end)

RegisterNetEvent('feather-mail:SendAllData', function(featherMailContactsResult, featherRecMailResult, isOwner, featherMailResult)
    local contacts, recMail = nil, nil --will set null in js
    if #featherMailContactsResult > 0 then --check to make sure it exist if it does it updates
        contacts = featherMailContactsResult
    end
    if #featherRecMailResult > 0 then
        recMail = featherRecMailResult[1]
    end
    currentMailIdInUse = featherMailResult[1].mail_id
    sendUIdata(contacts, recMail, isOwner, featherMailResult[1])
end)

RegisterCommand('testMail', function()
    TriggerServerEvent('feather-mail:GetAllAccounts')
end)