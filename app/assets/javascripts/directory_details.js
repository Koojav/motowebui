
function prepareDropdownChangeDirectoryTester()
{
    $('.tester-dropdown .tester-dropdown-menu li a').click(function ()
    {
        var button = $(this).parents('.dropdown-menu').siblings('button');
        var tester_name = $(this).data('tester-name');

        changeDirectoriesTester([$(this).data('directory-id')], $(this).data('tester-id')).done(function (response)
        {
            button.html(tester_name + ' <span class="caret"/>');
        })
    });
}
