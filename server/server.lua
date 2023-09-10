VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterServerEvent('feather-mail:GetAllAccounts', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local mainRetval = MySQL.query.await("SELECT * FROM feathermail")
    local allAccounts = {}
    if #mainRetval > 0 then
        for k, v in pairs(mainRetval) do
            if v.mail_type == 'personal' then
                if v.owner_char_id == Character.charIdentifier then
                    table.insert(allAccounts, { mail_id = v.mail_id, mail_type = v.mail_type, owner_char_id = v.owner_char_id, allowed_to_view = v.allowed_to_view, isOwner = true }) --insert a custom made table instead of just v so we can specify if the player is the owner of the account or not (useful for business accounts only really, but needed to be set here aswell)
                end
            elseif v.mail_type == 'business' then
                if v.owner_char_id == Character.charIdentifier then
                    table.insert(allAccounts, { mail_id = v.mail_id, mail_type = v.mail_type, owner_char_id = v.owner_char_id, allowed_to_view = v.allowed_to_view, isOwner = true })
                else
                    for e, a in pairs(json.decode(v.allowed_to_view)) do
                        if a == Character.charIdentifier then
                            table.insert(allAccounts, { mail_id = v.mail_id, mail_type = v.mail_type, owner_char_id = v.owner_char_id, allowed_to_view = v.allowed_to_view, isOwner = false }) break
                        end
                    end
                end
            end
        end
    else
        allAccounts = {}
    end
    if #allAccounts <= 0 then
        allAccounts = nil
    end
    TriggerClientEvent('feather-mail:ActivateUI', _source, allAccounts)
end)

RegisterServerEvent('feather-mail:getSelectedAccountInfo', function(account, isOwner)
    local param, _source = { ['mailId'] = account }, source
    local featherMailContactsResult = MySQL.query.await("SELECT * FROM feathermailcontacts WHERE owner_mail_id=@mailId", param)
    local featherRecMailResult = MySQL.query.await("SELECT * FROM featherrecmail WHERE id_sent_to=@mailId", param)
    local featherMailResult = MySQL.query.await("SELECT * FROM feathermail WHERE mail_id=@mailId", param)
    TriggerClientEvent('feather-mail:SendAllData', _source, featherMailContactsResult, featherRecMailResult, isOwner, featherMailResult)
end)

RegisterServerEvent('feather-mail:SendMail', function(id_sent_to, mail_message)
    local param = { ['id_sent_to'] = id_sent_to, ['mail_message'] = mail_message }
    MySQL.query.await('INSERT INTO featherrecmail (`id_sent_to`,`mail_message`) VALUES (@id_sent_to,@mail_message)', param)
end)

RegisterServerEvent('feather-mail:DeleteMail', function(mailId)
    local param = { ['mail_id'] = mailId }
    MySQL.query.await("DELETE FROM featherrecmail WHERE mail_id=@mail_id", param)
end)

RegisterServerEvent('feather-mail:CreateMailAccount', function(type)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local param = { ['type'] = type, ['ownerId'] = Character.charIdentifier, ['allowedIds'] = json.encode({{id = Character.charIdentifier}}) }
    MySQL.query.await('INSERT INTO feathermail (`mail_type`,`owner_char_id`,`allowed_to_view`) VALUES (@type,@ownerId,@allowedIds)', param)
end)

RegisterServerEvent('feather-mail:CreateContact', function(owner_mail_id, contact_mail_id, contact_name)
    local param = { ['contactName'] = contact_name, ['contactId'] = contact_mail_id, ['ownerId'] = owner_mail_id }
    local result = MySQL.query.await("SELECT * FROM feathermailcontacts WHERE owner_mail_id=@ownerId", param)
    if #result <= 0 then
        MySQL.query.await('INSERT INTO feathermailcontacts (`owner_mail_id`,`contact_name`,`contact_mail_id`) VALUES (@ownerId,@contactName,@contactId)', param)
    else
        local insert = true
        for k, v in pairs(result) do
            if v.contact_mail_id == contact_mail_id then
                insert = false
            end
        end
        if insert then
            MySQL.query.await('INSERT INTO feathermailcontacts (`owner_mail_id`,`contact_name`,`contact_mail_id`) VALUES (@ownerId,@contactName,@contactId)', param)
        end
    end
end)

RegisterServerEvent('feather-mail:AddNewAllowedId', function(mailId, newId)
    local selectionParam = { ['mailId'] = mailId }
    local selectionResult = MySQL.query.await("SELECT * FROM feathermail WHERE mail_id=@mailId", selectionParam)
    if #selectionResult > 0 then
        local currentAllowedIds = json.decode(selectionResult[1].allowed_to_view)
        table.insert(currentAllowedIds, { id = newId })
        local insertionParam = { ['mailId'] = mailId, ['allowedIds'] = json.encode(currentAllowedIds) }
        MySQL.query.await('UPDATE feathermail SET allowed_to_view=@allowedIds WHERE mail_id=@mailId', insertionParam)
    else
        print("An error has occured mail id not found")
    end
end)

RegisterServerEvent('feather-mail:allowedIdDeleted', function(deletedId, mailId)
    local param = { ['mailId'] = mailId, ['deletedId'] = deletedId }
    local result = MySQL.query.await("SELECT * FROM feathermail WHERE mail_id=@mailId", param)
    if #result > 0 then
        local recTable = json.decode(result[1].allowed_to_view)
        for k, v in pairs(recTable) do
            if v.id == deletedId then
                table.remove(recTable, k)
                local updateParam = { ['mailId'] = mailId, ['allowedIds'] = json.encode(recTable) }
                MySQL.query.await('UPDATE feathermail SET allowed_to_view=@allowedIds WHERE mail_id=@mailId', updateParam) break
            end
        end
    else
        print("Failed error no account with the id chosen has been found")
    end
end)

RegisterServerEvent('feather-mail:DeleteContact', function(ownerMailId, contactMailId)
    local param = { ['owner'] = ownerMailId, ['contact'] = contactMailId }
    MySQL.query.await("DELETE FROM feathermailcontacts WHERE owner_mail_id=@owner AND contact_mail_id=@contact", param)
end)

--- Check if properly downloaded (FIX BEFORE PUBLISH) ---
function file_exists(name)
    local f = LoadResourceFile(GetCurrentResourceName(), name)
    return f ~= nil
end

if not file_exists('./ui/index.html') then
    print("^1 INCORRECT DOWNLOAD!  ^0")
    print(
        '^4 Please Download: ^2(feather-stables.zip) ^4from ^3<https://github.com/BryceCanyonCounty/feather-stables/releases/latest>^0')
end