class User < ApplicationRecord
  has_one :request, dependent: :destroy

  has_secure_password
  has_secure_token :confirmation_token

  validates :name, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ },
    uniqueness: { message: 'is already taken !' }, presence: true
  validates :phone_number, format: { with: /\A(0|\+33)[1-9]\d{8}$\z/ },
    presence: true
  validates :biography, presence: true, length: { minimum: 10,
    message: 'is a bit too short, tell us more about you !' }

  def phone_number=(num)
    num.gsub!(/[^\d\+]/, '')
    super(num)
  end
end
