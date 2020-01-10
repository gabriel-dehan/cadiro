class RefreshPoeWatchDataJob < ApplicationJob
  queue_as :default

  def perform()
    Season.all.each do |season|
      season.fetch_currency_prices
    end
  end
end
