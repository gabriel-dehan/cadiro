class PoeWatchApi
  class PoeWatchApiError < StandardError; end

  class << self
    def get(params) 
      uri = URI("https://api.poe.watch/item")
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
      raise PoeWatchApiError.new("Couldn't connect to poe wiki") unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body) 
    end

    def currency_price(id)
      get(id: id)
    end
  end
end