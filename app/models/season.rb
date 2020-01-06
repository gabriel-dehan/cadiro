class Season < ApplicationRecord
  validates :name, presence: true
  validates :start_date, presence: true

  has_many :season_analyses

  after_create :fetch_currency_prices

  def self.current
    Season.order(start_date: :desc).first
  end

  def fetch_currency_prices
    currencies_ids = {
      exalted: 142
    }
    # chaos: 22687
    
    currencies_prices = currencies_ids.map do |currency, id|
      result = PoeWatchApi.currency_price(id)
      league_data = result["leagues"].find { |league| league["name"] === self.name }
      if league_data
        [currency, league_data["mode"]]
      end
    end.compact.to_h
    
    # Add base price which is chaos orbs
    currencies_prices[:chaos] = 1
    
    self.currencies_prices = currencies_prices
    self.save!
  end

end
