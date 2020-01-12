# Cadiro

Tired of having to use a spreadsheet to register all the live searches I was doing on [pathofexile.com/trade](https://pathofexile.com/trade), I decided to create an application that plugs itself on the aforementionend site to retrieve your livesearch data and display it in an orderly and *searchable* fashion.

On top of having a nice display and not forcing you to enter your livesearches in a spreadsheet by yourself, it adds features like: 

- Filter your searches by a number of parameters (item name, item type, corrupted items, you name it)
- Quickly display all possible affixes of your items (data from wikia)
- Automatically compute your estimated profit in chaos or exalted
- A special indicator `ESD`, your `Estimated Sweep Difficulty` allows you to know how actually hard an item is to flip, this score is based on the number of occurences of an item and the number of successful or unsuccessful trades you made.
- Sort your livesearches by `ESD`, Estimated Profit, Buyout price, etc...
- Add comments to your livesearches
- Your livesearches are scoped by League. If no livesearch was made for the current league, it will display your livesearch from the previous league, with an "outdated" indicator.
- Hopefully, you'll be able to batch select multiple searches and start them at once.

Moreover, this application plugs itself inside [Poe Trade Enhancer](https://github.com/ghostscript3r/poe-trade-official-site-enhancer) (PTE), sending your livesearch data as soon as you save them in PTE. Well, actually it is a slightly altered version of PTE, modified so it can send data to **Cadiro**.

Beware, for now, it only handles **unique items**.

Here is what it looks like for now, the design is **very much** a work in progress.

![alt text](/documentation/economy2.png?raw=true )
![alt text](/documentation/economy1.png?raw=true )
![alt text](/documentation/howto.png?raw=true )

## Roadmap

### Planned for release

- [X] Button to re-install original PTE version
- [X] Ability to search your searches
- [ ] Refresh daily ex price from poewatch with a background job
- [ ] Poe watch ruby API
- [ ] Handle HC league, standard league... Use data from poewatch (https://api.poe.watch/leagues)
- [ ] Item prices scoped by league
- [ ] Proper display of search filters and renaming
- [ ] Ability to sort searches
- [ ] Ability to remove a search from Cadiro
- [ ] Ability to select multiple searches and run them at once
- [ ] Add support for more than unique items
- [ ] ESD computations
- [ ] Display outdated search (old leagues) as outdated
- [ ] Display search name from PTE
- [ ] PTE: Inputs for b/o price and s/o price when saving a search
- [ ] PTE: Button to confirm a trade has failed / been successful

### Planned for v2

- [ ] Statistics on which items were the most profitable in a specific league

### Version "One day maybe"

- Ability to edit a search directly on Cadiro

## Contribute to development

Coming soon.

- AWS S3
- Redis

## License

GNU GPLv3