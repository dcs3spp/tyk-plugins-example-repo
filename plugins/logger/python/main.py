from tyk.decorators import *
from gateway import TykGateway as tyk
from time import time


@Hook
def PreHook(request, session, spec):
    tyk.log("PreHook is called", "info")
    return request, session


@Hook
def PostHook(request, session, spec):
    tyk.log("PostHook is called", "info")
    return request, session


@Hook
def AuthCheck(request, session, metadata, spec):
    tyk.log("AuthCheck is called", "info")

    return request, session, metadata


@Hook
def PostKeyAuth(request, session, spec):
    tyk.log("PostKeyAuth is called", "info")

    return request, session


@Hook
def ResponseHook(request, response, session, metadata, spec):
    tyk.log("ResponseHook is called", "info")
    tyk.log("ResponseHook: upstream returned {0}".format(response.status_code), "info")

    return response
