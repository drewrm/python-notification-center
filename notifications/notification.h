#include <Python.h>
#include <NSUserNotification.h>

typedef struct {
  PyObject_HEAD;
  NSUserNotification *notification;
  int delay;
} notifications_Notification;

void Notification_dealloc(notifications_Notification*);
PyObject * Notification_new(PyTypeObject*, PyObject*, PyObject*);
int Notification_init(notifications_Notification *self, PyObject *args, PyObject *kwds);

static PyTypeObject notifications_NotificationType = {
     PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "notifications.Notification",             /*tp_name*/
    sizeof(notifications_Notification),             /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Notification_dealloc, /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "NSUserNotification Wrapper",           /* tp_doc */
    0,		               /* tp_traverse */
    0,		               /* tp_clear */
    0,		               /* tp_richcompare */
    0,		               /* tp_weaklistoffset */
    0,		               /* tp_iter */
    0,		               /* tp_iternext */
    0,             /* tp_methods */
    0,             /* tp_members */
    0,                         /* tp_getset */
    0,                         /* tp_base */
    0,                         /* tp_dict */
    0,                         /* tp_descr_get */
    0,                         /* tp_descr_set */
    0,                         /* tp_dictoffset */
    (initproc) Notification_init,      /* tp_init */
    0,                         /* tp_alloc */
    Notification_new,                 /* tp_new */
};

