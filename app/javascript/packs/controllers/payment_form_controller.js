import { Controller } from "stimulus"
import Cleave from "cleave.js";

export default class extends Controller {
  static targets = [ "retention", "amount", "debt" ]

  calculateAmountToPay() {
    const cleaveRetention = new Cleave(this.retentionTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveAmount = new Cleave(this.amountTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveDebt = new Cleave(this.debtTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    const calculadedTotal = cleaveDebt.getRawValue() - cleaveRetention.getRawValue();

    if (isNaN(calculadedTotal) || calculadedTotal <= 0) {
      cleaveAmount.setRawValue(0);
    } else  {
      cleaveAmount.setRawValue(calculadedTotal);
    }
  }
}
