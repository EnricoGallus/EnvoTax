import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reference-selector"
export default class extends Controller {
  static targets = ["type", "id"]
  connect() {}

  update(event) {
    const [type, id] = event.target.value.split("_")
    this.typeTarget.value = type
    this.idTarget.value = id
  }
}
