function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon-transparent');
  const colorLogo= document.getElementById("color-logo");
  const whiteLogo= document.getElementById("white-logo");

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-wagon-white');
        whiteLogo.classList.add("hidden");
        colorLogo.classList.remove("hidden");
      } else {
        navbar.classList.remove('navbar-wagon-white');
        whiteLogo.classList.remove("hidden");
        colorLogo.classList.add("hidden");
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
