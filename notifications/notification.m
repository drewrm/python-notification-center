#include "notification.h"
#include <NSDate.h>
#include <NSString.h>

void Notification_dealloc(notifications_Notification* self)
{
  free(self->notification);
  self->ob_type->tp_free((PyObject*)self);
}

PyObject * Notification_new(PyTypeObject *type, PyObject *args, PyObject *kwargs) {
  notifications_Notification *self;
  self  = (notifications_Notification *) type->tp_alloc(type, 0);
  return (PyObject *)self;
}

int Notification_init(notifications_Notification *self, PyObject *args, PyObject *kwargs)
{
    self->notification = [[NSUserNotification alloc] init];
    self->delay = 0;

    PyObject *title=NULL, *subtitle=NULL, *content=NULL;

    static char *kwlist[] = {"title", "subtitle", "content", "delay", NULL};

    if (! PyArg_ParseTupleAndKeywords(args, kwargs, "|OOOi", kwlist, &title, &subtitle, &content, &self->delay))
        return -1; 

    if (title) {
        const char* s = PyString_AsString(title);
        [self->notification setTitle:  [NSString stringWithUTF8String: s]];
    }

    if (subtitle) {
        const char* s = PyString_AsString(subtitle);
        [self->notification setSubtitle:  [NSString stringWithUTF8String: s]];
    }


    if (content) {
        const char* s = PyString_AsString(content);
        [self->notification setInformativeText: [NSString stringWithUTF8String: s]];
    }

    [self->notification setDeliveryDate:[NSDate dateWithTimeInterval:self->delay sinceDate:[NSDate date]]];
    [self->notification setSoundName:NSUserNotificationDefaultSoundName];
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:self->notification];
    return 0;
}

