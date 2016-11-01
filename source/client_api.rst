************************
8? Using the Client API
************************

What is the Client API?
=======================

Client-side authentication is intended for developers of Single Page Applications (SPAs) and mobile applications who are either using a serverless architecture, or do not want to implement Stormpath on their backend application servers.



Since these client applications are not able to securely store API Keys, the Client API endpoints allow for basic user registration and management tasks to be performed without requiring any authentication. This means that your client applications can use these endpoints in order to, for example,  authenticate a user and get back a session. With this session in hand, the client application can then continue on with its own functionality, or securely communicate with a back-end application server.

Why should I use the Client API?
--------------------------------

Scenario 1: A serverless client application...

This is relatively straightforward

Scenario 2: A serverful client application...

This isn't.

How does the Client API Work?
=============================

The Client API exposes a configurable set of endpoints to your applications. Using these endpoints, the applications can:

- Authenticate an existing user and get back either their Account information or OAuth 2.0 tokens
- Retrieve the current user's Account information
- Log out an already authenticated user
- Register a new user
- Trigger the email verification workflow, as well as send a verification of that email
- Trigger the password reset email, as well as send an updated password
- ID Site??

Since all of these endpoints do not require an API Key, you do not have to worry about storing one on your client application, or having to inject one via a proxy server. Additionally, these endpoints allow your client applications to use Stormpath's entire identity management system without having to add any Stormpath code to your application backend.

An example user flow could look as follows:

1. The user lands on the login page for your Angular application
2.

Configuring the Client API
==========================

The recommended way to configure the behavior of your Application's Client API is via the Stormpath Admin Console.

Using the Client API from a Stormpath Client SDK
================================================

Overview
--------

Angular
-------

For an Angular application, the relevant configuration is found in ``app.js``. Add the following line to the ``config`` function:

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

``https://{DNS-LABEL}.apps.stormpath.io/register``

**Request**

.. code-block:: http

  POST /register HTTP/1.1
  Content-Type: application/json; charset=utf-8
  Host: violet-peace.apps.dev.stormpath.io

  {
    "email": "jakub@stormpath.com",
    "password": "Password",
    "givenName": "Jakub",
    "surname": "S"
  }

**Response**

.. code-block:: json

  {
    "account": {
      "href": "https://dev.i.stormpath.com/v1/accounts/5kYvdJyROImkrMHVD2fhSG",
      "createdAt": "2016-10-28T20:40:18.463Z",
      "modifiedAt": "2016-10-28T20:40:18.463Z",
      "username": "jakub+test9@stormpath.com",
      "email": "jakub+test9@stormpath.com",
      "givenName": "Jakub",
      "middleName": null,
      "surname": "S",
      "status": "ENABLED",
      "fullName": "Jakub S"
    }
  }


Email Verification
--------------------

**URL**

``https://{DNS-LABEL}.apps.stormpath.io/verify``

TRIGGER VERIFICATION EMAIL

**Request**

.. code-block:: http

  POST /verify HTTP/1.1
  Accept: application/json
  Content-Type: text/plain; charset=utf-8
  Host: violet-peace.apps.dev.stormpath.io

  {
    "email": "jakub@stormpath.com"
  }

**Response**

200 OK

SEND VERIFICATION TOKEN

**Request**

GET /verify?sptoken=10vphI5BzhVLczsxJKuImq HTTP/1.1
Accept: application/json
Host: violet-peace.apps.dev.stormpath.io

**Response**

200 OK


Authentication
--------------

Login
^^^^^

**URL**

``https://{DNS-LABEL}.apps.stormpath.io/login``

.. code-block:: http

  POST /login HTTP/1.1
  Accept: application/json
  Content-Type: application/json
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

``https://{DNS-LABEL}.apps.stormpath.io/oauth/token``

Password
""""""""

**Request**

.. code-block:: http

  POST /oauth/token HTTP/1.1
  Accept: application/json
  Content-Type: application/x-www-form-urlencoded
  Host: smooth-ensign.apps.dev.stormpath.io

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
  Authorization: Basic MzZGT1dDWUJBMk1KMVBQWlVZ[...]4SWFhQkpSUTZhZ3ZHajZnSWMyeEVV
  Host: smooth-ensign.apps.dev.stormpath.io

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

``https://{DNS-LABEL}.apps.stormpath.io/logout``

**Request**

.. code-block:: http

  POST /logout HTTP/1.1
  Host: smooth-ensign.apps.dev.stormpath.io

**Response**

HTTP/1.1 200

Password Reset
--------------

FORGOT

Used to trigger the password reset email

**URL**

``https://{DNS-LABEL}.apps.stormpath.io/forgot``

**Request**

.. code-block:: http

  POST /forgot HTTP/1.1
  Accept: application/json
  Content-Type: application/json; charset=utf-8
  Host: violet-peace.apps.dev.stormpath.io

  {
    "email": "jakub@stormpath.com"
  }

**Response**

HTTP/1.1 200

CHANGE

To actually change the password. This is the endpoint that a user will use if they have received a password reset email and have clicked on the link in the email. The link will point to this endpoint, and contain the sptoken query parameter.

**URL**

``https://{DNS-LABEL}.apps.stormpath.io/change``

**Request**

.. code-block:: http

  POST /change HTTP/1.1
  Accept: application/json
  Content-Type: application/json; charset=utf-8
  Host: violet-peace.apps.dev.stormpath.io

  {
    "sptoken": "eyJ0aWQiOiIyWnU4ekw2ZndvMjdUVEtBeGp0dmVtIiwic3R0IjoiYXNzZXJ0aW9uIiwiYWxnIjoiSFMyNTYifQ%2EeyJleHAiOjE0Nzc3NzUzNjIsImp0aSI6IjZFMWo0aTN4QkdPV1g2OXhrVDNSRG8ifQ%2ECOmIVRr3pQ4jsIhKl7wWjHkYTfX1Reg3BV0kAlMSQpc",
    "password": "Password1!"
  }

**Response**

HTTP/1.1 200

User Context
------------

**URL**

``https://{DNS-LABEL}.apps.stormpath.io/me``

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

By default this call will return:

- ``href``
- ``createdAt``
- ``modifiedAt``
- ``username``
- ``email``
- ``givenName``
- ``middleName``
- ``surname``
- ``status``
- ``fullName``

What else returns is configurable.

You can also get back the Accounts expanded:

- API Keys
- Applications
- Custom Data
- Group Memberships
- Groups
- Provider Data
- Directory
- Tenant

ID Site
-------

??

A bit more complicated. The other endpoints redirect to ID Site depending on configuration.

Specifically:

``/login``
``/logout``
``/register``
``/forgot``
Presumably ``/change``?

All redirect you to ID Site.