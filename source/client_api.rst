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

  POST /login HTTP/1.1
  Accept: application/json
  Content-Type: application/json
  Origin: http://localhost:3000
  Host: smooth-ensign.apps.dev.stormpath.io

  {
    "login":"jakub@stormpath.com",
    "password":"Password1!"
  }

**On Success**

200 OK along with the Account + an access_token and refresh_token

.. code-block:: json

  {
    "account": {
      "href": "https://dev.i.stormpath.com/v1/accounts/7gzK1RBUk2tF3VNhZ3AYFI",
      "createdAt": "2016-10-26T16:48:14.457Z",
      "modifiedAt": "2016-10-26T16:48:14.457Z",
      "username": "jakub",
      "email": "jakub@stormpath.com",
      "givenName": "Jakub",
      "middleName": "",
      "surname": "Sw",
      "status": "ENABLED",
      "fullName": "Jakub Sw"
    }
  }

OAuth 2.0
^^^^^^^^^

**URL**

https://{DNS-LABEL}.apps.stormpath.io/oauth/token

Password
""""""""

**Request**

.. code-block:: http

  POST /oauth/token HTTP/1.1
  Accept: application/json
  Content-Type: application/x-www-form-urlencoded
  Host: smooth-ensign.apps.dev.stormpath.io
  Connection: close
  User-Agent: Paw/3.0.12 (Macintosh; OS X/10.12.1) GCDHTTPRequest
  Content-Length: 72

  grant_type=password&username=jakub%40stormpath.com&password=Password1%21

**Response**

.. code-block:: json

  {
    "access_token": "eyJraWQi[...]0dTpiM",
    "refresh_token": "eyJraWQi[...]okvVI",
    "token_type": "Bearer",
    "expires_in": 3600
  }

.. note::

  The ``username`` can also be the ``email``

Client Credentials
""""""""""""""""""

**Request**

.. code-block:: http

  POST /oauth/token HTTP/1.1
  Accept: application/json
  Content-Type: application/x-www-form-urlencoded
  Authorization: Basic MzZGT1dDWUJBMk1KMVBQWlVZNkE2RkMxNDp6eTY3VFlZMGR2QjdnSnBnR0F5d0k4SWFhQkpSUTZhZ3ZHajZnSWMyeEVV
  Host: smooth-ensign.apps.dev.stormpath.io
  Connection: close
  User-Agent: Paw/3.0.12 (Macintosh; OS X/10.12.1) GCDHTTPRequest
  Content-Length: 29

  grant_type=client_credentials

**Response**

.. code-block:: json

  {
    "access_token": "eyJraWQ[...]NRaztg0",
    "token_type": "Bearer",
    "expires_in": 3600
  }

Refresh Token
"""""""""""""

**Request**

.. code-block:: http

  POST /oauth/token HTTP/1.1
  Accept: application/json
  Content-Type: application/x-www-form-urlencoded
  Host: smooth-ensign.apps.dev.stormpath.io

  grant_type=refresh_token&refresh_token=eyJraWQ[...]FMQIh-fwns


**Response**

.. code-block:: json

  {
    "access_token": "eyJraWQ[...]urs4iqPY",
    "refresh_token": "eyJraWQ[...]fwns",
    "token_type": "Bearer",
    "expires_in": 3600
  }

Logout
------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/logout

**Request**

.. code-block:: http

  POST /logout HTTP/1.1
  Host: smooth-ensign.apps.dev.stormpath.io
  Connection: close
  Content-Length: 0

**Response**

.. code-block:: none

  HTTP/1.1 200
  Date: Thu, 27 Oct 2016 20:42:40 GMT
  Set-Cookie: access_token=;Max-Age=0;path=/;HttpOnly
  Set-Cookie: refresh_token=;Max-Age=0;path=/;HttpOnly
  Content-Length: 0

Password Reset
--------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/forgot
https://{DNS-LABEL}.apps.stormpath.io/change

User Context
------------

**URL**

https://{DNS-LABEL}.apps.stormpath.io/me

**Request**

.. code-block:: http

  GET /me HTTP/1.1
  Content-Type: application/json; charset=utf-8
  Cookie: access_token=eyJraW[...]tIUxpdhBJz74LR0dd90RQTnl-u-_hgOOkpA
  Host: smooth-ensign.apps.dev.stormpath.io

**Response**

.. code-block:: json

  {
    "account": {
      "href": "https://dev.i.stormpath.com/v1/accounts/7gzK1RBUk2tF3VNhZ3AYFI",
      "createdAt": "2016-10-26T16:48:14.457Z",
      "modifiedAt": "2016-10-26T16:48:14.457Z",
      "username": "jakub",
      "email": "jakub@stormpath.com",
      "givenName": "Jakub",
      "middleName": "",
      "surname": "Sw",
      "status": "ENABLED",
      "fullName": "Jakub Sw"
    }
  }



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