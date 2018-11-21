export const planetChartData = {
  type: 'line',
  data: {
    labels: ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
    datasets: [
      { // one line graph
        label: 'Verfügbare Arbeitszeit',
        data: [200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200],
        backgroundColor: [
          'rgba(54,73,93,.5)', // Blue
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)',
          'rgba(54,73,93,.5)'
        ],
        radius: 5,
        pointHoverRadius: 6,
        pointHitRadius: 15
      },
      { // another line graph
        label: 'Verfügbare Feldarbeitstage',
        data: [4.8, 12.1, 12.7, 6.7, 139.8, 116.4, 50.7, 49.2],
        backgroundColor: [
          'rgba(71, 183,132,.5)', // Green
        ],
        borderWidth: 3,
        radius: 5,
        pointHoverRadius: 6,
        pointHitRadius: 15
      }
    ]
  },
  options: {
    responsive: true,
    //lineTension: 1,
    dragData: true,
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true,
          padding: 25,
          min: 0,
          max: 2000
        }
      }]
    }
  }
}

export default planetChartData;