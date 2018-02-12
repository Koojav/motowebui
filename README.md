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

### 3.2 Environment variables
All ENV VARs used by **MotoWebUI** are listed in `docker-compose.yml`. 
When not using Docker you still may configure app just by setting appropriate ENV VARs or edit them out, in aforementioned files, and set to constant strings.


### 3.3 Changing database to PostgreSQL/SQLite
* When changing database type to PostgreSQL appropriate `gem` is required in `Gemfile`
* **Untested:** Use of SQLite might be possible with Rails server set to 1 thread (default: 5). 


# 4. Usage
* Deploy
* Provide data, via REST API, to be displayed such as: 
    * Directories
    * Tests and their results..  
* Access and modify manually your data in various views:
    * `yourdomain:3000` - redirects to root directory (ID: 0)
    * `yourdomain:3000/directories/ID` - list of Subdirectories and Tests in a Directory
    * `yourdomain:3000/directories/ID/tests/TEST_ID` - details of a Test

**Note:** For technical details please consult `REST API` section.


# 5. Data structure and functionality

    Directories contain Directories and Tests
    Directories and Tests can have responsible Testers assigned to them.    
    Tests have Results.  
    Tests can have Logs.    


### 5.1 Directories
**Info:** Directory has its path, subdirectories (optional) and Tests (optional).  
**Creation policy:** When creating a Directory MWUI will automatically create 
all parent directories in order to fulfill path requirement  
**Fields:** 

* **name** `String` Directory's name 
* **path** `String` Directory's full path 
* **parent_id** `String` Directory's parent's ID. 


### 5.2 Tests
**Info:** Outcome of a singular Test.  
**Creation policy:** Tests must have unique, case insensitive, names in scope of a Directory. When Test will overwrite ones with the same name.  
**Fields:** 

* **name** `String` Test's name.
* **start_time** `Integer` Epoch, in seconds.
* **duration** `Integer` In seconds.
* **result_id** `Integer` ID of Test's result.
* **error_message** `String` Any message that accompanies Test and is to be displayed in the 'Error' section of Test's details.
* **fail_message** `String` Any message that accompanies Test and is to be displayed in the 'Failure' section of Test's details.
* **ticket_url** `String` URL to external work tracking system (for example Jira) which will be displayed on Test's view.
* **tags** `String` Array of tags, joined on '`', which will be displayed on Test's view.
* **directory_id** `Integer`  ID of Directory to which this tests belongs.

### 5.2 Results
**Info:** Represents one of the many possible outcomes of Test.  
**Creation policy:** Seeded at deployment.  
**Fields:** 

* **name** `String` Result's displayed name.
* **manual** `Boolean` Indicates whether result can be set manually via GUI.
* **category** `String` Categories group various results. Result's name is just for display purposes.

### 5.2 Testers
**Info:** Represent a person that can be assigned to Directory or Test and be displayed as responsible one.  
**Creation policy:** Testers must have a unique name.  
**Fields:** 

* **name** `String` Tester's name

### 5.2 Logs
**Info:** Text which includes all important data logged during the execution of the Test.  
**Creation policy:** Logs are a singular Rails resource - there is one log per Test.  
**Fields:** 

* **text** `String` Log's text.


# 6. REST API
All data that is required to describe appropriate test sets can be created, modified and deleted via REST API.  
Below is a reference list of all endpoints available in the API.  
  
  
**IMPORTANT:**    
**Input and output format for all calls is JSON.**  
  
  
{api_url} is the domain, on which MotoWebUI is deployed, followed by `/api` and port (3000 by default).  


## Directories 
`[POST] {api_url}/directories`  
**Payload:** 

    { "directory": {"path":"/directory/creation/example"} }
    
or

    { "directories": [{"path":"/dir/subdir1"}, {"path":"/dir/subdir2"}] }

**Returns:** Created or previously existing Directories.  

---

`[GET] {api_url}/directories/ID`  
**Payload:** None  
**Returns:** Directory with provided ID.

---
 
`[PUT] {api_url}/directories/ID/`  
**Payload:** 
   
All fields are optional
    
    { "name": "new_name", "tester_id": 2, "parent_id": 37 }
    
**Returns:** Modified directory

---
  
`[PUT] {api_url}/directories`  
**Payload:**  
    
Allows for `tester_id` to be changed on multiple Directories at the same time.
    
    { "directory_ids": [1,2,3,4], "tester_id": 2 }
    
**Returns:** Modified directories

---

`[DELETE] {api_url}/directories/ID`  
**Payload:** None  
**Returns:** Directory with provided ID, which has just been deleted. Removal of Subdirectories and Tests aggregated by this entity will be automatically chained and executed.
  
  
## Tests
`[GET] {api_url}/directories/ID/tests`  
**Payload:** None  
**Returns:** List of all Test that belong to a specified Directory.  

