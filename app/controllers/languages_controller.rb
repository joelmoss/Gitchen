class LanguagesController < ApplicationController

  before_filter :authenticate_user!


  def index
    @languages = current_user.watchings.select('repos.language, COUNT(repos.id) AS repos').
                              page(params[:page]).group(:language).order('repos DESC, language')
  end
  
  def show
    language = params[:id] == 'other' ? nil : params[:id]
    @repos = current_user.watchings.where(language: language).page(params[:page]).includes(:owner)
  end

end
