import { Controller } from "stimulus"
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { Spanish } from "flatpickr/dist/l10n/es.js"


export default class extends Controller {

  connect() {
    this.mountFlatPickr()
  }

  mountFlatPickr() {
    const dateInputExpense = flatpickr(this.element, {
      altInput: true,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      "locale": Spanish,
    });
  }

}
