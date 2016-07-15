class User < ApplicationRecord
  has_secure_password
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}, uniqueness: true
  validates :email, :name, :password, presence: true

  def received_messages
    where(recipient: self)
  end

  def sent_messages
    where(sender: self)
  end

  def unread_messages
    received_messages.unread
  end

  # and you can "chain" methods to load n newest received messages
  def latest_received_messages(n)
    received_messages.order(created_at: :desc).limit(n)
  end
end
