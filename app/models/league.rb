require 'poe_watch'

class League < ApplicationRecord
  validates :name, presence: true
  validates :start_date, presence: true

  has_many :league_analyses

  after_create :fetch_currency_prices

  def self.current
    League.where(hardcore: false).order(start_date: :desc).first
  end

  # Only exalts for now
  def fetch_currency_prices
    currencies = [:exalted]
    puts "Fetching currency data for league #{self.name}"
    currencies_prices = currencies.map do |currency|
      league_data = PoeWatch::Item.find({ name: Regexp.new(currency.to_s, 'i') }).price_for_league(self.name)

      if league_data
        [currency.to_s, league_data.mode]
      end
    end.compact.to_h
    
    # Add base price which is chaos orbs
    currencies_prices[:chaos] = 1
    
    self.currencies_prices = currencies_prices
    self.save!
  end

end
