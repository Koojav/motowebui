
// tests_stats[0] tests_running
// tests_stats[1] tests_pass
// tests_stats[2] tests_fail
// tests_stats[3] tests_error
// tests_stats[4] tests_skip
function prepareDirectoryStatsChart(tests_stats)
{
    var canvas = $('canvas.directory-stats-chart');
    var chart = new Chart(canvas, {
        type: 'doughnut',
        data: {
            labels: ["Running", "Pass", "Fail", "Error", "Skip"],
            datasets: [{
                data: tests_stats,
                backgroundColor: [
                    'rgba(0, 192, 239, 1)',
                    'rgba(0, 166, 90, 1)',
                    'rgba(211, 55, 36, 1)',
                    'rgba(211, 55, 36, 1)',
                    'rgba(243, 156, 18, 1)'],
                borderWidth: 0
            }]
        },
        options: {
            legend: {display: false},
            animation: false
        }
    });
}


function prepareDataTableReport()
{
    var dtReport = $('#dt-report');
    dtReport.on( 'draw.dt', function ()
    {
        dtReport.DataTable({paging: 0});
    });

    dtReport.show();
}