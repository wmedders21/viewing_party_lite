class UsersController < ApplicationController
  def dashboard
    @user = User.find(session[:user_id])
    @parties = @user.parties
    @movies = @parties.map {|party| MovieFacade.single_movie(party.name)}
    @images = @parties.map {|party| MovieFacade.single_movie_image(party.name)}
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

  # def login_form
  # end

  # def login_user
  #   user = User.find_by(email: user_params[:email])
  #   if user
  #     if user.authenticate(user_params[:password])
  #       session[:user_id] = user.id
  #       binding.pry
  #       redirect_to "/dashboard"
  #     else
  #       flash[:notice] = "Incorrect login credentials"
  #       redirect_to '/login'
  #     end
  #   else
  #     flash[:notice] = "User not found"
  #     redirect_to '/login'
  #   end
  # end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
