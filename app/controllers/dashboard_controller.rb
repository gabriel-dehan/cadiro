class DashboardController < ApplicationController
  def analyses
    @analyses = current_user.analyses.includes(:league_analyses)
  end

  def poe_trade_enhancer_integration
  end

  def generate_pte
    @pte = File.read(Rails.root.join('lib', 'poe_trade_enhancer', 'pte.js'))
    @pte.gsub!('<<#sed:poe_auth_token>>', current_user.token)
    @pte.gsub!('<<#sed:poe_url>>', root_url)
    
    file_name = "poe-trade-official-site-enhancer-with-economy.id-#{current_user.id}.user.js"
    tempfile = Tempfile.new(file_name, Rails.root.join('tmp'))
    tempfile.binmode
    tempfile.write @pte
    tempfile.rewind

    current_user.pte_script = tempfile
    current_user.save!
    
    tempfile.close
    tempfile.unlink

    flash[:notice] = "Script generated, you can now install it by clicking the link"
    redirect_to pte_integration_path
  end
end
