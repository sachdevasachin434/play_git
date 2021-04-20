import os, json, subprocess

if (subprocess.call(['sh', './pre-commit.sh'])):
    # raise Exception
    exit 1
else:
    pass
