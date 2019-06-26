import { Controller } from "stimulus"
import SlimSelect from 'slim-select'
import "slim-select/src/slim-select/slimselect.scss";


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
      new SlimSelect({
        select: this.element
      })
    }
  }

}
