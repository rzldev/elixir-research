#!/bin/bash

db=${1:-discuss_dev}
docker exec -it postgresql sh -c "psql -U postgres -W ${db}"
