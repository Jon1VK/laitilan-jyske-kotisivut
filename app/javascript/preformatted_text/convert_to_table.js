export function convertToTable(rows) {
  const div = document.createElement('div');
  div.classList.add('table-wrapper');
  div.appendChild(createTable(rows));
  return div;
}

function createTable(rows) {
  const [captionText, tableHeadRow, ...tableBodyRows] = rows;
  const table = document.createElement('table');
  table.classList.add('table');
  table.appendChild(createCaption(captionText.trim()));
  table.appendChild(createTableHead(tableHeadRow));
  table.appendChild(createTablebody(tableBodyRows));
  return table;
}

function createCaption(text) {
  const caption = document.createElement('caption');
  caption.textContent = text;
  return caption;
}

function createTableHead(row) {
  const thead = document.createElement('thead');
  thead.appendChild(createTableRow(row));
  return thead;
}

function createTablebody(rows) {
  const tbody = document.createElement('tbody');
  rows.forEach((row) => tbody.appendChild(createTableRow(row)));
  return tbody;
}

function createTableRow(row) {
  const tr = document.createElement('tr');
  row.split('|').forEach((cell) => {
    tr.appendChild(createTableData(cell.trim()));
  });
  return tr;
}

function createTableData(text) {
  const td = document.createElement('td');
  td.textContent = text;
  return td;
}
