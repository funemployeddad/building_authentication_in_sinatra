class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "whatever"
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end

    def logged_in?
      !!current_user
    end

    #check if a user with this email actually exists
    # if so, set the sessions, otherwise redirect to login
    def login(email, password)
        user = User.find_by(:email => email)
      if user && user.authenticate(password)
        session[:email] = user.email
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
      redirect '/posts'
    end
  end

end
