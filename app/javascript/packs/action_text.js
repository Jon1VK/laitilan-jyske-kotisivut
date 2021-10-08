require('@rails/actiontext');
var Trix = require('trix');

/* what the newly created button does */
Trix.config.blockAttributes.floatLeft = {
  tagName: 'sub',
  group: false,
  terminal: true,
};

Trix.config.blockAttributes.floatRight = {
  tagName: 'sup',
  group: false,
  terminal: true,
};

/* insert the button visual in the default toolbar */
addEventListener('trix-initialize', function (event) {
  const floatLeftButton =
    '<button class="trix-button trix-button--icon trix-button--icon-float-left" type="button" data-trix-attribute="floatLeft" tabindex="-1"></button>';
  const floatRightButton =
    '<button class="trix-button trix-button--icon trix-button--icon-float-right" type="button" data-trix-attribute="floatRight" tabindex="-1"></button>';

  const fileTools = event.target.toolbarElement.querySelector(
    '.trix-button-group--file-tools'
  );
  fileTools.insertAdjacentHTML('beforeend', floatLeftButton);
  fileTools.insertAdjacentHTML('beforeend', floatRightButton);
});

window.convertPreformattedTablesToHTML = function () {
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
};
