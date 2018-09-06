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
