// Convert preformatted text to html tables
export function convert() {
  [...document.querySelectorAll('.trix-content pre')].forEach((pre) => {
    const [format, ...rowsData] = pre.textContent.split('\n');

    if (format.startsWith('#table')) {
      const [theadRowData, ...tbodyRowsData] = rowsData;
      const table = document.createElement('table');
      table.classList.add('table');

      pre.replaceWith(table);

      const thead = document.createElement('thead');
      table.appendChild(thead);
      const theadRow = document.createElement('tr');
      thead.appendChild(theadRow);

      theadRowData.split('|').forEach((cellData) => {
        const th = document.createElement('th');
        th.textContent = cellData.trim();
        theadRow.appendChild(th);
      });

      const tbody = document.createElement('tbody');
      table.appendChild(tbody);

      tbodyRowsData.forEach((tbodyRowData) => {
        const tbodyRow = document.createElement('tr');
        tbody.appendChild(tbodyRow);

        tbodyRowData.split('|').forEach((cellData) => {
          const td = document.createElement('td');
          td.textContent = cellData.trim();
          tbodyRow.appendChild(td);
        });
      });
    }
  });
}
