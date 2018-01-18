class Course < ActiveRecord::Base
  has_many :foods

  validates :category, presence: true
  validates :category, uniqueness: { case_sensitive: false }
end
