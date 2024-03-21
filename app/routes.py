from flask_restx import Namespace, Resource

main = Namespace('main', description='Operaciones principales')

@main.route('/hola')
class HolaMundo(Resource):
    def get(self):
        """Devuelve un saludo al mundo"""
        return {'mensaje': 'Hola Mundo'}
