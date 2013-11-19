python-notification-center
================================

A python module that wraps NSUserNotification on Mac OSX. Not using
PyObjC, just because I wanted to write a native Python module

Usage:

    import notifications
    n = notifications.UserNotification(title="Hello World", body="Testing testing testing")
    n.delay = 60
    n.show()
