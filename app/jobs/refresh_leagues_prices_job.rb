class RefreshLeaguesPricesJob < ApplicationJob
  queue_as :default

  def perform()
    League.all.each do |league|
      league.fetch_currency_prices
    end
  end
end
