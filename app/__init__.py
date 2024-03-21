from flask import Flask
from flask_restx import Api

def create_app():
    app = Flask(__name__)
    api = Api(app, version='1.0', title='API swagger',
              description='Una simple API demostrando Flask con Swagger UI')

    from .routes import main as main_blueprint
    api.add_namespace(main_blueprint)

    return app
