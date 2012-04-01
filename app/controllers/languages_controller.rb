class LanguagesController < ApplicationController

  before_filter :authenticate_user!


  def index
    @repos = current_user.watchings.group_by(&:language)
  end
  
  def show
    language = params[:id] == 'other' ? nil : params[:id]
    @repos = current_user.watchings.where(language: language).page(params[:page]).includes(:owner)
  end

end
