class Admin < ActiveRecord::Base
  belongs_to :user
  has_many :foods

  validates :user, presence: true, uniqueness: true

end
