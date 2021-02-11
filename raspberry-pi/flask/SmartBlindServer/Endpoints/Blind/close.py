from flask_restful import Resource

class BlindCloseResource(Resource):
    def put(self):
        return {"result": "closed"}