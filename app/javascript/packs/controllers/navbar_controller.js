import { Controller } from "stimulus"


export default class extends Controller {
  static targets = [ "whiteLogo", "colorLogo" ]

  scroll(){
    if(this.element.classList.contains("navbar-wagon-transparent")) {
      if (window.scrollY >= 100) {
        this.element.classList.add('navbar-wagon-white');
        this.whiteLogoTarget.classList.add("hidden");
        this.colorLogoTarget.classList.remove("hidden");
      } else {
        this.element.classList.remove('navbar-wagon-white');
        this.whiteLogoTarget.classList.remove("hidden");
        this.colorLogoTarget.classList.add("hidden");
      }
    }
  }
}
