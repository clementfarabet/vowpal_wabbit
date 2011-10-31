
package = "allreduce"
version = "1.0-1"

source = {
   url = "allreduce-1.0-1.tgz"
}

description = {
   summary = "...",
   detailed = [[
   ]],
   homepage = "",
   license = "MIT/X11" -- or whatever you like
}

dependencies = {
   "lua >= 5.1",
   "torch",
   "sys",
   "nnx",
   "xlua"
}

build = {
   type = "cmake",

   variables = {
      CMAKE_INSTALL_PREFIX = "$(PREFIX)"
   }
}
