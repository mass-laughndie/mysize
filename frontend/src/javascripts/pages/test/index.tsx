import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Hello from '../../features/Hello/components';

ReactDOM.render(<Hello />, document.querySelector('[data-react-entry="root"]'));

function switchPlanTable() {
  const tabIdNamePrefix = 'js-plan-table-tab';
  const activeTabNum = Number(
    $(`[id^=${tabIdNamePrefix}]`)
      .filter("[class$='is-active']")
      .attr('id')
      .replace(tabIdNamePrefix, '')
  );

  if (activeTabNum > 0) {
    const tableIdNamePrefix = 'js-plan-table';
    $(`[id^=${tableIdNamePrefix}]`).hide();
    $(`${tableIdNamePrefix}${activeTabNum}`).show();
  }
}

switchPlanTable();
