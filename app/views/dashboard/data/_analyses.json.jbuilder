json.current_user do 
  json.extract! current_user, :id, :email, :token
end
json.current_season do
  json.extract! Season.current, :name, :version, :start_date, :end_date, :currencies_prices
end
json.analyses @analyses do |analysis|
  json.id analysis.id
  json.item do 
    json.extract! analysis.item, :name, :item_type, :rarity, :image, :link, :wiki_item_card, :tags
  end
  json.season_analyses analysis.season_analyses do |seasonal_analysis|
    json.id seasonal_analysis.id
    json.season do 
      json.name seasonal_analysis.season.name
      json.start_date seasonal_analysis.season.start_date
    end
    json.buyout do 
      json.price seasonal_analysis.max_buyout
      json.currency seasonal_analysis.buyout_currency
    end
    json.sellout do 
      json.price seasonal_analysis.min_sellout
      json.currency seasonal_analysis.sellout_currency
    end
    json.extract! seasonal_analysis, :occurences, :trades, :estimated_swipe_difficulty, :search_params, :search_id, :comments
  end
end

