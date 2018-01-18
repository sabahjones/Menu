class Food < ActiveRecord::Base
  belongs_to :admin
  belongs_to :course
  has_many :purchases
  has_many :orders, through: :purchases

  validates :name, :description, :price, :admin, :course, presence: true
  validates :name, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 30 }
  validates :description, length: { minimum: 8 }
  validates :price, numericality: { greater_than: 0, less_than: 1000}


    def count array
      array.count(self)
    end
    def item_total array
      array.count(self) * self.price
    end

end
