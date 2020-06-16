class PagesController < ApplicationController
  def home
    redirect_to campaigns_path if user_signed_in? && current_user.campaigns.count > 0
  end
end
