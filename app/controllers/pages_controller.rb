class PagesController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
  end

  def friends
  end

  def sent
    @messages = current_user.sent_messages.order(recipient_id: :asc)
  end

end
