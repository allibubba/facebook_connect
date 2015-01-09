##
# interact with facebook

class OauthController < ApplicationController
  
  ##
  # exchanges facebook token for extended token
  # creates new user or updates user with new token

  def callback

    access_token = params[:accessToken]
    auth = FbGraph::Auth.new(
      Rails.application.secrets.facebook['app_id'],
      Rails.application.secrets.facebook['app_secret']
    )
    auth.exchange_token! access_token
    auth.access_token
    fbuser = FbGraph::User.me(auth.access_token).fetch
    if User.find_by_fbid(params[:userID]).nil?
      user = User.create(
        :fbid      => fbuser.identifier,
        :name_first => fbuser.first_name,
        :name_last  => fbuser.last_name,
        :email      => fbuser.email,
        :token  => auth.access_token.to_s
      ) 
    else
      user = User.find_by_fbid(fbuser.identifier)
      user.token = auth.access_token.to_s
      user.save
    end
    
    session[:user_id] = fbuser.identifier
    
    render :json => user.to_json(:only => [:fbid, :name_first, :name_last])
  end

end
