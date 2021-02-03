from flask_restful import Resource

class BlindOpenResource(Resource):
    def put(self):
        return {"result": "opened"}