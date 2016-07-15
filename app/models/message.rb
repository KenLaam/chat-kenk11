class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  scope :unread, -> { where(read_at: nil) }

  def mark_as_read!
    message.read_at = Time.now
    message.save!
  end
end