---
 
`[GET] {api_url}/directories/ID/tests/TEST_ID`  
**Payload:** None  
**Returns:** Test details  

---
 
`[POST] {api_url}/directories/ID/tests`  
**Payload:** 

* name `String` - Test's name
* start_time `Integer` _(optional)_ - Time of start, Epoch, in seconds.
* duration `Integer` _(optional)_ - Duration of test, in seconds.
* ticket_url `String` _(optional)_ - URL to a ticket in tracking system, for eg. Jira, which will be displayed on Test's page.
* tags `String` _(optional)_ - Array of tags, joined on `,` which will be displayed on Test's page.
* error_message `String` _(optional)_ - Text to be displayed as 'Errors'.
* fail_message `String` _(optional)_ - Text to be displayed as 'Failures'.
* result_id `Integer` _(optional)_ - ID of a Result which will be assigned to this Test. Default: 1 ('Running').

**Returns:** Creates Test and returns it. Will delete previously existing Test first if it had the same name (Directory's scope, case insensitive, ID is stored so URLs will be still valid).

---
 
`[PUT] {api_url}/directories/ID/tests/TEST_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Test.

---  
 
`[PUT] {api_url}/tests/`  
**Payload:** Allows for modifying Result and/or assigned Tester in multiple Tests at the same time.  

    {"test_ids": [4,5,6], "result_id": 3, "tester_id": 2}

**Returns:** Modified Tests.

---
 
`[DELETE] {api_url}/directories/ID/tests/TEST_ID`  
**Payload:** None  
**Returns:** Test with provided ID, which has just been deleted. **Logs will not be automatically removed** 

  
## Logs
`[GET] {api_url}/directories/ID/tests/TEST_ID/logs`  
**Payload:** None  
**Returns:** Test's Log.

---
 
`[POST] {api_url}/directories/ID/tests/TEST_ID/logs`  
**Payload:** 

* text `String` - Log's text
**Returns:** Creates new Log, assigns it to Test and returns that Log.

---
 
`[PUT] {api_url}/directories/ID/tests/TEST_ID/logs`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Log.

---
 
`[DELETE] {api_url}/directories/ID/tests/TEST_ID/logs`  
**Payload:** None  
**Returns:** Deletes Log from specified Test. Returns its content before deletion. 

  
## Testers
`[GET] {api_url}/testers`  
**Payload:** None  
**Returns:** List of all Testers.  

---
 
`[GET] {api_url}/testers/TESTER_ID`  
**Payload:** None  
**Returns:** Tester with specified ID.

---
 
`[POST] {api_url}/testers`  
**Payload:** 

* name `String` - Tester's name
**Returns:** Newly created Tester.

---

`[PUT] {api_url}/testers/TESTER_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Tester.

---

`[DELETE] {api_url}/testers/TESTER_ID`  
**Payload:** None  
**Returns:** Retrieves Tester that's being deleted.


## Results
**Important:** Do not modify `Results` unless you're 100% sure you know what you're doing.  
For more information please consult the `Data structure` section.  

`[GET] {api_url}/results`  
**Payload:** None  
**Returns:** List of all possible Results. 

---

`[GET] {api_url}/results/RESULT_ID`  
**Payload:** None  
**Returns:** Info about specified Result.

---

`[POST] {api_url}/results`  
**Payload:** 

* name `String` - Tester's name
* manual `Boolean` - Is Result to be set manually (available in dropdowns in UI) or only automatically via API?
* category `String` - Result's category, categories are the basis for calculating stats (charts etc., group results etc)

**Returns:** Newly created Result.
 
---

`[PUT] {api_url}/results/RESULT_ID`  
**Payload:** Same as with `POST` to this endpoint.  
**Returns:** Modified Result.

---

`[DELETE] {api_url}/results/RESULT_ID`  
**Payload:** None  
**Returns:** Retrieves Result which is being deleted.  


## MotoResults
Special endpoint used for integration with **[Moto Framework](https://github.com/bwilczek/moto)**  
Allows for creating multiple Tests in a certain Directory, which too will be created if doesn't exist,

`[POST] {api_url}/motoresults`
    
    {"path": "/directory/path", "tester_id": 2, "tests": [{TEST1}, {TEST2}] }


# 7. Technologies used
List of dependencies has an informative character, when deploying **MotoWebUI** using `docker-compose` everything will be installed automatically.  

* Ruby on Rails 5
* Bootstrap3
* Chart.js
* DataTables
* MySQL


