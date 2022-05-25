class UsersController < ApplicationController
  def dashboard
    if session[:user_id]
      @user = User.find(session[:user_id])
      @parties = @user.parties
      @movies = @parties.map {|party| MovieFacade.single_movie(party.name)}
      @images = @parties.map {|party| MovieFacade.single_movie_image(party.name)}
    else
      flash[:message] = 'Must be logged in to access dashboard'
      redirect_to '/'
    end
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:notice] = "#{user.errors.full_messages.to_sentence}"
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(session[:user_id])
  end

  def results
    @movie_list = MovieFacade.movie_list(params[:q])
  end

  def details
    @movie_details = MovieFacade.single_movie(params[:id])
    @single_movie_credits = MovieFacade.single_movie_credits(params[:id])
    @single_movie_reviews = MovieFacade.single_movie_reviews(params[:id])
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
