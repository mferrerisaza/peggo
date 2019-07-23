import { Controller } from "stimulus"
import Cleave from "cleave.js";

export default class extends Controller {
  static targets = [ "row", "quantity", "price", "vat", "discount", "total"]

  calculateTotals() {
    const totals = this.calculateAllTotals()
    const $grossTotalInput = document.getElementById("invoice-gross-total");
    const $discountInput = document.getElementById("invoice-total-discount");
    const $netTotalInput = document.getElementById("invoice-net-total");
    const $totalVatInput = document.getElementById("invoice-total-vat");
    const $grandTotalInput = document.getElementById("invoice-grand-total");

    const cleaveGrossTotal = new Cleave($grossTotalInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveTotalDiscount = new Cleave($discountInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveNetTotal = new Cleave($netTotalInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveTotalVAT = new Cleave($totalVatInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    const cleaveGrandTotal = new Cleave($grandTotalInput, {
      numeral: true,
      numeralThousandsGroupStyle: 'thousand'
    });

    cleaveGrossTotal.setRawValue(totals.grossSubtotal);
    cleaveTotalDiscount.setRawValue(totals.itemsDiscount);
    cleaveNetTotal.setRawValue(totals.netSubtotal);
    cleaveTotalVAT.setRawValue(totals.totalVAT);
    cleaveGrandTotal.setRawValue(totals.grandTotal);
  }

  calculateAllTotals() {
    let grossSubtotal = 0;
    let itemsDiscount = 0;
    let netSubtotal = 0;
    let totalVAT = 0;
    let grandTotal = 0;
    let totals = {};

    for (let i = 0; i < this.rowTargets.length; i++) {
      if (this.rowTargets[i].getAttribute("style") !== "display: none;") {
        const quantity = this.rowTargets[i].querySelector(".item-quantity").value;
        const cleavePrice = new Cleave(this.rowTargets[i].querySelector(".item-price"), {
            numeral: true,
            numeralThousandsGroupStyle: 'thousand'
        });
        const discount = parseFloat(this.rowTargets[i].querySelector(".item-discount").value);
        const vat = parseFloat(this.rowTargets[i].querySelector(".item-vat").value);
        const price = cleavePrice.getRawValue();

        grossSubtotal += quantity * price;
        itemsDiscount -= quantity * price * discount;
        totalVAT += quantity * price * (1 - discount) * vat;
      }
    }
    netSubtotal = grossSubtotal + itemsDiscount;
    grandTotal = netSubtotal + totalVAT;

    totals = {
      grossSubtotal,
      itemsDiscount,
      netSubtotal,
      totalVAT,
      grandTotal
    }

    return totals
  }

  setCalulationsTimer() {
    setTimeout(() => { this.calculateTotals() }, 100);
  }

}
