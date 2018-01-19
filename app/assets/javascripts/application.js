// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require Chart
//= require_tree .

function prepareDropdownChangeTester()
{
    $(".tester-dropdown-menu li a").click(function ()
    {
        var button = $(this).parents('.dropdown-menu').siblings('button');
        var tester_name = $(this).data('tester-name');

        console.log("Directory.id: " + $(this).data('directory-id'));

        $.ajax
        (
            {
                type: "PUT",
                url: "/api/directories/" + $(this).data('directory-id'),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({tester_id: $(this).data('tester-id')})
            }).done(function (response)
        {
            console.log(button);
            button.html(tester_name + ' <span class="caret"/>');
        });
    });
}

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
                    'rgba(243, 156, 18, 1)'
                ],
                    borderWidth: 0
                }]
                },
    options: {
        legend: {display: false},
        animation: false
    }
});
}
