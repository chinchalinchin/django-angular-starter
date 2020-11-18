from urllib.parse import urlencode
from django.http.request import HttpRequest
from . import settings
import logging, re
from debug import DebugLogger

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

            for key, value in request.session.items():
                if value is not None:
                    if len(str(key))>20:
                        print_key = key[:20]
                    else:
                        print_key = key
                    if len(str(value))>20:
                        print_value = value[:20]
                    else:
                        print_value = value
                    self.logger.info('>>> Session Variable %s = %s', print_key, value)

            if hasattr(request, 'user'):
                self.logger.info('>>> Session User: %s', request.user)
   
            if hasattr(request, 'headers'):
                for key, value in request.headers.items():
                    if len(str(key)) > 20 : 
                        print_key = key[:20]
                    else:
                        print_key = key
                    self.logger.info('>>> Request Header: %s', print_key)

            if hasattr(request.headers, 'Cookie'):
                if len(str(request.headers['Cookie'])) > 20:
                    print_cookie = request.headers['Cookie'][:20]
                else:
                    print_cookie = request.headers['Cookie']
                self.logger.info('>>> Cookie Header: %s', print_cookie)
                
            if 'X-CSRFToken' in request.headers:
                self.logger.info('>>> X-CSRFTOKEN Header: %s', request.headers['X-CSRFTOKEN'][0:20]) 

        response = self.get_response(request)

        return response