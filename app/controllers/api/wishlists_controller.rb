module Api
    class WishlistsController < ApplicationController
      protect_from_forgery with: :null_session

      # POST /wishlists
      def create
        @wishlist = Wishlist.create!(wishlist_params)
        render json: @wishlist, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      # DELETE /wishlists/:id
      def destroy
        @wishlist = Wishlist.find(params[:id])
        @wishlist.destroy
        head :no_content
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Wishlist item not found" }, status: :not_found
      end

      private

      def wishlist_params
        params.require(:wishlist).permit(:user_id, :resource_id)
      end
    end
end
