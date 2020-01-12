json.current_user do 
  json.extract! current_user, :id, :email, :token
end
json.current_league do
  json.extract! League.current, :name, :version, :start_date, :end_date, :currencies_prices
end
json.analyses @analyses do |analysis|
  json.id analysis.id
  json.item do 
    json.extract! analysis.item, :name, :slug, :item_type, :rarity, :image, :link, :wiki_item_card, :tags
  end
  json.league_analyses analysis.league_analyses do |leagueal_analysis|
    json.id leagueal_analysis.id
    json.league do 
      json.name leagueal_analysis.league.name
      json.start_date leagueal_analysis.league.start_date
    end
    json.buyout do 
      json.price leagueal_analysis.max_buyout
      json.currency leagueal_analysis.buyout_currency
    end
    json.sellout do 
      json.price leagueal_analysis.min_sellout
      json.currency leagueal_analysis.sellout_currency
    end
    json.extract! leagueal_analysis, :occurences, :trades, :estimated_swipe_difficulty, :search_params, :search_id, :comments
  end
end

