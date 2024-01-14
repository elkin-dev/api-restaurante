class DevelopmentConfig:
    DEBUG = True
    DB_SERVER = "localhost"
    DB_USERNAME = "postgres"
    DB_PASSWORD = "0803"
    DB_NAME = "bd_restaurante"
    DB_PORT = "5432"


config = {
    "development": DevelopmentConfig,
    "host": "DB_SERVER",
    "port": "DB_PORT",
    "database": "DB_NAME",
    "user": "DB_USERNAME",
    "password": "DB_PASSWORD",
}
