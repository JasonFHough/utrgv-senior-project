from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth
from SmartBlindServer.Core.motor import Motor


class BlindCloseResource(Resource):
    @auth.login_required
    def put(self):
        motor = Motor()
        motor.close()
        return {"result": "closed"}