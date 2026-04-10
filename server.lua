local MYLES_CHAIN_METADATA = {
    chainId = 'myles_chain',
    label = 'Myles Chain',
    description = 'A custom wearable Myles chain.',
    type = 'Neck Chain',
    image = 'myles_chain.png',
    componentId = 7,

    male = {
        drawable = 12,
        texture = 0
    },

    female = {
        drawable = 12,
        texture = 0
    }
}

RegisterCommand('givemyleschain', function(source, args)
    local target = tonumber(args[1]) or source
    if target <= 0 then return end

    local success, response = exports.ox_inventory:AddItem(target, 'chains', 1, MYLES_CHAIN_METADATA)

    if not success then
        print(('Failed to give Myles Chain: %s'):format(response or 'unknown error'))
    end
end, true)
