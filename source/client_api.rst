********************
Using the Client API
********************

What is the Client API?
=======================

Overview
--------

Why should I use the Client API?
--------------------------------

Client-side authentication is intended for developers of Single Page Applications (SPAs) and mobile applications. It allows those applications to communicate directly with Stormpath in order to register and authenticate their users. As a developer, this allows you to ensure that only authenticated client requests are accepted by your server.

How does the Client API Work?
=============================

Configuring the Client API
==========================

Using the Client API from a Stormpath Client SDK
================================================

Overview
--------

Angular
-------

For an Angular application, the relevant configuration is found in ``app.js``. add the following line to the ``config`` function:

``STORMPATH_CONFIG.ENDPOINT_PREFIX = 'https://{DNS-LABEL}.apps.stormpath.io';``

Android
-------

For an Android application, in your Application class, change the ``.baseUrl`` in the ``onCreate`` method:

.. code-block:: java

  StormpathConfiguration stormpathConfiguration = new StormpathConfiguration.Builder()
          .baseUrl("https://{DNS-LABEL}.apps.stormpath.io")
          .build();
  Stormpath.init(this, stormpathConfiguration);

iOS
---

For a Swift-based iOS application, in ``AppDelegate.swift``, under ``application(application:didFinishLaunchingWithOptions:)``, change the ``APIURL``:

``Stormpath.sharedSession.configuration.APIURL = URL(string: "https://{DNS-LABEL}.apps.stormpath.io")!``

React
-----

For a React application, the URL is passed as part of the ``ReactStormpath.init();`` call:

.. code-block:: none

  ReactStormpath.init({
    endpoints: {
      baseUri: `https://{DNS-LABEL}.apps.stormpath.io`
    }
  });

Using the Client API from an HTTP Client
========================================

Account Registration
--------------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/register



Email Verification
--------------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/verify

Authentication
--------------

Login
^^^^^

**URL**

https://{DNS-LABEL}.apps.stormpath.io/login

.. code-block:: http

  POST /login
  Accept: application/json
  Content-Type: application/json

  {
    "login": "foo@bar.com",
    "password": "myPassword"
  }

**On Success**

Get back the Account

OAuth 2.0
^^^^^^^^^

**URL**

https://{DNS-LABEL}.apps.stormpath.io/oauth/token

Password
""""""""

.. code-block:: http

  POST /oauth/token

  grant_type=password
  &username=<username>
  &password=<password>

.. note::

  The ``username`` can also be the ``email``

Client Credentials
""""""""""""""""""

.. code-block:: http

  POST /oauth/token
  Authorization: Basic <base64UrlEncoded(apiKeyId:apiKeySecret)>

  grant_type=client_credentials

Refresh Token
"""""""""""""

.. code-block:: http

  POST /oauth/token
  grant_type=refresh_token&
  refresh_token=<refresh token>

Logout
------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/logout

Password Reset
--------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/forgot
https://{DNS-LABEL}.apps.stormpath.io/change

User Context
------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/me

ID Site
-------

??

A bit more complicated. The other endpoints redirect to ID Site depending on configuration.

Specifically:

``/login``
``logout``
``/register``
``/forgot``

Presumably ``/change``?