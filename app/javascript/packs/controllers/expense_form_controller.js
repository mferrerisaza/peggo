import { Controller } from "stimulus"
import Cleave from "cleave.js";

export default class extends Controller {
  static targets = [ "row", "quantity", "price", "vat", "discount", "total"]

  calculateTotals() {
    const totals = this.calculateAllTotals()
    const $subtotalInput = document.getElementById("expense_subtotal");
    const $retentionInput = document.getElementById("expense_retention");
    const $vatInput = document.getElementById("expense_vat");
    const $totalInput = document.getElementById("expense_total");

    const cleaveSubtotal = new Cleave($subtotalInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveRetention = new Cleave($retentionInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveVat = new Cleave($vatInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveTotal = new Cleave($totalInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    cleaveSubtotal.setRawValue(totals.grossSubtotal);
    cleaveVat.setRawValue(totals.totalVAT);
    cleaveTotal.setRawValue(totals.grandTotal);
  }

  calculateAllTotals() {
    let grossSubtotal = 0;
    let retention = 0;
    let totalVAT = 0;
    let grandTotal = 0;
    let totals = {};

    for (let i = 0; i < this.rowTargets.length; i++) {
      if (this.rowTargets[i].getAttribute("style") !== "display: none;") {
        const quantity = this.rowTargets[i].querySelector(".concept-quantity").value;
        const cleavePrice = new Cleave(this.rowTargets[i].querySelector(".concept-price"), {
            numeral: true,
            numeralThousandsGroupStyle: 'thousand'
        });
        const vat = parseFloat(this.rowTargets[i].querySelector(".concept-vat").value);
        const price = cleavePrice.getRawValue();

        grossSubtotal += quantity * price;
        totalVAT += quantity * price * vat;
      }
    }
    const cleaveRetention = new Cleave(document.getElementById("expense_retention"), {
        numeral: true,
        numeralThousandsGroupStyle: 'thousand'
    });

    retention = cleaveRetention.getRawValue();

    grandTotal = grossSubtotal + totalVAT - retention;

    totals = {
      grossSubtotal,
      totalVAT,
      grandTotal
    }

    return totals
  }

  setCalulationsTimer() {
    setTimeout(() => { this.calculateTotals() }, 100);
  }

}
