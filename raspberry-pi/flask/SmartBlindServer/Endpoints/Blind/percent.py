from flask_restful import Resource
from flask_restful import request
from SmartBlindServer.Core.authentication import auth


class BlindPercentResource(Resource):
    def __init__(self, **kwargs):
        self.motor = kwargs["motor"]

    @auth.login_required
    def get(self):
        return {"percentage": self.motor.get_current_percent()}

    @auth.login_required
    def put(self):
        # Parse query param "percentage" from HTTP request
        args = request.args
        percent = int(args['percentage'])

        self.motor.move_to_percent(percent)
        return {
            "new_percent": self.motor.get_current_percent(),
            "result": "opened" if self.motor.status() else "closed"
        }
