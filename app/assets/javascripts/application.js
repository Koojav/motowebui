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
    $('.tester-dropdown .tester-dropdown-menu li a').click(function ()
    {
        var button = $(this).parents('.dropdown-menu').siblings('button');
        var tester_name = $(this).data('tester-name');

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
            button.html(tester_name + ' <span class="caret"/>');
        });
    });
}

function prepareDropdownChangeTesterMultipleConnected(table)
{

    if (table == undefined)
    {
        return;
    }

    table = table.DataTable();

    // table = table.DataTable();
    var dropdownOptions = $(".tester-dropdown-multi .tester-dropdown-menu li a");

    // TODO: CLICKS BUT DOESN'T SEND DATA

    dropdownOptions.off('click.multiConnected');
    dropdownOptions.on('click.multiConnected', function ()
    {

        // each element represents a pair: test_id, result_id
        var directoryIds = [];
        var newTesterId = $(this).data('tester-id');

        if (table.rows('.selected').data().length > 0)
        {
            table.rows('.selected').every( function ( rowIdx, tableLoop, rowLoop ) {
                var buttonGroup = this.data()['val'];
                var button = $(buttonGroup).find('button');
                directoryIds.push(button.data('directory-id'));
            } );
        }
        else
        {
            var button = $(this).parents('.dropdown-menu').siblings('button');
            directoryIds.push(button.data('directory-id'));
        }

        changeDirectoriesTester(directoryIds, newTesterId);
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


// Changes assignee for specified directories
function changeDirectoriesTester(directory_ids, tester_id)
{
    // Send changed Result
    $.ajax
    (
        {
            type: "PUT",
            url: "/api/directories",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify({directory_ids: directory_ids, tester_id: tester_id})
        }).done(function (response)
    {
        $.each(response, function(index)
        {
            var button = $('.btn-result[data-directory-id="'+ response[index].id +'"]');
            var tester_id = response[index].tester_id

            // Update data on button which represents current result
            button.data('tester-id', tester_id);
        });
    });
}


function prepareDataTableSubdirectories(paging)
{
    prepareDropdownChangeTesterMultipleConnected();

    // When DataTable is redrawn some fancier elements, like status buttons, require some additional setup to retain their functionality
    var dtSubdirs = $('#dt-subdirectories');

    dtSubdirs.on( 'draw.dt', function ()
    {
        // Clear selection whenever user redraws the table (filtering, searching, pagination)
        $.each($('table tr[class~="selected"]'), function(index, value)
        {
            $(value).toggleClass('selected');
        });

        $(this).show();

        prepareDropdownChangeTesterMultipleConnected($(this));
    });

    // Initialize datatable
    var table = dtSubdirs.DataTable(
        {
            dom:
            "<'row'<'col-sm-6'lB><'col-sm-6'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-12'p>>",
            select: {
                style:    'os',
                // ignoring certain cells with controls since they interfered with selection etc.
                selector: 'td:nth-of-type(1)'
            },
            paging: paging,
            pageLength: 25,
            lengthMenu: [10, 25, 50, 100],
            columnDefs: [
            {
                targets: ['column-assignee'], data: function(row, type, set, meta)
                {
                    if (type === 'set')
                    {
                        row.val = set;
                        row.val_display = set;
                        row.val_filter = $(set).find('.btn-tester').text();
                    }
                        else if (type === 'display')
                    {
                        return row.val_display
                    }
                        else if (type === 'filter')
                    {
                        return row.val_filter
                    }

                        return row.val;
                    }
                }
                ],
                order: [[1, 'asc']],
                buttons: [
                {
                    extend: 'selectAll',
                    className: 'selectall',
                    text: 'Select visible',
                    action : function(e) {
                    e.preventDefault();
                    table.rows().deselect();
                    table.rows({ page: 'current', search: 'applied'}).select();
                }
            },
            'selectNone'
            ]});

    $('#dt-subdirectories').show();
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