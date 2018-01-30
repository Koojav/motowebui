
function prepareDropdownChangeTesterMultipleConnected()
{
    var dropdownOptions = $(".tester-dropdown-multi .tester-dropdown-menu li a");

    dropdownOptions.off('click.multiConnected');
    dropdownOptions.on('click.multiConnected', btnDataTableChangeTester_click);
}

function btnDataTableChangeTester_click()
{
    var table = $(this).closest('table').DataTable();

    var directoryIds = [];
    var newTesterId = $(this).data('tester-id');

    if (table.rows('.selected').data().length > 0)
    {
        table.rows('.selected').every( function ( rowIdx, tableLoop, rowLoop ) {
            var buttonGroup = this.data()['val'];
            var button = $(buttonGroup).find('button');
            directoryIds.push(button.data('directory-id'));
        });
    }
    else
    {
        var button = $(this).parents('.dropdown-menu').siblings('button');
        directoryIds.push(button.data('directory-id'));
    }

    changeDirectoriesTester(directoryIds, newTesterId).done(function (response)
    {
        $.each(response, function(index)
        {
            var button = $('.btn-tester[data-directory-id="'+ response[index].id +'"]');
            var tester_id = response[index].tester_id

            // Update data on button which represents current result
            button.data('tester-id', tester_id);
            button.html(response[index].tester_name + ' <span class="caret"/>');
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

        prepareDropdownChangeTesterMultipleConnected();
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
            order: [[0, 'asc']],
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