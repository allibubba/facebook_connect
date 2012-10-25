class OauthController < ApplicationController
  
  def callback

    access_token = params[:accessToken]
    auth = FbGraph::Auth.new(CLIENT_ID, CLIENT_SECRET)
    # exchange for extended token
    auth.exchange_token! access_token
    auth.access_token
    fbuser = FbGraph::User.me(auth.access_token).fetch

    # new user? create one
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
    
    # update session, you're probably gonna need it
    session[:user_id] = fbuser.identifier
    
    # return user data as json response    
    render :json => user.to_json(:only => [:fbid, :name_first, :name_last])
  end

end
