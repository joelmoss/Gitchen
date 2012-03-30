class DashboardsController < ApplicationController

  def index
    @repos = current_user.watchings.page(params[:page]) if signed_in?
  end

end
