# run.py example

import sys
import time
from datetime import datetime

while True:
    print(datetime.utcnow().isoformat())
    sys.stdout.flush()
    time.sleep(1)