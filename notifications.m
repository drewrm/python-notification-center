#include <Python.h>
#import "notifications/notification.h"

static PyMethodDef notifications_methods[] = {
    {NULL}  /* Sentinel */
};

#ifndef PyMODINIT_FUNC	
#define PyMODINIT_FUNC void
#endif

PyMODINIT_FUNC 
initnotifications(void) 
{
    PyObject* m;

    notifications_NotificationType.tp_new = PyType_GenericNew;
    if (PyType_Ready(&notifications_NotificationType) < 0)
        return;


    m = Py_InitModule3("notifications", notifications_methods, "Wrapper around NSNotification API");
    if (m == NULL)
        return;


    Py_INCREF(&notifications_NotificationType);
    PyModule_AddObject(m, "UserNotification", (PyObject *)&notifications_NotificationType);
}
