export const initHamburgerNav = () => {
  const hamburger = document.getElementById('hamburger');
  const nav = document.getElementById('main-nav');

  hamburger.addEventListener('click', () => {
    nav.classList.toggle('visible');
    hamburger.classList.toggle('active');
  });
};
