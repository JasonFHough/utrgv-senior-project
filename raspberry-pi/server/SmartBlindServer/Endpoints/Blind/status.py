from flask_restful import Resource

class BlindStatusResource(Resource):
    def get(self):
        return {"status": "open"}