namespace :poe_watch do
  desc "Refreshes all data from poe watch data"
  task refresh_data: :environment do
    RefreshPoeWatchDataJob.perform_later()
  end
end
