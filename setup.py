from distutils.core import setup, Extension

notifications = Extension('notifications',
                    sources = ['notifications.m', 'notifications/notification.m'],
                    extra_link_args = ['-framework', 'Foundation'],
                    extra_compile_args = ['-I', '/System/Library/Frameworks/Foundation.framework/Headers'])

setup (name = 'Notifications',
       version = '1.0',
       description = 'This is a demo package',
       ext_modules = [notifications])
