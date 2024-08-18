import { Controller } from "@hotwired/stimulus";
import { leave, toggle } from "el-transition";

export default class extends Controller {
  static targets = ["openMenu", "menu"];

  connect() {
    this.openMenuTarget.addEventListener("click", (e) => {
      toggle(this.menuTarget);
    });
  }
}
