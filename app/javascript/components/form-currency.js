function replaceFormat(input) {
  input.value = parseFloat(input.value.replace(/,/g, ""))
                                        .toFixed(2)
                                          .toString()
                                            .replace(/\B(?=(\d{3})+(?!\d))/g, ",");

}

function addKeyPressListener(currencyInput) {
  currencyInput.addEventListener("blur", (event) => {
    replaceFormat(event.currentTarget);
  })
}


document.addEventListener("DOMContentLoaded", () => {
  const currencyInput = document.getElementById("budget_amount");
  if (currencyInput) {
    addKeyPressListener(currencyInput)
    replaceFormat(currencyInput)
  }
})
