from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth


class BlindStatusResource(Resource):
    @auth.login_required
    def get(self):
        return {"status": "open"}