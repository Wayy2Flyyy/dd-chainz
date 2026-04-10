local equippedChain = nil
local lastChainState = nil

local FREEMODE_MALE = `mp_m_freemode_01`
local FREEMODE_FEMALE = `mp_f_freemode_01`

local function notify(description, nType)
    lib.notify({
        title = 'Chains',
        description = description,
        type = nType or 'inform'
    })
end

local function getPedChainState(ped, componentId)
    return {
        drawable = GetPedDrawableVariation(ped, componentId),
        texture = GetPedTextureVariation(ped, componentId)
    }
end

local function setPedChainState(ped, componentId, drawable, texture)
    SetPedComponentVariation(ped, componentId, drawable, texture, 0)
end

local function getVariantFromMetadata(metadata)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)

    if model == FREEMODE_FEMALE and metadata.female then
        return metadata.female
    end

    if metadata.male then
        return metadata.male
    end

    return nil
end

local function sameItem(a, b)
    if not a or not b then return false end
    if a.slot ~= b.slot then return false end
    if a.name ~= b.name then return false end
    return true
end

local function clearEquippedChain()
    equippedChain = nil
    lastChainState = nil
end

local function removeEquippedChain()
    if not equippedChain or not lastChainState then
        clearEquippedChain()
        return
    end

    local ped = PlayerPedId()
    local componentId = equippedChain.metadata.componentId or 7

    setPedChainState(
        ped,
        componentId,
        lastChainState.drawable,
        lastChainState.texture
    )

    notify('Chain removed.', 'inform')
    clearEquippedChain()
end

local function equipChain(itemData)
    local ped = PlayerPedId()
    local metadata = itemData.metadata or {}

    local componentId = metadata.componentId or 7
    local variant = getVariantFromMetadata(metadata)

    if not variant then
        notify('This chain item has no valid male/female variant data.', 'error')
        return
    end

    lastChainState = getPedChainState(ped, componentId)

    setPedChainState(
        ped,
        componentId,
        variant.drawable,
        variant.texture or 0
    )

    equippedChain = {
        slot = itemData.slot,
        name = itemData.name,
        metadata = metadata
    }

    notify(('%s equipped.'):format(metadata.label or 'Chain'), 'success')
end

exports('useChain', function(data, slot)
    exports.ox_inventory:useItem(data, function(itemData)
        if not itemData then return end

        local metadata = itemData.metadata or {}

        if itemData.name ~= 'chains' then
            notify('Invalid item.', 'error')
            return
        end

        if metadata.chainId == nil then
            notify('This chain item is missing chain metadata.', 'error')
            return
        end

        if equippedChain and sameItem(equippedChain, itemData) then
            removeEquippedChain()
            return
        end

        if equippedChain then
            removeEquippedChain()
        end

        equipChain(itemData)
    end)
end)

CreateThread(function()
    while true do
        Wait(3000)

        if equippedChain then
            local slotData = exports.ox_inventory:GetSlotWithItem(
                'chains',
                { chainId = equippedChain.metadata.chainId },
                false
            )

            if not slotData or slotData.slot ~= equippedChain.slot then
                removeEquippedChain()
            end
        end
    end
end)
