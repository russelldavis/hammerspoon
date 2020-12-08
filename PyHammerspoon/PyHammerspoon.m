#define PY_SSIZE_T_CLEAN
#include <Python.h>
#import "MJLua.h"
#import "LuaSkin/LuaSkin.h"




static PyMethodDef HammerspoonMethods[] = {
    // template: {"system", spam_system, METH_VARARGS, "Execute a shell command."},
    {NULL, NULL, 0, NULL} /* Sentinel */
};

static struct PyModuleDef module_def = {
    PyModuleDef_HEAD_INIT,
    "hammerspoon", /* name of module */
    NULL, /* module documentation, may be NULL */
    -1, /* size of per-interpreter state of the module,
           or -1 if the module keeps state in global variables. */
    HammerspoonMethods
};

PyMODINIT_FUNC PyInit_hammerspoon(void) {
    MJLuaCreate();
    LuaSkin *skin = [LuaSkin sharedWithState:NULL];
    lua_State *L = skin.L;

    PyObject *module = PyModule_Create(&module_def);
    if (PyErr_Occurred()) PyErr_Print();
    PyObject *stateCapsule = PyCapsule_New(L, "lua_State *", NULL);
    if (PyErr_Occurred()) PyErr_Print();
    PyObject *pyLocals = Py_BuildValue("{s:O, s:O}", "lua_state", stateCapsule, "mod", module);
    if (PyErr_Occurred()) PyErr_Print();

    PyObject * runResult = PyRun_String(
            "import lupa; mod.lua = lupa.LuaRuntime(state=lua_state, unpack_returned_tuples=True); mod.hs = lua.globals().hs",
            Py_file_input,
            pyLocals,
            pyLocals
    );
    if (PyErr_Occurred()) PyErr_Print();
    Py_DECREF(runResult);
    Py_DECREF(stateCapsule);
    Py_DECREF(pyLocals);

    return module;
}



// PyMODINIT_FUNC PyInit_hammerspoon(void) {
//     MJLuaCreate();
//     LuaSkin *skin = [LuaSkin sharedWithState:NULL];
//     lua_State *L = skin.L;

//     PyObject *stateCapsule = PyCapsule_New(L, "lua_State *", NULL);
//     if (PyErr_Occurred()) PyErr_Print();
//     PyObject *pyLocals = Py_BuildValue("{s:O}", "lua_state", stateCapsule);
//     if (PyErr_Occurred()) PyErr_Print();
//     PyObject * runResult = PyRun_String(
//             "import lupa; lua = lupa.LuaRuntime(state=lua_state, unpack_returned_tuples=True); hs = lua.globals().hs",
//             Py_file_input,
//             pyLocals,
//             pyLocals
//     );
//     if (PyErr_Occurred()) PyErr_Print();
//     Py_DECREF(runResult);
//     Py_DECREF(stateCapsule);


//     PyObject *module = PyModule_Create(&module_def);
//     if (PyErr_Occurred()) PyErr_Print();

//     PyObject *pyLua = PyDict_GetItemString(pyLocals, "lua");
//     if (PyErr_Occurred()) PyErr_Print();
//     Py_INCREF(pyLua);
//     if (PyModule_AddObject(module, "lua", pyLua) < 0) {
//         Py_DECREF(module);
//         Py_DECREF(pyLua);
//         return NULL;
//     }

//     PyObject *pyHs = PyDict_GetItemString(pyLocals, "hs");
//     if (PyErr_Occurred()) PyErr_Print();
//     Py_INCREF(pyHs);
//     if (PyModule_AddObject(module, "hs", pyHs) < 0) {
//         Py_DECREF(module);
//         Py_DECREF(pyHs);
//         return NULL;
//     }

//     Py_DECREF(pyLocals);

//     return module;
// }
