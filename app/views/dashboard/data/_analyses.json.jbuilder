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
  json.league_analyses analysis.league_analyses do |league_analysis|
    json.id league_analysis.id
    json.league do 
      json.name league_analysis.league.name
      json.start_date league_analysis.league.start_date
    end
    json.buyout do 
      json.price league_analysis.max_buyout
      json.currency league_analysis.buyout_currency
    end
    json.sellout do 
      json.price league_analysis.min_sellout
      json.currency league_analysis.sellout_currency
    end
    json.extract! league_analysis, :occurences, :trades, :estimated_swipe_difficulty, :search_params, :search_id, :comments
  end
end

