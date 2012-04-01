class LanguagesController < ApplicationController

  before_filter :authenticate_user!


  def index
    @repos = current_user.watchings.group_by(&:language)
  end
  
  def show
    @repos = current_user.watchings.where(language: params[:id]).page(params[:page]).includes(:owner)
  end

end
