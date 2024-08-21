import { Controller } from "@hotwired/stimulus";
import { leave, toggle } from "el-transition";

export default class extends Controller {
  static targets = ["openMenu", "menu", "openMobileMenu", "mobileMenu"];

  connect() {
    this.openMenuTarget.addEventListener("click", (e) => {
      toggle(this.menuTarget);
    });

    this.openMobileMenuTarget.addEventListener("click", (e) => {
      toggle(this.mobileMenuTarget);
    });
  }
}
