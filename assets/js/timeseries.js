export const planetChartData = {
  type: 'line',
  data: {
    datasets: [{
      yAxisID: 'A',
      backgroundColor: "rgba(54, 149, 201, 0.3)",
      pointBackgroundColor: "rgb(54, 149, 201)",
      borderColor: "rgb(54, 149, 201)",
      borderWidth: 5,
      radius: 8,
      pointHoverRadius: 9,
      pointHitRadius: 25
    }, {
      yAxisID: 'B',
      backgroundColor: "rgba(121, 173, 151, 0.3)",
      pointBackgroundColor: "rgb(121, 173, 151)",
      borderColor: "rgb(121, 173, 151)",
      borderWidth: 5,
      radius: 8,
      pointHoverRadius: 9,
      pointHitRadius: 25
    }, {
      label: 'Direktkosten [€/ha]',
      yAxisID: 'C',
      backgroundColor: "rgba(175, 175, 175, 0.3)",
      pointBackgroundColor: "rgb(175, 175, 175)",
      borderColor: "rgb(175, 175, 175)",
      borderWidth: 5,
      radius: 8,
      pointHoverRadius: 9,
      pointHitRadius: 25
    }
    ]
  },
  options: {
    dragData: true,
    maintainAspectRatio: false,
    scales: {
      yAxes: [{
        id: 'A',
        type: 'linear',
        position: 'left',
        ticks: {
          beginAtZero: true
        }
      },{
        id: 'B',
        type: 'linear',
        position: 'right',
        ticks: {
          beginAtZero: true
        }
      },
      {
        id: 'C',
        type: 'linear',
        position: 'right',
        ticks: {
          beginAtZero: true
        }
      }]
    }
  }
}

export default planetChartData;
