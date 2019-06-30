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
        addable: value => value,
        ajax: (search, callback) => {

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
          if (selectedValue.data) {
            const $itemRow = this.element.parentElement.parentElement.parentElement;
            const $quantity = $itemRow.querySelector(".item-quantity");
            const $price = new Cleave($itemRow.querySelector(".item-price"), {
                numeral: true,
                numeralDecimalMark: ',',
                delimiter: '.',
            });
            const $vat = $itemRow.querySelector(".item-vat");
            const $discount = $itemRow.querySelector(".item-discount");
            const $total = new Cleave($itemRow.querySelector(".item-total"), {
                numeral: true,
                numeralDecimalMark: ',',
                delimiter: '.',
            });

            $quantity.value = selectedValue.data.quantity;
            $price.setRawValue(selectedValue.data.price);
            $vat.value = selectedValue.data.vat;
            $discount.value = selectedValue.data.discount
            $total.setRawValue(selectedValue.data.quantity * selectedValue.data.price * (1 + parseFloat(selectedValue.data.vat)) * (1 - parseFloat(selectedValue.data.discount)));

            // reload cleave by focusing the inputs, both inputs are listening to focus and will mount cleave on the cleave controller
            // $total.disabled = false;
            // $total.focus();
            // $total.disabled = true;
            // $price.focus();

            // $quantity.focus();
          }
        }
      })
    }
  }
}
