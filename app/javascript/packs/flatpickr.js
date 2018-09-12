import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { Spanish } from "flatpickr/dist/l10n/es.js"


const dateInput = flatpickr(".datepicker", {
  // minDate: false,
  altInput: true,
  altFormat: "M Y",
  dateFormat: "Y-m-d",
  "locale": Spanish,
});

const dateInputBill = flatpickr(".datepicker-bill", {
  // minDate: false,
  altInput: true,
  altFormat: "M Y",
  dateFormat: "Y-m",
  "locale": Spanish,
});


