class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :resource

  validates :user_id, uniqueness: { scope: :resource_id, message: "has already wishlisted this resource" } # Ensures a user can only have one entry per resource
end
