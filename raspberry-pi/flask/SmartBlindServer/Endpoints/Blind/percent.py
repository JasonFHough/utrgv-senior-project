from flask_restful import Resource
from flask_restful import request
#from SmartBlindServer.Core.authentication import auth


class BlindPercentResource(Resource):
    def __init__(self, **kwargs):
        self.motor = kwargs["motor"]

#    @auth.login_required
    def put(self):
        args = request.args
        percent = args['percentage']
        self.motor.percent(int(percent))
        return {"result": "opened" if self.motor.status() else "closed"}

