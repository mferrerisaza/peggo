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
      const fetchUrl = this.data.get("fetchUrl");

      new SlimSelect({
        select: this.element,
        addable: value => value,
        ajax: (search, callback) => {
          // Check search value. If you dont like it callback(false) or callback('Message String')
          // if (search.length < 3) {
          //   callback('Need 3 characters')
          //   return
          // }

          fetch(`${fetchUrl}?query=${search}`)
          .then(response => response.json())
          .then((data) => {
            let json = []

            for (let i = 0; i < data.length; i++) {
              json.push({text: data[i].name})
            }

            callback(json)
          })
          .catch((error) => {
            callback(false)
          })
        }
      })
    }
  }

}
