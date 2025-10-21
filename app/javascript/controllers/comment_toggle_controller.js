import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-toggle"
export default class extends Controller {
    static targets = ['display', 'form', 'button']

  connect() {
      this.formTarget.classList.add("d-none")
  }

    toggleForm() {
        this.displayTarget.classList.toggle("d-none")
        this.formTarget.classList.toggle("d-none")
        this.buttonTarget.textContent =
            this.formTarget.classList.contains("d-none") ? "編集" : "閉じる"
    }
}
