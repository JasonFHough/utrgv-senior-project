from flask_restful import Resource
from SmartBlindServer.Core.authentication import auth


class BlindOpenResource(Resource):
    def __init__(self, **kwargs):
        self.motor = kwargs["motor"]

    @auth.login_required
    def put(self):
        motor.open()
        return {"result": "opened" if motor.status() else "closed"}