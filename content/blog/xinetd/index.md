+++
title="Using Xinetd and Github Hooks for Automatic Deployment"
date=2019-03-30
draft=true
+++


# Pulling from GitHub
https://github.blog/2015-06-16-read-only-deploy-keys/

# Configuring xinetd

link: https://github.com/openSUSE/xinetd

```conf
service github-hooks
{
    socket_type = stream
    protocol    = tcp
    port        = 61000
    wait        = no
    user        = optimal
    server      = /home/optimal/bin/githook
    instances   = 2
}
```

```config
github-hooks 61000/tcp          # github hooks
```

```python
#!/usr/bin/python

import sys, fileinput, json

length = 0
payload = {}
def isBlank(x): return not x.strip()
with open("/home/optimal/log.txt","a") as f:
    while True:
        line = sys.stdin.readline()
        if line.startswith("Content-Length:"):
            lenstr = line.split(':')[1].strip()
            length = int(lenstr)
        if isBlank(line):
            if length > 0:
                data = sys.stdin.read(length)
                end = data.rfind('}')+1
                data = data[:end]
                payload = json.loads(data)
                f.write(json.dumps(payload))
            break

print "HTTP/1.1 200 OK\n\nkkthxbye"
print payload['repository']['full_name']

```

```python
#!/usr/bin/python

import sys, os, fileinput, json, subprocess
from os.path import expanduser

REPO_FULL_NAME = "ericharding/OptimalStake"
REPO_LOCAL_PATH = expanduser("~/www/")

length = 0
payload = {}
def isBlank(x): return not x.strip()
def log(x):
    with open("/home/optimal/gitlog.txt","a") as f:
        f.write(x)

while True:
    line = sys.stdin.readline()
    if line.startswith("Content-Length:"):
        lenstr = line.split(':')[1].strip()
        length = int(lenstr)
    if isBlank(line):
        if length > 0:
            data = sys.stdin.read(length)
            end = data.rfind('}')+1
            data = data[:end]
            payload = json.loads(data)
        break

print "HTTP/1.1 200 OK\n\nkkthxbye"

repoName = payload['repository']['full_name']
repoId = payload['repository']['id']
sender = payload['sender']['login']

log("Request update '{0}' id={1} by '{2}'".format(repoName, repoId, sender))
if repoName == REPO_FULL_NAME:
    os.chdir(REPO_LOCAL_PATH)
    subprocess.call(["git", "pull"])
```

# Security