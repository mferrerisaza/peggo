import {MDCMenu} from '@material/menu';
const addListenerToMenus = () => {
  const menuElements = document.querySelectorAll('.mdc-menu')
  if (menuElements) {
    for (let i = 0; i < menuElements.length; i++) {
      const menuHTML = menuElements[i];
      const menu = new MDCMenu(menuHTML);
      const menuButton = menuHTML.parentNode;
      menuButton.addEventListener("click", (event) => {
        menu.open = !menu.open;
      })
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addListenerToMenus();
})
