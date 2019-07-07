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
      new SlimSelect({
        select: this.element,
        onChange: (selectedOption) => {
          let url = this.data.get("fetchInvoicesUrl");
          url = `${url}/${selectedOption.value}/invoices`;
          fetch(url)
          .then(response => response.json())
          .then((data) => {
            let json = [];

            json.push( {text: "", data: { placeholder: true } } )

            for (let i = 0; i < data.length; i++) {
              json.push( { text: data[i].name, value: data[i].id } )
            }

            const invoiceSelect = new SlimSelect({
              select: '.payment_invoice select',
              placeholder: "No Asociar",
              onChange: (invoiceOption) => {
                this.updateInvoiceInfo(invoiceOption);
              }
            })
            invoiceSelect.setData(json)
          })
        }
      })
    }
  }

  updateInvoiceInfo(invoiceOption) {
    console.log(this, invoiceOption);
  }
}
