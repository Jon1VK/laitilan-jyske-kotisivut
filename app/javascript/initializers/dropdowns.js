export function init() {
  const dropdownButton = document.getElementById('dropdown-button');
  const dropdown = document.getElementById('dropdown');

  if (dropdownButton) {
    dropdownButton.addEventListener('click', () => {
      dropdown.classList.toggle('visible');
      dropdownButton.classList.toggle('active');
    });
  }
}

export function close() {
  const dropdownButton = document.getElementById('dropdown-button');
  const dropdown = document.getElementById('dropdown');

  if (dropdownButton) {
    dropdown.classList.remove('visible');
    dropdownButton.classList.remove('active');
  }
}
