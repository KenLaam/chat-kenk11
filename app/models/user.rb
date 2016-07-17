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

  def self.from_facebook(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email,
                 name: auth[:info][:name],
                 password_digest: SecureRandom.urlsafe_base64).first_or_initialize
    #
    # Set other properties on user here.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user.save && user
  end
end
