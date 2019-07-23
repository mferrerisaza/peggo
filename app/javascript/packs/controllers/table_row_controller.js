import { Controller } from "stimulus"

export default class extends Controller {

  visitLocation() {
    Turbolinks.visit(this.location)
  }

  get location() {
    return this.data.get("location");
  }
}
