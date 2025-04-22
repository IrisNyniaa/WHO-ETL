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
