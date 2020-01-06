class PoeWikiApi
  class PoeWikiApiError < StandardError; end

  class << self
    def get(params) 
      uri = URI("https://pathofexile.gamepedia.com/api.php")
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      raise PoeWikiApiError.new("Couldn't connect to poe wiki") unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body) 
    end

    def search_unique(item_name)
      result = get({
        action: "cargoquery",
        format: "json",
        tables: "items",
        fields: "name,rarity,tags,inventory_icon,_pageName=\"item\"",
        where:  "_pageName LIKE \"%#{item_name}%\" AND rarity=\"Unique\""
      })
      
      result
    end

    def fetch_icon_url(file_name)
      result = get({
        action: "query",
        format: "json",
        titles: file_name,
        prop: "imageinfo",
        iiprop: "url"
      })

      if result["query"] && result["query"]["pages"].any?
        page_imagesinfo = result["query"]["pages"].map do |id, page|
          page["imageinfo"][0]["url"]
        end

        page_imagesinfo[0]
      end
    end
  end
end