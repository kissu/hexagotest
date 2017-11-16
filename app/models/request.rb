class Request < ApplicationRecord
  belongs_to :user

  enum status: { unconfirmed: 0, confirmed: 10, accepted: 20, expired: 30 }
end
