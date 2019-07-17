import { Controller } from "stimulus"
import Cleave from "cleave.js";


export default class extends Controller {
  static targets = [ "retention", "amount", "total" ]

  calculateAmountToPay() {
    const cleaveRetention = new Cleave(this.retentionTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveAmount = new Cleave(this.amountTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveTotal = new Cleave(this.totalTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const calculadedTotal = cleaveAmount.getRawValue() - cleaveRetention.getRawValue();

    if (isNaN(calculadedTotal) || calculadedTotal <= 0) {
      cleaveTotal.setRawValue(0);
    } else  {
      cleaveTotal.setRawValue(calculadedTotal);
    }
  }
}
