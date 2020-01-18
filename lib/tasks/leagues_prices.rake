namespace :leagues_prices do
  desc "Refreshes league currency prices"
  task refresh: :environment do
    RefreshLeaguesPricesJob.perform_later()
  end
end
