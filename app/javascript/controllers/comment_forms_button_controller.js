import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-forms-button"
export default class extends Controller {
  static targets = ['form', 'button']

  connect() {
    this.formTarget.classList.add('d-none')
  }
  toggleForm() {
    this.formTarget.classList.toggle('d-none')
    this.buttonTarget.textContent =
      this.formTarget.classList.contains('d-none') ? 'コメントする' : '閉じる'
  }
}
