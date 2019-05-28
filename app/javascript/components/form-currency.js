import Cleave from "cleave.js";

document.addEventListener("DOMContentLoaded", () => {
  const $amountInput = document.querySelector(".amount-input");
  if($amountInput) {
    const cleave = new Cleave('.amount-input', {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
    });

  }
})

