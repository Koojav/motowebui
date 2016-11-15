# 1. Overview
MotoWebUI is a web interface for aggregation, display and manual manipulation of results of tests.  
It's developed mainly as a companion app for **[Moto Framework](https://github.com/bwilczek/moto)** testing engine but can be used to display, filter and sort any data that fulfills structural requirements.  
`Data structure and functionality` section contains **TL;DR** description of how things are built and work together.  


# 2. Deployment and setup
TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO


# 3. Dependencies
List of dependencies has an informative character.  
There is no need to install any external components manually. All will be taken care of by `gem` and `docker`.  
In case of deploying the app without `docker` database will have to be set separately.

**Used technologies:**

* Ruby on Rails 5
* Bootstrap3
* Chart.js
* DataTables
* MySQL


# 4. Usage
TODO TODO TODO TODO TODO TODO TODO TODO TODO

* Deploy
* Provide data, via REST API, to be displayed. First create Test Suite, then assign Test Run to it. Afterwards create Tests in that Test Run. 
For technical details please consult `REST API` section.
* Access results via {your_url}:PORT (3000 by default)

TODO TODO TODO TODO TODO TODO TODO TODO TODO : WEBSITE SECTIONS (suites, runs, tests, log)


# 5. Data structure and functionality
Project is composed out of a few data structures that stay in close relation with each other.  

TL;DR:

    Test Suites group Test Runs, which in turn group Tests.  
    Test Runs can have responsible Testers assigned to them.  
    Tests can have Logs.  
    Test Runs and Tests have Results.    

TODO TODO TODO TODO TODO TODO TODO TODO TODO : LIST AND DESCRIBE FIELDS IN OBJECTS

* Test Suites
    * name
* Test Runs
    * name
    * start_time
    * duration
    * result_id
    * suite_id
    * tester_id
* Tests
* Results
* Testers
* Logs



**Example**:  

* Test Suite "Regression 16.20" 
    * Test Run "Public API"
        * Tests 1..N
    * Test Run "REST API"
        * Tests 1..N
    * Test Run "Web UI"
        * Tests 1..N
 
TODO TODO TODO TODO TODO TODO TODO TODO TODO : **Results + Categories explanation**


# 6. REST API
All data that is required to describe appropriate test sets can be created, modified and deleted via REST API.  
Below is a reference list of all endpoints available in the API.  
Input and output format for all calls is JSON.  
{base_url} is the domain, on which MotoWebUI is deployed, followed by a port (3000 by default).  


## Test Suites 
`[GET] {base_url}/api/suites`  
**Payload:** None  
**Returns:** List of all Test Suites.   

---
 
`[POST] {base_url}/api/suites`  
**Payload:** 

* name `String` - Test Suite's name  

**Returns:** Created Test Suite or existing one if provided name matched, case insensitively, with a name of previously created suite.  

---

`[GET] {base_url}/api/suites/SUITE_ID`  
**Payload:** None  
**Returns:** Test Suite with provided ID.

---

`[DELETE] {base_url}/api/suites/SUITE_ID`  
**Payload:** None  
**Returns:** Test Suite with provided ID, which has just been deleted. Removal of Test Runs, Tests and Logs aggregated by this Test Suite will be automatically chained and executed.

  
## Test Runs
`[GET] {base_url}/api/suites/SUITE_ID/runs`  
**Payload:** None  
**Returns:** List of all Test Runs that belong to a specified Test Suite.

---
 
`[GET] {base_url}/api/suites/SUITE_ID/runs/RUN_ID`  
**Payload:** None  
**Returns:** Test Run

---
 
`[POST] {base_url}/api/suites/SUITE_ID/runs`  
**Payload:** 

* name `String` - Test Run's name
* start_time `Integer` _(optional)_ - Time of start, Epoch, in seconds.
* duration `Integer` _(optional)_ - Duration of test, in seconds.
* tester_id `Integer` _(optional)_ - ID of a Tester to be assigned to this Test Run. Default: 1 ('Not assigned')
* result_id `Integer` _(optional)_ - ID of a Result which will be assigned to this run. Default: 1 ('Running')

