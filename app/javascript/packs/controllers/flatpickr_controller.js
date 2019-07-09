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
    const $expDateInput = document.querySelector(".expiration-date");

    if (this.element.value === "") {
      const dateInputInvoice = flatpickr($expDateInput)
      dateInputInvoice.destroy();
      $expDateInput.classList.remove("datepicker-expense");
      $expDateInput.value = "";
      $expDateInput.disabled = true;
    } else {
      const invoiceDate = new Date(this.element.value);
      $expDateInput.disabled = false;
      $expDateInput.classList.add("datepicker-expense");

      const dateInputInvoice = flatpickr($expDateInput, {
        defaultDate: invoiceDate.fp_incr(30),
        minDate: invoiceDate,
        altInput: true,
        altFormat: "d-m-Y",
        dateFormat: "Y-m-d",
        "locale": Spanish
      });
    }


  }

  get type() {
    return this.data.get("type");
  }

}
