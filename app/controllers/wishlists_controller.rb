class WishlistsController < ApplicationController
    def index
        @resources = current_user.wishlisted_resources
    end
end