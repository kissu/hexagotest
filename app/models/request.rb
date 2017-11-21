class Request < ApplicationRecord
  belongs_to :user, dependent: :destroy
  before_destroy :notify_user_expired

  enum status: { unconfirmed: 0, confirmed: 10, accepted: 20, need_refresh: 25,
    expired: 30 }

  scope :unconfirmed, -> { where(status:  0) }
  scope :confirmed,   -> { where(status: 10) }
  scope :accepted,    -> { where(status: 20) }
  scope :need_refresh,-> { where(status: 25) }
  scope :expired,     -> { where(status: 30) }

  def self.accept!
    req = Request.new
    req.accept_new_user
    req.decrement_next_waiters
  end

  def self.check_for_updates
    need_refresh.find_each {|r| r.notify_user_refresh } if update_to_refresh > 0
    expired.find_each { |r| r.notify_user_expired } if update_to_expired > 0
  end

  def self.update_to_refresh           # real value should be: 3.months.ago
    updated = Request.where("updated_at < ? and status = ?", 55555.minutes.ago, 10)
                     .update_all(status: 25, updated_at: DateTime.now)
  end

  def self.update_to_expired             # real value should be: 7.days.ago
    updated = Request.where("updated_at < ? and status = ?", 55555.minutes.ago, 25)
                     .update_all(status: 30, updated_at: DateTime.now)
  end

  # ------------------------------------------------------

  def accept!
    current_order = user.wait_order
    unless current_order.to_i.zero?
      accept_new_user(current_order)
      decrement_next_waiters(current_order)
    end
  end

  def accept_new_user(order_to_accept = 1)
    u = User.where(wait_order: order_to_accept)
    unless u.first.nil?
      u.update(wait_order: 0)
      u.first.request.update(status: 20)
    end
  end

  def decrement_next_waiters(from_nth_order = 1)
    # converting potential nil to 0 and test if 0 > 1, good to avoid errors
    User.where("CAST(wait_order AS INT) > ?", from_nth_order).find_each do |u|
      u.update_attributes(wait_order: u.wait_order - 1)
    end
  end

  def notify_user_refresh
    refresh_token = BCrypt::Password.create(SecureRandom.base64 30)
    user.update(confirmation_token: refresh_token)
    UserMailer.send_refresh_mail(user).deliver_later
    puts "Refresh mail sent to #{user.name} !"
  end

  def notify_user_expired
    decrement_next_waiters(user.wait_order)
    user.nillify_wait_order
    user.nillify_confirmation_token
    UserMailer.send_expired_mail(user).deliver_later
    puts "#{user.name}'s account has expired, wait_order = nil !"
  end

  def remaining_time_before_expiration
    limit = Time.now.strftime("%d").to_i + 7
    last_update = updated_at.strftime("%d").to_i
    limit - last_update
  end

end
