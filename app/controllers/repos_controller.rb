class ReposController < ApplicationController

  before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    begin redirect_to(:back) rescue redirect_to(repos_url) end
  end


  def index
    respond_to do |wants|
      wants.html do
        @repos = current_user.watchings.page(params[:page]).includes(:owner)
      end
      wants.js do
        render json: { success: current_user.watchings.count > 0 }
      end
    end
  end

  def show
    @repo = current_user.watchings.joins(:owner).where(name: params[:id], 'users.username' => params[:owner]).first
    raise ActiveRecord::RecordNotFound if @repo.blank?

    render layout: false
  end

end
