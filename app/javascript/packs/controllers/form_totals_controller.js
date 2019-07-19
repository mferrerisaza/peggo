import { Controller } from "stimulus"
import Cleave from "cleave.js";
import SlimSelect from 'slim-select'
import "slim-select/src/slim-select/slimselect.scss";

export default class extends Controller {

  static targets = ["subtotal", "retentionType", "retention"]

  calculateRetention() {
    const retentionType = this.retentionTypeTarget.value;
    const $retentionAmountInput = new Cleave(this.retentionTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });
    const $subtotalInput = new Cleave(this.subtotalTarget, {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });


    if(retentionType) {
      const retentionBase = parseFloat($subtotalInput.getRawValue());
      const retentionPct = parseFloat(retentionType.split("-")[1].replace("(", "").replace("%)", "")) / 100;
      const retentionAmount = retentionBase * retentionPct;
      $retentionAmountInput.setRawValue(retentionAmount);
    } else {
      $retentionAmountInput.setRawValue(0);
    }
  }

}
