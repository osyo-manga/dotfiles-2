#!/bin/bash

PYTHON=/usr/local/bin/python

ENV=`$PYTHON -c "import os; print os.path.abspath(os.path.join(os.path.dirname(\"$0\"), '..'))"`

export PYTHONHOME=$ENV 
exec $PYTHON "$@"
