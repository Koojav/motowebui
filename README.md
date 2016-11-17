# 1. Overview
MotoWebUI is a Ruby on Rails based web interface for aggregation, display and manual manipulation of results of tests.  
Developed mainly as a companion app for **[Moto Framework](https://github.com/bwilczek/moto)** testing engine but can be used to display, filter and sort any data that fulfills structural requirements.  
Section `Data structure and functionality` contains **TL;DR** description of how things are built and work together.  


# 2. Deployment

## 2.1 Using `docker` and `docker-compose`

### 2.1.1 Prerequisites: 
* `docker >= 1.12`
* `docker-compose >= 1.9`

### 2.1.1 Commands: 
* `git clone git@github.com:Koojav/motowebui.git motowebui`
* `cd motowebui`
* `docker-compose up -d` 
<p> </p>

**Note:** Automatically deployed as production on port 3000, see `Configuration` section for more details.  
<p> </p>

**Note:** Dockerized deployment requires no additional configuration, everything works right out of the box.

## 2.2 Manually

* `git clone git@github.com:Koojav/motowebui.git motowebui`
* Install Ruby 2.3 with devkit
* Install Bundler
* Install required Gems using Bundler
* Install & run MySQL/PostgreSQL server (latter one requires small changes in Rails connectors)
* Set environment variables.
* `cd motowebui/bin`
* `rails assets:precompile`
* `rails db:migrate`
* `rails db:seed`
* `rails server -b 0.0.0.0`
<p> </p>

**Note:** Please consult `Configuration` section on setting ENV VARs and Rails/database properties.


## 2.3 (Optional) Verifying deployment correctness
After a successful deployment a few endpoints can be inspected to check if everything went fine.  
Below is a list of what, and where, should be displayed:

* `yourdomain:3000` - CSS styled datatable with information about lack of data to display
* `yourdomain:3000/api/testers` - JSON with "Not assigned" tester
* `yourdomain:3000/api/results` - JSON with a list of Result objects


# 3. Configuration
Most of the settings are self explanatory.  
Please review files appropriate to chosen process of deployment:

- Docker: `Dockerfile`,`docker-compose.yml`,`entrypoint.sh`
- Manual: `config/database.yml`, `config/secrets.yml`

### 3.1 Default port
Port, on which applications listens, is set by default to 3000.  
It can be changed by setting `MWUI_PUBLIC_PORT` ENV VAR prior to running containers.  
**Example:**

    MWUI_PUBLIC_PORT=3333 docker-composer up -d

### 3.2 Docker's environment variables
All ENV VARs used by **MotoWebUI** are listed in `docker-compose.yml`. 
When not using Docker you still may configure app just by setting appropriate ENV VARs or edit them out, in aforementioned files, and set to constant strings.


### 3.3 Changing database to PostgreSQL/SQLite
* When changing database type to PostgreSQL appropriate `gem` is required in `Gemfile`
* **Untested:** Use of SQLite might be possible with Rails server set to 1 thread (default: 5). 


# 4. Usage
* Deploy
* Provide data, via REST API, to be displayed. 
    * Create Test Suite(s)
    * Create Test Run(s) and assign it to Test Suite.
    * Create Test(s) and assign them to Test Run.  
* Access and modify manually your data in various views:
    * `yourdomain:3000` - list of all Test Suites
    * `yourdomain:3000/suites/SUITE_ID/runs` - list of Test Runs in a Test Suite
    * `yourdomain:3000/suites/SUITE_ID/runs/RUN_ID` - details of a Test Run + list of Tests in it
    * `yourdomain:3000/suites/SUITE_ID/runs/RUN/tests/TEST_ID` - details of a Test

**Note:** For technical details please consult `REST API` section.


# 5. Data structure and functionality
Project is composed out of a few data structures that stay in close relation with each other.  

**TL;DR**

    Test Suites group Test Runs, which in turn group Tests.  
    Test Runs can have responsible Testers assigned to them.  
    Tests can have Logs.  
    Test Runs and Tests have Results.    


### 5.1 Test Suites
**Info:** Test Suites should represent 'packages' of tests, for example: `Regression 16.20`  
**Creation policy:** Only one Test Suite of a certain name, case insensitive, can exist at the same time. 
When creating new Test Suite with previously existing name the existing Test Suite will be retrieved.  
**Fields:** 

* **name** `String` Test Suite's name.  

### 5.2 Test Runs
**Info:** Test Runs have unique names in the scope of Test Suite. 
When Test Run with previously existing name is submitted old one is destroyed, but it's ID is saved 
so when re-submitting results of re-run Test Run saved URLs will be still valid.  
**Creation policy:** Only one Test Suite of a certain name, case insensitive, can exist at the same time.  
**Fields:** 

* **name** `String` Test Run's name.
* **start_time** `Integer` Epoch, in seconds.
* **duration** `Integer` In seconds.
* **result_id** `Integer` ID of Test Run's result. 
 Test Run results are automatically evaluated when one of the child Tests changes, marks parent Test Run as `dirty` and request comes to display Test Run's details. 
 TR result is the 'least satisfactory' in that order: RUNNING, ERROR, FAIL, SKIP, PASS.
* **suite_id** `Integer` ID of Test Suite to which Test Run belongs.
* **tester_id** `Integer` ID of Tester assigned to Test Run.  

### 5.2 Tests
**Info:** Outcome of a singular Test.  
**Creation policy:** TODO TODO TODO TODO TODO TODO TODO   
**Fields:** 

* **name** `String` Test Run's name.
* **start_time** `Integer` Epoch, in seconds.
* **duration** `Integer` In seconds.
* **result_id** `Integer` ID of Test's result.
* **error_message** `String` Any message that accompanies Test and is to be displayed in the 'Error' section of Test's details.
* **fail_message** `String` Any message that accompanies Test and is to be displayed in the 'Failure' section of Test's details.
* **ticket_url** `String` URL to external work tracking system (for example Jira) which will be displayed on Test's view.
* **tags** `String` Array of tags, joined on '`', which will be displayed on Test's view.
* **run_id** `Integer`  ID of Test Run to which this tests belongs.

### 5.2 Results
**Info:** Represents one of the many possible outcomes of Test.  
**Creation policy:** Seeded at deployment.  
**Fields:** 

* **name** `String` Result's displayed name.
* **manual** `Boolean` Indicates whether result can be set manually via GUI.
* **category** `String` Categories group various results. They are the actual value based on which Test Run stats are evaluated. Result's name is just for display purposes.

### 5.2 Testers
**Info:** Represent a person that can be assigned to Test Run and be displayed as responsible one.  
**Creation policy:** Testers must have a unique name.  
**Fields:** 

* **name** `String` Tester's name

### 5.2 Logs
**Info:** Text which includes all important data logged during the execution of the Test.  
**Creation policy:** Logs are a singular Rails resource - there is one log per Test.  
**Fields:** 

* **text** `String` Log's text.


**Example**:  

* Test Suite "Regression 16.20" 
    * Test Run "Public API"
        * Tests 1..N
    * Test Run "REST API"
        * Tests 1..N
    * Test Run "Web UI"
        * Tests 1..N



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


# 7. Technologies used
List of dependencies has an informative character, when deploying **MotoWebUI** using `docker-compose` everything will be installed automatically.  

* Ruby on Rails 5
* Bootstrap3
* Chart.js
* DataTables
* MySQL


