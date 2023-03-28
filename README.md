# SF food trucks API

Web service extending SF's food trucks open dataset available at https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data.

The source endpoint provides a csv response of food trucks and their locations and is fresh for about 6 hours. The extension adds query and ordering capabilities. At first impression the data looks like a join of locations and vendors suitable for noSQL storage.

# Implementation
REST API leveraging the Mojolicious perl MVC web framework - easy to deploy and self host with zero configuration. The csv file is used directly as an embedded sql database via the DBD::CSV module. The data is accessed via "Model" objects that are not dependent on the "Controller" implementation.

# Implementation details
- why perl?
I assumed it's the most relevant option

- why mojolicious? 
Easy to install and run, extendable all the way to PROD

- why CSV datastore?
Allows me to use the source data as-is without importing. Obviously not suitable for PROD

# Endpoints
- /v1/foodtruck/permits
- /v1/foodtruck/locations

# File structure
- lib
	- /Model
		- /Location.pm - locations endpoint
		- /Permit.pm   - permits endpoint
	- /Role
		- /Model - shared "Model" code
- t
	- /unit
	- /integration

- ftp_api.pl - entrypoint

# Prerequisites
- perl 5.16 (macos system perl ok)
- cpanm

# Installation
The included install.sh script will install the perl 3rd party dependecies

# Execution
The included run.sh script will start a web server on localhost:8080.


