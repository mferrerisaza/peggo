import { Controller } from "stimulus"

export default class extends Controller {

  toggle(){
    const sidebarElement = document.querySelector(this.data.get("selector"));
    if(sidebarElement) {
      if (sidebarElement.style.width === "0px" || sidebarElement.style.width === "") {
        sidebarElement.style.width = "250px";
      } else {
        sidebarElement.style.width = "0px";
      }
    }
  }

}
