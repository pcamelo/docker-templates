#!/bin/bash

echo "******** Python environment information ********"

python -V
pip3 -V

echo "******** Installing python dependencies ********"

cd /opt/${PROJECT_NAME}
pip3 install --upgrade pip setuptools wheel
pip3 install -r requirements.txt

echo "******** Run project ********"

python run.py