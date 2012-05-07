# allreduce: a simple Lua wrapper around vowpal wabbit's allreduce implementation

This is a simple Lua interface to John Langford's allreduce
implementation.

To use it, you simply neet to start a server on some arbitrary
machine:

``` sh
ssh mymachine
torch -lallreduce -e "allreduce.startserver()"
```

Once this daemon is running, you can run as many jobs as you
like, on any machine, provided that you point to 'mymachine'.

From machine 1:

``` lua
-- script 1:
allreduce.init('mymachine', 1, 2)  -- job 1/2
allreduce.average(somevector)
```

From machine 2:

``` lua
-- script 2:
allreduce.init('mymachine', 2, 2)  -- job 2/2
allreduce.average(somevector)
```

After these calls, both scripts will have the same 'somevector'.

A test is provided in the source tree. After starting the server on 'localhost',
you can run the test like this:

``` lua
# process 1:
torch test.lua -id 1 -total 2

# process 2:
torch test.lua -id 2 -total 2
```

## Install

Given a valid Torch7 install:

``` sh
torch-pkg install allreduce
```

or, to retrieve the sources:

``` sh
torch-pkg download allreduce
torch-pkg deploy allreduce
```

## Copyrights

This is the vowpal wabbit fast online learning code.  It is Copyright
(c) 2009 Yahoo! Inc, and released for use under the BSD (revised) open
source license.

Contributing authors are John Langford (Primary), Lihong Li, Alex
Strehl, and Shubham Chopra, and Gordon Rios.  This is the second VW
release, and our intention is to create an open source project this
time.

Checked into github with clone URL:
git://github.com/JohnLangford/vowpal_wabbit.git

To get the code install git -- in a clean directory:

git clone git://github.com/JohnLangford/vowpal_wabbit.git

Gordon created a tag for the completely stock initial distribution '2.3'
so to check out that original release and create a branch based on it:

git checkout 2.3
git checkout -b from-2.3

Or, in one command:

git checkout -b from-2.3 2.3

Swicegood, Travis. Pragmatic Version Control with Git. 2008. (p. 102)

Alternatively, the code can be downloaded directly from github:

http://github.com/gparker/vowpal_wabbit/downloads
