class SessionsController < ApplicationController
  def new
  end

  def create
    # require "pry"; binding.pry
    redirect_to '/dashboard'
  end
end