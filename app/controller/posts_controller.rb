class PostsController < ApplicationController

  get '/posts' do
    "A list of publically available posts"
  end

  get '/posts/new' do
    if !logged_in? #checks if logged in
      redirect "/login"  #redirecting if they aren't
    else
      "A new post form" #rendering if they are
    end
  end

  get '/posts/:id/edit' do
    if !logged_in?                  #checks if logged in
      redirect "/login"             #redirecting if they aren't
    else             # find the post that the author user is allowed to edit
      if post = current_user.posts.find(params[:id])
      "User #{current_user.id} is editing post #{post.id}"
      else
        redirect '/posts'
      end
    end
  end
end
