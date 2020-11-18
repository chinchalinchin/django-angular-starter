import logging, os
from core import settings as config

class DebugLogger():

    def __init__(self, location_name):
        self.logger = self.init_logger(location_name)

    def init_logger(self, location_name):
        this_logger = logging.getLogger(location_name)
        this_logger.setLevel(logging.INFO)
        ch = logging.StreamHandler()
        format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        ch.setLevel(logging.INFO)
        ch.setFormatter(format)
        this_logger.addHandler(ch)
        return this_logger

    def get_logger(self):
        return self.logger
        
    def log_settings(self):
        self.logger.info("-------------------------------------------------")
        self.logger.info('SETTINGS.PY Configuration')
        self.logger.info("-------------------------------------------------")
        self.logger.info("# Main Configuration")
        self.logger.info("> ROOT LOCATION: %s", config.BASE_DIR)
        self.logger.info('> DEBUG : %s', config.DEBUG)
        self.logger.info("-------------------------------------------------")
        self.logger.info("# Environment Configuration")
        self.logger.info('> APP_ENV: %s', config.APP_ENV)
        self.logger.info("-------------------------------------------------")
        self.logger.info("# Database Configuration")
        self.logger.info('> BACKEND: %s', config.DATABASES['default']['ENGINE'])
        self.logger.info('> HOST: %s', config.DATABASES['default']['HOST'])
        self.logger.info('> PORT: %s', config.DATABASES['default']['PORT'])
        self.logger.info('> NAME: %s', config.DATABASES['default']['NAME'])

if __name__ == "__main__":
    logger = DebugLogger("debug.py")
    logger.log_settings()