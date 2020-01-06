class DashboardController < ApplicationController
  def analyses
    @analyses = current_user.analyses.includes(:season_analyses)
  end

  def poe_trade_enhancer_integration
  end
end
