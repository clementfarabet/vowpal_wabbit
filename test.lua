
import 'torch'
require 'sys'
require 'allreduce'

torch.setdefaulttensortype('torch.FloatTensor')

dname,fname = sys.fpath()
cmd = torch.CmdLine()
cmd:text()
cmd:text('AllReduce test script')
cmd:text()
cmd:text('Options:')
cmd:option('-id', 1, 'job\s unique ID')
cmd:option('-total', 1, 'total number of jobs')
cmd:option('-server', 'localhost', 'job server address')
cmd:option('-type', 'average', 'reduce type: average | accumulate | best')
cmd:text()
opt = cmd:parse(arg)

jobid = opt.id
jobtotal = opt.total
server = opt.server

if jobid == 1 then
   x = zeros(10)
else
   x = ones(10)
end

allreduce.init(server, jobid, jobtotal)

print('job ' .. jobid .. ' - sending vector:')
print(x)

if opt.type == 'average' then
	allreduce.average(x)
elseif opt.type == 'accumulate' then
	allreduce.accumulate(x)
else
	score = random.uniform(0,1)
	allreduce.best(x, score)
end

print('job ' .. jobid .. ' - reduced vector is:')
print(x)
