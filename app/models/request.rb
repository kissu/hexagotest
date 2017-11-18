class Request < ApplicationRecord
  belongs_to :user
  enum status: { unconfirmed: 0, confirmed: 10, accepted: 20, expired: 30 }

  scope :unconfirmed, -> { where(status: 0) }
  scope :confirmed,   -> { where(status: 10) }
  scope :accepted,    -> { where(status: 20) }
  scope :expired,     -> { where(status: 30) }

  def self.accept!
    # more DRY but need to instanciate req to be able to use other methods...
    req = Request.new
    req.accept_new_user
    req.decrement_next_waiters
  end

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

end
