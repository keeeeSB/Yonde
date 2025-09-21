import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="children"
export default class extends Controller {
  static targets = ["container"]

  add(event) {
    event.preventDefault()
    const content = this.element.dataset.template
    const newId = new Date().getTime()
    const newContent = content.replace(/NEW_RECORD/g, newId)
    this.containerTarget.insertAdjacentHTML("beforeend", newContent)
  }

  remove(event) {
    event.preventDefault()
    const field = event.target.closest(".nested-fields")
    if (field) field.remove()
  }
}
