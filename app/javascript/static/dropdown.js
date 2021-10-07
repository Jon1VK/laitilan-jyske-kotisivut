export const initDropDowns = () => {
  const dropdownButton = document.getElementById('dropdown-button');
  const dropdown = document.getElementById('dropdown');

  if (dropdownButton) {
    dropdownButton.addEventListener('click', () => {
      dropdown.classList.toggle('visible');
      dropdownButton.classList.toggle('active');
    });
  }
};
