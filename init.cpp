#include "TH.h"
#include "luaT.h"

#include <sys/timeb.h>

#include "allreduce.h"

static const void* torch_FloatTensor_id = NULL;

static int allreduce_accumulate(lua_State *L) {
  // get args
  THFloatTensor *data = (THFloatTensor *)luaT_checkudata(L, 1, torch_FloatTensor_id);
  const char *master_location_c = lua_tostring(L, 2);
  std::string master_location(master_location_c);
  size_t unique_id = lua_tonumber(L, 3);
  size_t total = lua_tonumber(L, 4);
  size_t node = lua_tonumber(L, 5);

  // raw pointer
  data = THFloatTensor_newContiguous(data);
  float *raw = THFloatTensor_data(data);
  int n = sizeof(float) * THFloatTensor_nElement(data);

  // all reduce
  struct timeb t_start, t_end;
  double net_comm_time = 0.;
  ftime(&t_start);
  all_reduce((char*)raw, n, master_location, unique_id, total, node);
  ftime(&t_end);
  net_comm_time += (int) (1000.0 * (t_end.time - t_start.time) + (t_end.millitm - t_start.millitm));

  // return
  lua_pushnumber(L, net_comm_time);
  THFloatTensor_free(data);
  return 1;
}

static const struct luaL_Reg allreduce_methods__ [] = {
  {"accumulate", allreduce_accumulate},
  {NULL, NULL}
};

extern "C" {
  DLL_EXPORT int luaopen_liballreduce(lua_State *L)
  {
    torch_FloatTensor_id = luaT_checktypename2id(L, "torch.FloatTensor");

    luaT_pushmetaclass(L, torch_FloatTensor_id);
    luaT_registeratname(L, allreduce_methods__, "allreduce");
    lua_pop(L,1);

    return 1;
  }
}
