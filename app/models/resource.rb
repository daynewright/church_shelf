class Resource < ApplicationRecord
  validates :title, presence: :true
  validates :available_copies, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: ->(resource) { resource.total_copies }
  }

  has_many :reviews, dependent: :destroy
  has_one_attached :image
  belongs_to :category

  def update_rating!
    self.rating = reviews.average(:rating).to_f.round(1)
    save
  end
end
