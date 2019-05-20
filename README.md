# Instructions

Before run the tests and execute the application

export KEY_ENCRYPTING_KEY=b3512f4972d314da94380e1a70e6814a

### Create Databases

test

docker run --name interview-project_test -e POSTGRES_USER=interview-project_test -e POSTGRES_DB=interview-project_test -e POSTGRES_PASSWORD='interview-project_test' -d -p 5433:5432 postgres

development

docker run --name interview-project_development -e POSTGRES_USER=interview-project_test -e POSTGRES_DB=interview-project_development -e POSTGRES_PASSWORD='interview-project_development' -d -p 5434:5432 postgres

### run new tests

rspec

### run integration test

rails c

IntegrationTestScript.integration_test
