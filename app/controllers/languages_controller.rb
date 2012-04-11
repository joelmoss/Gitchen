class LanguagesController < ApplicationController

  before_filter :authenticate_user!


  def index
    @languages = current_user.watchings.select('repos.language, COUNT(repos.id) AS repos').
                              page(params[:page]).group(:language).order(params[:order] ||= 'repos.language ASC')
  end

  def show
    language = params[:id] == 'other' ? nil : params[:id]
    params[:order] ||= 'repos.watchers_count DESC'
    @repos = current_user.watches.where('repos.language' => language).page(params[:page]).includes(watching: :owner).order(params[:order])
  end

end
