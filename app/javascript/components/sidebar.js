function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  console.log("hello world")
}

document.addEventListener("DOMContentLoaded", () => {
  const closeBtns = document.querySelectorAll(".closebtn")
  const hambMenu = document.querySelector(".navbar-wagon-dropicon")

  // if(hambMenu && closeBtns){
  if(closeBtns){
    // hambMenu.addEventListener("click", (event) => {
    //   openNav();
    // })
    for (let i = 0; i < closeBtns.length; i++) {
      closeBtns[i].addEventListener("click", (event) => {
        closeNav();
      })
    }
  }
})
