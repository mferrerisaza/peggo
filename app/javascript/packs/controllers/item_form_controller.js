import { Controller } from "stimulus"
import Cleave from "cleave.js";

export default class extends Controller {
  static targets = [ "quantity", "price", "vat", "discount", "total"]

  recalculateTotal() {
    const cleavePrice = new Cleave(this.priceTarget, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
    });

    const cleaveTotal = new Cleave(this.totalTarget, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
    });

    const calculadedTotal = this.quantityTarget.value * cleavePrice.getRawValue() * (1 + parseFloat(this.vatTarget.value)) * (1 - parseFloat(this.discountTarget.value))

    if (isNaN(calculadedTotal)) {
      this.totalTarget.value = "";
    } else  {
      cleaveTotal.setRawValue(calculadedTotal);
    }
  }

}
