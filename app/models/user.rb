class User < ApplicationRecord
  has_one :request
  after_create :set_default_request

  validates :wait_order, numericality: { greater_than_or_equal_to: 0 },
    :allow_nil => true

  has_secure_password
  has_secure_token :confirmation_token

  validates :name, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ },
    uniqueness: { message: 'is already taken !' }, presence: true
  validates :phone_number, format: { with: /\A(0|\+33)[1-9]\d{8}$\z/ },
    presence: true
  validates :biography, presence: true, length: { minimum: 10,
    message: 'is a bit too short, tell us more about you !' }

 # ------------------------------------------------------

  def phone_number=(num)
    num.gsub!(/[^\d\+]/, '')
    super(num)
  end

  def set_default_request
    Request.create!(user: self, status: 'unconfirmed')
  end

  def nillify_wait_order
    update(wait_order: nil)
  end

  def nillify_confirmation_token
    update(confirmation_token: nil)
  end

end
