class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  has_one :admin
  has_many :foods, through: :admin
  has_many :orders
  has_many :purchases, through: :orders

  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false}, format: { with: EMAIL_REGEX }, length: { maximum: 40 }
  validates :name, length: { minimum: 2, maximum: 10 }

  before_save :downcase_email


  private
    def downcase_email
      self.email.downcase!
    end
end
