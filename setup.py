from setuptools import setup, Extension
from Cython.Build import cythonize

ext_module = Extension(
    "hammerspoon",
    sources=[
        "PyHammerspoon/PyHammerspoon.m",
        "lupa/lupa/_lupa.pyx",
        "Hammerspoon/MJAppDelegate.m",
        "Hammerspoon/MJAutoLaunch.m",
        "Hammerspoon/MJVersionUtils.m",
        "Hammerspoon/MJConsoleWindowController.m",
        "Hammerspoon/HSuicore.m",
        "Hammerspoon/MJFileUtils.m",
        "Hammerspoon/HSGrowingTextField.m",
        "Hammerspoon/MJDockIcon.m",
        "Hammerspoon/MJLua.m",
        "Hammerspoon/variables.m",
        "Hammerspoon/MJAccessibilityUtils.m",
        "Hammerspoon/MJMenuIcon.m",
        "Hammerspoon/MJUserNotificationManager.m",
        "Hammerspoon/HSAppleScript.m",
        "Hammerspoon/MJConfigUtils.m",
        "Hammerspoon/MJPreferencesWindowController.m",
        "Hammerspoon/HSLogger.m",
    ],
    include_dirs=[
        "Hammerspoon",
        "LuaSkin",
        "LuaSkin/lua-5.4.0/src",
        "Pods/headers/Public/Sentry",
    ],
    extra_compile_args=[
        # "-fno-common",
        # "-fobjc-exceptions",
        # "-stdlib=libc++",
        "-x", "objective-c",
        "-target", "x86_64-apple-macos10.12",
        "-fmessage-length=0",
        "-std=gnu99",
        "-fobjc-arc",
        "-fmodules",
        # "-fmodules-validate-once-per-build-session",
        "-Wnon-modular-include-in-framework-module",
        "-Werror=non-modular-include-in-framework-module",
        # "-fobjc-link-runtime",
        "-fsanitize=address",
        "-fsanitize=undefined",
        # "-undefined", "dynamic_lookup",
        "-F", "."
    ],
    extra_link_args=["-ObjC", "-undefined", "dynamic_lookup", "-F", ".", "-rpath", ".", "-framework", "LuaSkin"],
)

setup(
    name="hammerspoon",
    version="0.9.78",
    url="https://github.com/Hammerspoon/hammerspoon/",
    maintainer="Hammerspoon mailing list",
    maintainer_email="hammerspoon@googlegroups.com",
    description="Python wrapper around Hammerspoon",
    license='MIT style',
    classifiers=[
        'Intended Audience :: Developers',
        'Intended Audience :: Information Technology',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Operating System :: MacOS',
        'Topic :: Software Development',
    ],
    packages=['hammerspoon'],
    ext_modules=cythonize([ext_module]),
)