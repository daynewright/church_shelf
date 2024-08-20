class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def create
      resource = Resource.find(checkout_params[:resource_id])
      quantity = checkout_params[:quantity].to_i

      if quantity > resource.available_copies
        flash[:alert] = "Not enough copies available."
        redirect_to resource_path(resource.id) and return
      end

      @checkout = current_user.checkouts.new(
        resource: resource,
        quantity: quantity,
        checkout_date: checkout_params[:checkout_date],
        return_date: checkout_params[:return_date]
      )

      if @checkout.quantity_within_available_copies
        if @checkout.save
          redirect_to checkouts_path, notice: "Resource checked out successfully!"
        else
          flash[:alert] = "Something went wrong checking out this resource."
          redirect_to resource_path(resource.id)
        end
      else
        flash[:alert] = "Unable to checkout that quantity. Please try again."
        redirect_to resource_path(resource.id)
      end
    end

    def index
        @checkouts_active = Checkout.active_checkouts_for_user(current_user)
        @checkouts_due = Checkout.over_due_checkouts_for_user(current_user)
    end

    def return
      @checkout = Checkout.find(params[:id])

      if @checkout.update(returned: true)
        if @checkout.resource.return!(@checkout.quantity)
          flash[:notice] = "Resource successfully returned!"
        else
          flash[:alert] = "Unable to update resource availability. Try again later."
        end
      else
        flash[:alert] = "Unable to return this resource. Try again later."
      end

      redirect_to checkouts_path
    end

    private

    def checkout_params
      params.permit(
        :checkout_date,
        :return_date,
        :quantity,
        :resource_id
      )
    end
end
