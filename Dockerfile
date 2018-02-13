FROM python:3.6.4

# Pick (uncomment) how you want psycopg2
# to be installed:

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

RUN pip install --no-binary :all: psycopg2
