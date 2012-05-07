----------------------------------------------------------------------
-- This is a simple Lua interface to John Langford's allreduce
-- implementation.
--
-- To use it, you simply neet to start a server on some arbitrary
-- machine:
-- $ ssh mymachine
-- $ torch -lallreduce -e "allreduce.startserver()"
--
-- Once this daemon is running, you can run as many jobs as you
-- like, on any machine, provided that you point to 'mymachine'.
-- From Lua:
-- -- script 1:
-- > allreduce.init('mymachine', 1, 2)  -- job 1/2
-- > allreduce.average(somevector)
--
-- -- script 2:
-- > allreduce.init('mymachine', 2, 2)  -- job 2/2
-- > allreduce.average(somevector)
--
-- After these calls, both scripts will have the same 'somevector'.
--
-- Author: Clement Farabet
----------------------------------------------------------------------

require 'torch'
require 'liballreduce'
require 'paths'

allreduce = {}
local parameters = {}

function allreduce.startserver()
   print('<allreduce> (re)starting server on local machine')
   os.execute('killall allserver > /dev/null')
   os.execute(paths.concat(paths.install_bin,'allserver'))
end

function allreduce.init(master_location, node, total, unique_id)
   parameters.master_location = master_location or 'localhost'
   parameters.unique_id = unique_id or 0
   parameters.total = total or 1
   parameters.node = (node or 1) - 1
end

function allreduce.accumulate(data)
   if data:type() ~= 'torch.FloatTensor' then
      error('<allreduce> only supporting FloatTensor type for now')
   end
   local time = data.allreduce.accumulate(data, 
                                          parameters.master_location, 
                                          parameters.unique_id, 
                                          parameters.total,
                                          parameters.node)
   return time
end

function allreduce.average(data)
   if data:type() ~= 'torch.FloatTensor' then
      error('<allreduce> only supporting FloatTensor type for now')
   end
   local time = data.allreduce.accumulate(data, 
                                          parameters.master_location, 
                                          parameters.unique_id, 
                                          parameters.total,
                                          parameters.node)
   data:div(parameters.total)
   return time
end

function allreduce.best(data, score)
   if data:type() ~= 'torch.FloatTensor' then
      error('<allreduce> only supporting FloatTensor type for now')
   end
   local time = data.allreduce.best(data, 
                                    parameters.master_location, 
                                    parameters.unique_id, 
                                    parameters.total,
                                    parameters.node,
                                    score)
   return time
end
