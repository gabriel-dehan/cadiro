class RefreshPoeWatchDataJob < ApplicationJob
  queue_as :default

  def perform()
    PoeWatch::Api.refresh!
  end
end
