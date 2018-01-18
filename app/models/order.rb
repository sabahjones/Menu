class Order < ActiveRecord::Base
  belongs_to :user
  has_many :purchases
  has_many :foods, through: :purchases

  validates :order_num, :total, :user, presence: true
  validates :order_num, :total, numericality: { greater_than: 0 }
  validates :tip, numericality: { greater_than_or_equal_to: 0 }
  validates :total, numericality: { less_than: 10000 }


end
