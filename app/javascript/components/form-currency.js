// function replaceFormat(input) {
//   input.value = parseFloat(input.value.replace(/,/g, ""))
//                                         .toFixed(2)
//                                           .toString()
//                                             .replace(/\B(?=(\d{3})+(?!\d))/g, ",");

// }

// function addKeyPressListener(currencyInput) {
//   currencyInput.addEventListener("keydown", (event) => {
//     replaceFormat(event.currentTarget);
//   })
// }

import Cleave from "cleave.js";

document.addEventListener("DOMContentLoaded", () => {
  const $amountInput = document.querySelector(".amount-input");
  if($amountInput) {
    const cleave = new Cleave('.amount-input', {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

  }
})

