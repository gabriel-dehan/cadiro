# Path of economy

Tired of having to use a spreadsheet to register all the live searches I was doing on [pathofexile.com/trade](https://pathofexile.com/trade), I decided to create an application that plugs itself on the aforementionend site to retrieve your livesearch data and display it in an orderly and *searchable* fashion.
On top of having a nice display and not forcing you to enter your livesearches in a spreadsheet by yourself, it adds features like: 

- Filter your searches by a number of parameters (item name, item type, corrupted items, you name it)
- Quickly display all possible affixes of your items (data from wikia)
- Automatically compute your estimated profit in chaos or exalted
- A special indicator `ESD`, your `Estimated Sweep Difficulty` allows you to know how actually hard an item is to flip, this score is based on the number of occurences of an item and the number of successful or unsuccessful trades you made.
- Sort your livesearches by `ESD`, Estimated Profit, Buyout price, etc...
- Add comments to your livesearches
- Your livesearches are scoped by League. If no livesearch was made for the current league, it will display your livesearch from the previous league, with an "outdated" indicator.
- Hopefully, this is not developed yet but you'll be able to batch select multiple searches and start them at once.

Moreover, this application plugs itself inside [Poe Trade Enhancer](https://github.com/ghostscript3r/poe-trade-official-site-enhancer), sending your livesearch data as soon as you save them in PTE. Well, actually it is a slightly altered version of PTE, modified so it can send data to **Path of Economy**.

Here is what it looks like for now, the design is **very much** a work in progress.

![alt text](/documentation/economy2.png?raw=true )
![alt text](/documentation/economy.png?raw=true )
![alt text](/documentation/howto.png?raw=true )

