from urllib.parse import urlencode
from django.http.request import HttpRequest
from . import settings
import logging, re
from debug import DebugLogger

class DebugMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        self.logger=DebugLogger("core.middleware.DebugMiddleware").get_logger()
        
    def __call__(self, request: HttpRequest):

        if settings.DEBUG:
            self.logger.info('> Request Path: %s', request.path)
            self.logger.info('> Request Host: %s', request.META["HTTP_HOST"])

            for key, value in request.GET.items():
                self.logger.info('>> Request Parameter %s = %s', key, value)

            if hasattr(request, "session"):
                for key, value in request.session.items():
                    if value is not None:
                        self.logger.info('>>> Session Variable %s = %s', key, value)

            if hasattr(request, 'user'):
                self.logger.info('>>>> Session User: %s', request.user)
   
        response = self.get_response(request)

        return response