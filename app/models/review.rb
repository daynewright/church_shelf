class Review < ApplicationRecord
  validates :comment, presence: true
  validates :rating, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  belongs_to :resource
  belongs_to :user

  after_save :update_resource_rating
  after_destroy :update_resource_rating

  private

  def update_resource_rating
    resource.update_rating!
  end
end
