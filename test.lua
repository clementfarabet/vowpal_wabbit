
require 'lab'
require 'allreduce'

torch.setdefaulttensortype('torch.FloatTensor')

if #arg == 0 then
	error('please provide job number')
end

jobid = tonumber(arg[1])
jobtotal = tonumber(arg[2] or 1)

if jobid == 1 then
	x = lab.zeros(10)
else
	x = lab.ones(10)
end

allreduce.init('localhost', jobid, jobtotal)

print('job ' .. jobid .. ' - sending vector:')
print(x)

-- 3 different reduce types:
allreduce.average(x)
--red = allreduce.accumulate(x)
--red = allreduce.best(x, score)

print('job ' .. jobid .. ' - reduced vector is:')
print(x)
