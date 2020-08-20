#!/bin/bash

echo "******** Python environment information ********"

python -V
pip3 -V

echo "******** Run project ********"

cd /opt/${PROJECT_NAME}
python run.py