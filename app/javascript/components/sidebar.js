function openNav(sidebar) {
  sidebar.style.width = "250px";
}

function closeNav(sidebar) {
  sidebar.style.width = "0";
}

document.addEventListener("DOMContentLoaded", () => {
  const closeBtns = document.querySelectorAll(".closebtn")
  const hambMenu = document.querySelector(".navbar-wagon-dropicon")
  const sidebar = document.getElementById("mySidenav");
  if(hambMenu && closeBtns && sidebar){
    hambMenu.addEventListener("click", (event) => {
      openNav(sidebar);
    })
    for (let i = 0; i < closeBtns.length; i++) {
      closeBtns[i].addEventListener("click", (event) => {
        closeNav(sidebar);
      })
    }
  }
})
