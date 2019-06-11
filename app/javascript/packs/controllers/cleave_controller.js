import { Controller } from "stimulus"
import Cleave from "cleave.js";


export default class extends Controller {

  connect() {
    this.mountCleave()
  }

  mountCleave(){
    const cleave = new Cleave(this.element, {
        numeral: true,
        numeralDecimalMark: ',',
        delimiter: '.',
    });
  }
}
