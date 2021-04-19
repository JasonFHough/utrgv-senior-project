from flask_restful import Resource
#from SmartBlindServer.Core.authentication import auth


class BlindPercentResource(Resource):
    def __init__(self, **kwargs):
        self.motor = kwargs["motor"]

#    @auth.login_required
    def put(self, percentage):
        self.motor.percent(percentage)
        return {"result": "opened" if self.motor.status() else "closed"}

