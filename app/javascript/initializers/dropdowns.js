export function init() {
  [...document.querySelectorAll('.dropdown-button')].forEach((dropdownBtn) => {
    const dropdownId = dropdownBtn.dataset.dropdownId;
    const dropdown = document.getElementById(dropdownId);

    dropdownBtn.addEventListener('click', () => {
      dropdown.classList.toggle('visible');
      dropdownBtn.classList.toggle('active');
    });
  });
}

export function close() {
  [...document.querySelectorAll('.dropdown-button')].forEach((dropdownBtn) => {
    const dropdownId = dropdownBtn.dataset.dropdownId;
    const dropdown = document.getElementById(dropdownId);
    dropdown.classList.remove('visible');
    dropdownBtn.classList.remove('active');
  });
}
