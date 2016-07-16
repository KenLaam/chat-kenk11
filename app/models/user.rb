class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}, uniqueness: true
  validates :email, :name, :password, presence: true

  def received_messages
    Message.where(recipient: self)
  end

  def sent_messages
    Message.where(sender: self)
  end

  def unread_messages
    received_messages.unread
  end

  # and you can "chain" methods to load n newest received messages
  def latest_received_messages
    received_messages.order(created_at: :desc)
  end
end
