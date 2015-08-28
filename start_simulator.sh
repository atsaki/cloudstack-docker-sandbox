#!/bin/sh
docker run --name cloudstack -d -p 8080:8080 atsaki/cloudstack-simulator:4.5.2-advanced
