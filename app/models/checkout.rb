class Checkout < ApplicationRecord
  belongs_to :user
  belongs_to :resource

  validates :checkout_date, :return_date, presence: true

  scope :active_checkouts_for_user, ->(user_id) {
    where("checkout_date <= ? AND return_date > ? AND returned = ? AND user_id = ?", Date.today, Date.today, false, user_id)
      .order(:checkout_date)
  }
  scope :over_due_checkouts_for_user, ->(user_id) {
    where("return_date < ? AND returned = ? AND user_id = ?", Date.today, false, user_id)
      .order(:return_date)
  }

  after_create :update_resource_availability

  def quantity_within_available_copies
    if quantity > resource.available_copies || quantity > 0
      errors.add(:quantity, "cannot exceed available copies")
    end
  end

  def update_resource_availability
    resource.checkout!(quantity)
  end

  def returned?
    return_date.present?
  end
end
