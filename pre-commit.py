import os, json, subprocess

if (subprocess.call(['sh', './pre-commit.sh'])):
    exit(1)
else:
    exit(0)
