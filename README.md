# plt_illegal-selling


## How does this script works?

This is a simple selling script. The player interracts with the marker.
He/she will be allowed to select the item he/she wants to sell at the menu.
He/she has to write the number he/she wants to sell.
There is a cooldown for each item he/she adds. The more piece he/she adds, the more he/she waits to collect the money.
This action works synchronized with every player. If one player is already selling some items, everyone else has to wait for the sale to be completed before adding more items to sale.
Once the waiting time is over, the first player who gets to the marker will be allowed to receive the money without checking who placed the items to sale.
## Why can anyone take the money? Why only one person can sell items at a time?

While coding this script, my goal was to create a block system so players has to defend the area and their valuable items.
The powerful groups who wants to sell their drugs, jewelry or other stuffs will have to defend it and other groups can try to capture the area and claim the rewards.
## What can be changed by config file?

At the “lang.lua” you can change the language.
You can change the requirements of active police members for the script to be active.
You can add as many sellable items as you want.
You can change the max numbers of the items to sale, how many seconds to wait for each piece to be sold and how much money an item will give for each and every item separately you add in menu.
Marker coordiantes can be changed at the server.lua.
## Requirements

- extended framework
- mythic_notify

https://polat.tebex.io/
