from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth


class BlindCloseResource(Resource):
    @auth.login_required
    def put(self):
        return {"result": "closed"}