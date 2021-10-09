export function init() {
  const mainHamburger = document.getElementById('hamburger');
  const userHamburger = document.getElementById('user-hamburger');
  const mainNav = document.getElementById('main-nav');
  const userNav = document.getElementById('user-nav');

  mainHamburger.addEventListener('click', () => {
    mainNav.classList.toggle('visible');
    mainHamburger.classList.toggle('active');

    if (userNav && !mainNav.classList.contains('visible')) {
      userNav.classList.remove('visible');
      userHamburger.classList.remove('active');
    }
  });

  if (userNav) {
    userHamburger.addEventListener('click', () => {
      userNav.classList.toggle('visible');
      userHamburger.classList.toggle('active');
    });
  }
}

export function close() {
  const mainHamburger = document.getElementById('hamburger');
  const userHamburger = document.getElementById('user-hamburger');
  const mainNav = document.getElementById('main-nav');
  const userNav = document.getElementById('user-nav');

  mainHamburger.classList.remove('active');
  mainNav.classList.remove('visible');

  if (userNav) {
    userHamburger.classList.remove('active');
    userNav.classList.remove('visible');
  }
}
