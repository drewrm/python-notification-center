#include "notification.h"
#include <NSDate.h>
#include <NSString.h>

static notifications_Notification* set_field(notifications_Notification*, PyObject*);

void Notification_dealloc(notifications_Notification* self)
{
  Py_XDECREF(self->title);
  Py_XDECREF(self->subtitle);
  Py_XDECREF(self->body);
  self->ob_type->tp_free((PyObject*)self);
}

PyObject * Notification_new(PyTypeObject *type, PyObject *args, PyObject *kwargs) {
  notifications_Notification *self;
  self  = (notifications_Notification *) type->tp_alloc(type, 0);

  if (self != NULL) {
    if (set_field(self, self->title) == NULL) return NULL;
    if (set_field(self, self->subtitle) == NULL) return NULL;
    if (set_field(self, self->body) == NULL) return NULL;
    self->delay = 0;
  }

  return (PyObject *)self;
}

static notifications_Notification* set_field(notifications_Notification *self, PyObject *field) {
  if (self != NULL) {
    field = PyString_FromString("");
    if (field == NULL)
    {
      Py_DECREF(self);
      return NULL;
    }
  }

  return self;
}

int Notification_init(notifications_Notification *self, PyObject *args, PyObject *kwargs)
{

  PyObject *title=NULL, *subtitle=NULL, *body=NULL, *tmp=NULL;

  static char *kwlist[] = {"title", "subtitle", "body", "delay", NULL};

  if (! PyArg_ParseTupleAndKeywords(args, kwargs, "|OOOi", kwlist, &title, &subtitle, &body, &self->delay))
    return -1; 

  if (title) {
    tmp = self->title;
    Py_XDECREF(tmp);
    self->title = title;
    Py_INCREF(self->title);
  }

  if (subtitle) {
    tmp = self->subtitle;
    Py_XDECREF(tmp);
    self->subtitle = subtitle;
    Py_INCREF(self->subtitle);
  }

  if (body) {
    tmp = self->body;
    Py_XDECREF(tmp);
    self->body = body;
    Py_INCREF(self->body);
  }

  return 0;
}

PyObject* Notification_show(notifications_Notification *self) {
  NSUserNotification *notification = [[NSUserNotification alloc] init];
  if (self != NULL) {
    if (self->title != NULL) {
      const char* t = PyString_AsString(PyObject_Repr(self->title));
      [notification setTitle: [NSString stringWithUTF8String: t]];
    }
    if (self->subtitle != NULL) {
      const char* s = PyString_AsString(PyObject_Repr(self->subtitle));
      [notification setSubtitle: [NSString stringWithUTF8String: s]];
    }
    if (self->body != NULL) {
      const char* b = PyString_AsString(PyObject_Repr(self->body));
      [notification setInformativeText: [NSString stringWithUTF8String: b]];
    }
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:self->delay sinceDate:[NSDate date]]];
  }

  [notification setSoundName:NSUserNotificationDefaultSoundName];
  NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
  [center scheduleNotification:notification];
  [notification release];
  return Py_BuildValue("");
}

