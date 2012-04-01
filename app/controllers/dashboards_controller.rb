class DashboardsController < ApplicationController

  def index
    @repos = current_user.watchings.page(params[:page]).includes(:owner) if signed_in?
  end

end
