from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth
from SmartBlindServer.Core.motor import Motor


class BlindOpenResource(Resource):
    @auth.login_required
    def put(self):
        motor = Motor()
        motor.open()
        return {"result": "opened"}