// Changes assignee for specified directories
function changeDirectoriesTester(directory_ids, tester_id)
{
    // Send changed Result
    return $.ajax
    (
        {
            type: "PUT",
            url: "/api/directories",
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify({directory_ids: directory_ids, tester_id: tester_id})
        }
    )
}