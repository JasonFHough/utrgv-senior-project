from flask_restful import Resource
#from SmartBlindServer.Core.authentication import auth


class BlindStatusPercentResource(Resource):
    def __init__(self, **kwargs):
        self.motor = kwargs["motor"]

#    @auth.login_required
    def get(self):
        return {"percentage": str(self.motor.statusPercent())}



