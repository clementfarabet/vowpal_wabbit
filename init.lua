
require 'xlua'
require 'torch'
require 'liballreduce'

allreduce = {}
local parameters = {}

function allreduce.init(master_location, unique_id, total, node)
   parameters.master_location = master_location or 'localhost'
   parameters.unique_id = unique_id
   parameters.total = total
   parameters.node = node-1
end

function allreduce.accumulate(data)
   local time = data.allreduce.accumulate(data, 
                                          parameters.master_location, 
                                          parameters.unique_id, 
                                          parameters.total,
                                          parameters.node)
   return time
end

function allreduce.best(data, score)
   local time = data.allreduce.best(data, 
                                    parameters.master_location, 
                                    parameters.unique_id, 
                                    parameters.total,
                                    parameters.node,
                                    score)
   return time
end
