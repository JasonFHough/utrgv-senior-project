from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth
from SmartBlindServer.Core.motor import Motor


class BlindStatusResource(Resource):
    @auth.login_required
    def get(self):
        motor = Motor()
        return {"status": "open" if motor.status() == 1 else "closed"}