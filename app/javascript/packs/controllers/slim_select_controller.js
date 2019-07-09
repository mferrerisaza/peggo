import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
import "slim-select/src/slim-select/slimselect.scss";
import Cleave from "cleave.js";


export default class extends Controller {

  connect() {
    this.mountSlimSelect()
  }

  mountSlimSelect() {
    const selectType = this.data.get("type");

    if (selectType === "contactSelect") {
      new SlimSelect({
        select: this.element
      })
    } else if (selectType === "itemSelector") {
      const fetchUrl = this.data.get("fetchUrl");

      new SlimSelect({
        select: this.element,
        placeholder: 'Busca o Agrega un Item',
        searchingText: 'Buscando...', // Optional - Will show during ajax request
        addable: value => value,
        ajax: (search, callback) => {

          if (search.length < 1) {
            callback(false)
            return
          }

          fetch(`${fetchUrl}?query=${search}`)
          .then(response => response.json())
          .then((data) => {
            let json = []

            for (let i = 0; i < data.length; i++) {
              json.push({
                text: data[i].name,
                data: {
                  quantity: data[i].quantity,
                  price: data[i].price_cents / 100,
                  vat: data[i].vat,
                  discount: data[i].discount
                }
              })
            }
            callback(json)
          })
          .catch((error) => {
            callback(false)
          })
        },
        onChange: (selectedValue) => {
          if (Object.keys(selectedValue.data).length > 0) {
            const $itemRow = this.element.parentElement.parentElement.parentElement;
            const $quantity = $itemRow.querySelector(".item-quantity");
            const $price = new Cleave($itemRow.querySelector(".item-price"), {
                numeral: true,
                numeralThousandsGroupStyle: 'thousand'
            });
            const $vat = $itemRow.querySelector(".item-vat");
            const $discount = $itemRow.querySelector(".item-discount");
            const $total = new Cleave($itemRow.querySelector(".item-total"), {
                numeral: true,
                numeralThousandsGroupStyle: 'thousand'
            });

            $quantity.value = selectedValue.data.quantity;
            $price.setRawValue(selectedValue.data.price);
            $vat.value = selectedValue.data.vat;
            $discount.value = selectedValue.data.discount
            $total.setRawValue(selectedValue.data.quantity * selectedValue.data.price * (1 + parseFloat(selectedValue.data.vat)) * (1 - parseFloat(selectedValue.data.discount)));
            $quantity.focus();
          }
        }
      })
    } else if (selectType === "paymentContactSelect") {

      const $invoiceFormGroup = document.querySelector(".payment_invoice");
      const $conceptInput = document.querySelector(".payment_description input");
      const $retentionTypeSelect = document.querySelector(".payment_retention_type select");
      const $invoiceInfoTable = document.getElementById("invoice-info-table").parentElement;
      const $amount = new Cleave(document.querySelector(".payment_amount input"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });
      const $retentionAmount = new Cleave(document.querySelector(".payment_retention input"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });

      const $invoiceTotalInput = new Cleave(document.querySelector("#invoice-info-table .invoice-total"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });

      const $invoicePaidInput = new Cleave(document.querySelector("#invoice-info-table .invoice-paid"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });

      const $invoiceRetainedInput = new Cleave(document.querySelector("#invoice-info-table .invoice-retained"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });

      const $invoiceDebtInput = new Cleave(document.querySelector("#invoice-info-table .invoice-debt"), {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });

      new SlimSelect({
        select: this.element,
        onChange: (selectedOption) => {
          let url = this.data.get("fetchInvoicesUrl");
          url = `${url}/${selectedOption.value}/invoices`;
          fetch(url)
          .then(response => response.json())
          .then((data) => {

            $amount.setRawValue(0);
            $invoiceFormGroup.classList.add("hidden");
            $conceptInput.value = "";
            delete $retentionTypeSelect.dataset.slimSelectRetentionBase;
            $retentionAmount.setRawValue(0);
            $retentionTypeSelect.slim.set("");
            $invoiceInfoTable.classList.add("hidden")

            if(data.length > 0) {
              let json = [];

              json.push( {text: "", data: { placeholder: true } } )

              for (let i = 0; i < data.length; i++) {
                if (data[i].status === "Por Cobrar") {
                  json.push({
                    text: data[i].name,
                    value: data[i].id,
                    data: {
                      debt: parseInt(data[i].debt.fractional) / 100,
                      retentionbase: parseInt(data[i].items_gross_subtotal.fractional) / 100,
                      paid: parseInt(data[i].amount_paid.fractional) / 100,
                      retention: parseInt(data[i].amount_retained.fractional) / 100,
                      total: parseInt(data[i].total.fractional) / 100
                    }
                  })
                }
              }

              const invoiceSelect = new SlimSelect({
                select: '.payment_invoice select',
                placeholder: "No Asociar",
                allowDeselect: true,
                deselectLabel: '<span style="color: red">✖</span>',
                onChange: (invoiceOption) => {
                  delete $retentionTypeSelect.dataset.slimSelectRetentionBase;
                  $retentionAmount.setRawValue(0);
                  $retentionTypeSelect.slim.set("");
                  $amount.setRawValue(0);
                  $conceptInput.value = "";
                  $invoiceInfoTable.classList.add("hidden")

                  if (Object.keys(invoiceOption.data).length > 1) {
                    $invoiceTotalInput.setRawValue(invoiceOption.data.total);
                    $invoicePaidInput.setRawValue(invoiceOption.data.paid);
                    $invoiceRetainedInput.setRawValue(invoiceOption.data.retention);
                    $invoiceDebtInput.setRawValue(invoiceOption.data.debt);
                    $amount.setRawValue(invoiceOption.data.debt);
                    $conceptInput.value = `Pago ${invoiceOption.text}`;
                    $retentionTypeSelect.dataset.slimSelectRetentionBase = invoiceOption.data.retentionbase;
                    $invoiceInfoTable.classList.remove("hidden")
                  }
                }
              })

              invoiceSelect.setData(json)
              if (json.length > 1) {
                $invoiceFormGroup.classList.remove("hidden");
              }
            }
          })
        }
      })
    } else if (selectType === "paymentRetentionType") {
      new SlimSelect({
        select: this.element,
        onChange: (selectedOption) => {
          if (this.data.has("retentionBase")) {
            const retentionBase = parseFloat(this.data.get("retentionBase"));
            const retentionPct = parseFloat(selectedOption.text.split("-")[1].replace("(", "").replace("%)", "")) / 100;
            const $retentionAmountInput = new Cleave(document.querySelector(".payment_retention input"), {
                numeral: true,
                numeralThousandsGroupStyle: 'thousand'
            });

            const retentionAmount = retentionBase * retentionPct;

            $retentionAmountInput.setRawValue(retentionBase * retentionPct)
          }

        }
      })
    }
  }
}
