import { Controller } from "stimulus"
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { Spanish } from "flatpickr/dist/l10n/es.js"


export default class extends Controller {

  connect() {
    if (this.type === "expense") {
      this.mountExpenseFlatpickr()
    } else if (this.type === "invoice") {
      this.mountInvoiceFlatpickr()
    }
  }

  mountExpenseFlatpickr() {
    const dateInputExpense = flatpickr(this.element, {
      altInput: true,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      "locale": Spanish,
    });
  }

  mountInvoiceFlatpickr() {
    const dateInputInvoice = flatpickr(this.element, {
      altInput: true,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      "locale": Spanish,
      onChange: this.checkExpDate
    });
  }

  checkExpDate() {
    console.log(this.element.value);
  }

  get type() {
    return this.data.get("type");
  }

}
