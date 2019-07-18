import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["addConcept", "template"]

  add_association(event) {
    event.preventDefault();
    const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Date.now()));
    this.addConceptTarget.insertAdjacentHTML("beforeend", content);
  }

  remove_association(event) {
    event.preventDefault();
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}
