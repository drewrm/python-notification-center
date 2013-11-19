python-notification-center
================================

A python module that wraps NSUserNotification on Mac OSX.

Usage:

    import notifications
    n = notifications.UserNotification(title="Hello World", content="Testing testing testing")
    n = notifications.UserNotification(title="Hello World", content="Testing testing testing", delay=10)
