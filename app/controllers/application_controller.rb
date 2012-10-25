class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'pp'

  layout 'application'

  before_filter :set_locale, :authenticate

  def set_locale
    I18n.locale = session[:locale] || params[:locale] || I18n.default_locale
  end


  protected
  
    def is_facebook?(_ip)
      require "ipaddr"
      low  = IPAddr.new("66.220.144.0").to_i
      high = IPAddr.new("66.220.159.255").to_i
      ip   = IPAddr.new(_ip).to_i
      (low..high)===ip
    end

    def authenticate
      if Rails.env == 'staging' && !is_facebook?(request.remote_ip)
        authenticate_or_request_with_http_basic do |username, password|
          username == "roundhouse" && password == "do not use"
        end
      end  
    end

end