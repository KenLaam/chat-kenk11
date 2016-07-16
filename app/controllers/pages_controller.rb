class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
  end

  def friends

  end
end
