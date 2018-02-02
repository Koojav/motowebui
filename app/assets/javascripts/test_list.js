function prepareDropdownChangeTestsTester()
{
    var dropdownOptions = $(".tester-dropdown-multi .tester-dropdown-menu li a");

    dropdownOptions.off('click.testsMultiConnected');
    dropdownOptions.on('click.testsMultiConnected', btnChangeTestsTester_click);
}

function btnChangeTestsTester_click()
{
    var table = $(this).closest('table').DataTable();

    var testIds = [];
    var newTesterId = $(this).data('tester-id');

    if (table.rows('.selected').data().length > 0)
    {
        table.rows('.selected').every( function ( rowIdx, tableLoop, rowLoop ) {
            var buttonGroup = this.data()['val'];
            var button = $(buttonGroup).find('button');
            testIds.push(button.data('test-id'));
        });
    }
    else
    {
        var button = $(this).parents('.dropdown-menu').siblings('button');
        testIds.push(button.data('test-id'));
    }

    console.log(testIds)

    changeTestsTester(testIds, newTesterId).done(function (response)
    {
        $.each(response, function(index)
        {
            var button = $('.btn-tester[data-test-id="'+ response[index].id +'"]');
            var tester_id = response[index].tester_id

            // Update data on button which represents current result
            button.data('tester-id', tester_id);
            button.html(response[index].tester_name + ' <span class="caret"/>');
        });
    });
}