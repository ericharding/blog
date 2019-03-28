+++
title="Using Xinetd with Github Hooks"
date=2019-03-30
+++

Recently needed an easy way to collaborate on a static html site (yes, plain old html).  I wanted it to be really easy to deploy so using a github with a hook seemed like a natural option. 

It seems gratuitous to run a service just to handle a single endpoint and do a pull. The site was static so it didn't need anything other than nginx and it was running on a VPS so I wanted to use as little memory as possible.

Looking around I found a few scripts that would work but even the smallest one (python) seemed to use about 18mb of ram when running.  I also didn't know the pedigree of these scripts and didn't want to have to babysit them if they weren't completely stable.

<!-- more --> 

# Enter xinetd  

[xinetd](https://en.wikipedia.org/wiki/Xinetd) is an internet [super-server](https://en.wikipedia.org/wiki/Super-server) which was originally written in 2003ish (it predates npm by years) to replace ined and is still maintained and included in almost every linux distribution. It's also written in plain C so it only uses 2mb of ram when running.

Xinetd works in the unix tradition of doing one simple thing and doing it well.  It will listen on a port (in our case a TCP port) and when something connects it will start a process of your choosing and map stdin/stdout to that socket.  That's it!  Your processes doesn't have to understand sockets or.... TODO

## Configure nginx

First lets get the nginx config out of the way. 

We don't want to open a new port on our firewall just for xinetd so we'll do a proxy_pass from our webserver to hit a port on localhost.

```nginx
location /update {
    proxy_pass http://localhost:61000/;
}
```

## Configure xinetd

If you don't have xinetd installed you can get it with your favorite local neighborhood package manager.  `apt-get install xinetd` if you're on Debian/Ubuntu.

xinetd requires that the port you are listening on be defined in /etc/services.  I'm not sure why it needs this exactly but it complains if it's not there. ¯\_(ツ)_/¯

```config
github-hooks 61000/tcp          # github hooks
```

Then we add our service definition to /etc/xinetd.d/.  Just create a new file called `github-hooks` and add this:

```conf
service github-hooks
{
    socket_type = stream
    protocol    = tcp
    port        = 61000
    wait        = no
    user        = optimal
    server      = /home/site/bin/githook
    instances   = 2
}
```

The first thing to notice is that xinetd doesn't speak HTTP (I know, crazy, right?).  



# Pulling from GitHub
https://github.blog/2015-06-16-read-only-deploy-keys/

# Configuring xinetd

link: https://github.com/openSUSE/xinetd



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