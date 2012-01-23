
require 'xlua'
require 'torch'
require 'liballreduce'

allreduce = {}
local parameters = {}

function allreduce.init(master_location, node, total, unique_id)
   parameters.master_location = master_location or 'localhost'
   parameters.unique_id = unique_id or 0
   parameters.total = total or 1
   parameters.node = (node or 1) - 1
end

function allreduce.accumulate(data)
   local time = data.allreduce.accumulate(data, 
                                          parameters.master_location, 
                                          parameters.unique_id, 
                                          parameters.total,
                                          parameters.node)
   return time
end

function allreduce.average(data)
   local time = data.allreduce.accumulate(data, 
                                          parameters.master_location, 
                                          parameters.unique_id, 
                                          parameters.total,
                                          parameters.node)
   data:div(parameters.total)
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
