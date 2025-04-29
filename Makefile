#################################################################################
#
# Makefile to build the project
#
#################################################################################
PROJECT_NAME = WHO-ETL
REGION = eu-west-2
PYTHON_INTERPRETER = python
WD=$(shell pwd) #determines where root directory is
PYTHONPATH=${WD}
SHELL := /bin/bash
PROFILE = default
PIP:=pip
GIT:= git
ACTIVATE_ENV := source ./venv/bin/activate

#CREATE PYTHON INTERPRETER ENVIRONMENT
###################################################################################
create-environment:	
	$(PYTHON_INTERPRETER) -m venv venv

#Activate venv
define execute_in_env
$(ACTIVATE_ENV) && $1
endef

#BUILD THE ENVIRONMENT REQUIREMENTS
##########################################################################
requirements: create-environment
	$(call execute_in_env, $(PIP) install -r ./requirements.txt)
	$(call execute_in_env, $(PIP) install -r ./requirements.txt -t dependencies/python)


#RUN TESTS
#########################################################################
# Run the security test (bandit)
security-test:
	$(call execute_in_env, bandit -lll ./src/*.py)

# Run pip-audit test
audit-test:
	$(call execute_in_env, pip-audit)

# Run the black code check
run-black:
	$(call execute_in_env, black --line-length 79 ./src/*.py)

# Run docformatter
run-docformatter:
	$(call execute_in_env, docformatter --in-place --wrap-summaries \
	79 --wrap-descriptions 79 ./src/*.py)

# # Run the unit tests
# unit-test:
# 	$(call execute_in_env, PYTHONPATH=${PYTHONPATH} pytest ./test/*.py  ./test_utils/*.py )

# Run the coverage check
check-coverage:
	$(call execute_in_env, PYTHONPATH=${PYTHONPATH} pytest --cov=src test/)
	$(call execute_in_env, PYTHONPATH=${PYTHONPATH} pytest --cov=util_func test_utils/)

# Run security tests
run-security: security-test	audit-test


# Run formatting and tests
run-checks: run-black run-docformatter check-coverage #unit-test

# Run all
run-all: requirements run-security run-checks