**Returns:** Creates Test Run and returns it. If there already was an existing Run, in scope of SUITE_ID, with the same name it will be destroyed first.

---
 
`[PUT] {base_url}/api/suites/SUITE_ID/runs`  
**Payload:** Same as with `POST` to this endpoint  
**Returns:** Modified Test Run.

---
 
`[DELETE] {base_url}/api/suites/SUITE_ID/runs`  
**Payload:** None  
**Returns:** Test Run with provided ID, which has just been deleted. Removal of Tests and Logs aggregated by this Test Run will be automatically chained and executed.  

  
## Tests
`[GET] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests`  
**Payload:** None  
**Returns:** List of all Test that belong to a specified Test Run.  

---
 
`[GET] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID`  
**Payload:** None  
**Returns:** Test  

---
 
`[POST] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests`  
**Payload:** 

* name `String` - Test's name
* start_time `Integer` _(optional)_ - Time of start, Epoch, in seconds.
* duration `Integer` _(optional)_ - Duration of test, in seconds.
* ticket_url `String` _(optional)_ - URL to a ticket in tracking system, for eg. Jira, which will be displayed on Test's page.
* tags `String` _(optional)_ - Array of tags, joined on `,` which will be displayed on Test's page.
* error_message `String` _(optional)_ - Text to be displayed as 'Errors'.
* fail_message `String` _(optional)_ - Text to be displayed as 'Failures'.
* result_id `Integer` _(optional)_ - ID of a Result which will be assigned to this run. Default: 1 ('Running').

**Returns:** Creates Test and returns it.

---
 
`[PUT] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Test.

---
 
`[DELETE] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID`  
**Payload:** None  
**Returns:** Test with provided ID, which has just been deleted. Removal of Log assigned to this Test will be automatically chained and executed.  

  
## Logs
`[GET] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID/logs`  
**Payload:** None  
**Returns:** Test's Log.

---
 
`[POST] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID/logs`  
**Payload:** 

* text `String` - Log's text
**Returns:** Creates new Log, assigns it to Test and returns that Log.

---
 
`[PUT] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID/logs`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Log.

---
 
`[DELETE] {base_url}/api/suites/SUITE_ID/runs/RUN_ID/tests/TEST_ID/logs`  
**Payload:** None  
**Returns:** Deletes Log from specified Test. Returns its content before deletion. 

  
## Testers
`[GET] {base_url}/api/testers`  
**Payload:** None  
**Returns:** List of all Testers.  

---
 
`[GET] {base_url}/api/testers/TESTER_ID`  
**Payload:** None  
**Returns:** Tester with specified ID.

---
 
`[POST] {base_url}/api/testers`  
**Payload:** 

* name `String` - Tester's name
**Returns:** Newly created Tester.

---

`[PUT] {base_url}/api/testers/TESTER_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Tester.

---

`[DELETE] {base_url}/api/testers/TESTER_ID`  
**Payload:** None  
**Returns:** Retrieves Tester that's being deleted.


## Results
**Important:** Do not modify `Results` unless you're 100% sure you know what you're doing.  
For more information please consult the `Data structure` section.  

`[GET] {base_url}/api/results`  
**Payload:** None  
**Returns:** List of all possible Results. 

---

`[GET] {base_url}/api/results/RESULT_ID`  
**Payload:** None  
**Returns:** Info about specified Result.

---

`[POST] {base_url}/api/results`  
**Payload:** 

* name `String` - Tester's name
* manual `Boolean` - Is Result to be set manually (available in dropdowns in UI) or only automatically via API?
* category `String` - Result's category, categories are the basis for calculating stats (charts etc., group results etc)

**Returns:** Newly created Result.
 
---

`[PUT] {base_url}/api/results/RESULT_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Result.

---

`[DELETE] {base_url}/api/results/RESULT_ID`  
**Payload:** None  
**Returns:** Retrieves Result which is being deleted.


