class ReposController < ApplicationController

  before_filter :authenticate_user!
  before_filter :fetch_repo, only: [ :show, :unwatch ]

  rescue_from ActiveRecord::RecordNotFound do
    begin redirect_to(:back) rescue redirect_to(repos_url) end
  end


  def index
    respond_to do |wants|
      wants.html do
        @repos = current_user.watches.includes(watching: :owner).page(params[:page]).order(params[:order] ||= 'repos.watchers_count DESC')
      end
      wants.js do
        render json: { success: current_user.watchings.count > 0 }
      end
    end
  end

  def show
    render layout: false
  end

  def unwatch
    current_user.watches.unwatch @repo
  end

  def update
    @repo = current_user.watches.where(repo_id: params[:id]).first
    raise ActiveRecord::RecordNotFound if @repo.blank?

    @repo.update_attributes params[:watch]
    render nothing: true, layout: false
  end


  private

    def fetch_repo
      @repo = current_user.watchings.joins(:owner).where(name: params[:id], 'users.username' => params[:owner]).first
      raise ActiveRecord::RecordNotFound if @repo.blank?
    end

end
