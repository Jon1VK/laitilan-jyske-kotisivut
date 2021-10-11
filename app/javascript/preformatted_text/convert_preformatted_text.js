import { convertToTable } from './convert_to_table';

export function convertPreformattedText() {
  [...document.querySelectorAll('pre')].forEach((pre) => {
    const [format, ...rows] = pre.textContent.split('\n');

    if (format.startsWith('#table')) {
      pre.replaceWith(convertToTable(rows));
    }
  });
}
