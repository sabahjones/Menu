class Purchase < ActiveRecord::Base
  belongs_to :order
  belongs_to :food

  validates :order, :food, presence: true
end
