# dd_chains

A basic **ox_inventory-based chain system** for FiveM.

This resource uses **one base item** called `chains`, then handles individual chain variants through **metadata**.  
Example: **Myles Chain** is not its own item name — it is one version of the `chains` item.

---

## Features

- Uses **ox_inventory**
- One item for all chains: `chains`
- Supports multiple chain variants through metadata
- Example variant included: **Myles Chain**
- Can equip and remove chain by using the item
- Automatically removes the chain if the item is no longer in inventory
- Easy to expand with more chain variants later

---

## Dependencies

This resource requires:

- [ox_inventory](https://overextended.dev/)
- [ox_lib](https://overextended.dev/)
```
['chains'] = {
    label = 'Chains',
    weight = 150,
    stack = false,
    consume = 0,
    close = true,
    description = 'A wearable chain.',
    client = {
        export = 'dd_chains.useChain'
    }
},```

---

## Installation

Place the resource in your server resources folder.

Example:
```txt
resources/[standalone]/dd_chains
