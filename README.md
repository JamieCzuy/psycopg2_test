# psycopg2_test
Simple repo using Docker to test different installs of psycopg2 against Python3 standard Docker image


## Background
I created a new Django project and added Postgres database
and got a warning about how the psycopg2 package was going to be renamed.
I followed the [link provided](http://initd.org/psycopg/articles/2018/02/08/psycopg-274-released/)
and read about the issue with using the pre-built wheel and while is doesn't
affect many users I was concerned about existing production systems.

In the article they talk about once the package is renamed there will be two options:
the first is to specifically use the pre-built binary wheel or the second is to
force installation from source (this is the more reliable (preferred) way).

We use Docker so if we can build from source on the standard Python3
image (the one we "FROM" in our Django Dockerfile) then we are good
to go and need not worry about the upcoming package rename.

That is why I created these three files:

## Files:
### This README
To explain everything.

### Dockerfile
This is a simple DockerFile with 2 actionable lines (the rest are
comments). The two lines are `FROM python:3.6.4` which is the python
image we are using. For the other line you must un-comment one of
the options for how to install the psycopg2 package.

The options are described in the comments.

Dockerfile:
```
FROM python:3.6.4

#--------------------------------------#
# This install gives warnings in the   #
# test output about package rename     #
#--------------------------------------#

# RUN pip install psycopg2


#--------------------------------------#
# No warnings with this one.           #
# NOTE: It is using the wheel          #
#--------------------------------------#

# RUN pip install psycopg2-binary


#--------------------------------------#
# No warnings with this one.           #
# NOTE: In build step, it runs:        #
#    setup.py install for psycopg2     #
#--------------------------------------#

# RUN pip install --no-binary :all: psycopg2

```

### docker_compose.yml
The final file is the compose file used to run the postgres tests.

It has 3 services:
* db_server - standard postgres server
* db_creator - temp service that just creates the test database
on the db_server
* tester - this one is built using the Dockerfile and uses
python to run the [postgres tests defined here](http://initd.org/psycopg/docs/install.html#running-the-test-suite)


## Commands

There are two commands:

### Up Command
This command creates the services and runs the tests:
```
docker-compose -p psycopg2_test up
```
Notice all the tests run and depending on the way the psycopg2
package was installed there will or will not be `UserWarning`
messages.
```
use ctl-c or open another terminal to run the clean up command.
```

### The Clean Up command
```
docker-compose -p psycopg2_test down
```
This stops and deletes all service containers created
by the `up` command.


## Final Word
I was a little disappointed that I could not do it all in just
the compose file: I could not figure out how to get the `command:`
section to do both `pip install` and run the tests (escaping the
different types of quotes was the issue I could not get around).

Thank You,
Jamie
