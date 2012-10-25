class CoreController < ApplicationController
  
  def index
  end

  def locale
    locales =  Locale.all
    session[:locale] = (locales.has_key?(params[:locale].to_sym)) ? params[:locale] : 'en_US'
    redirect_to root_url
  end
end
