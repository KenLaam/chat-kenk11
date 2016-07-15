class PagesController < ApplicationController
  def index
    if signed_in?
      redirect_to users_path
    end
  end
end
