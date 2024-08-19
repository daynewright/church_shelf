import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["openMenu", "menu"];

  connect() {}

  async updateWishlist() {
    const userId = this.element.dataset.userId;

    if (userId === "") {
      const signInPath = this.element.dataset.signInPath || "/";
      return window.location.replace(signInPath);
    }

    const addedToWishList = this.element.dataset.wishlistStatus === "true";
    const resourceId = this.element.dataset.resourceId;
    const wishlistId = this.element.dataset.wishlistId;

    if (addedToWishList) {
      try {
        await deleteWishlist(wishlistId);
        this.element.classList.remove("text-yellow-500");
        this.element.classList.remove("stroke-yellow-700");

        this.element.classList.add("text-gray-500");
        this.element.classList.add("stroke-slate-700");

        this.element.dataset.wishlistStatus = "false";
        this.element.dataset.wishlistId = "";
      } catch (e) {
        console.log(e);
      }
    } else {
      try {
        const resp = await postWishlist(userId, resourceId);
        const wishlistData = await resp.json();

        this.element.classList.remove("text-gray-500");
        this.element.classList.remove("stroke-slate-700");

        this.element.classList.add("text-yellow-500");
        this.element.classList.add("stroke-yellow-700");

        this.element.dataset.wishlistStatus = "true";
        this.element.dataset.wishlistId = wishlistData.id;
      } catch (e) {
        console.log(e);
      }
    }
  }
}

const postWishlist = async (userId, resourceId) => {
  return fetch("/api/wishlists", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      user_id: userId,
      resource_id: resourceId,
    }),
  });
};

const deleteWishlist = async (wishlistId) => {
  return fetch(`/api/wishlists/${wishlistId}`, {
    method: "DELETE",
  });
};
