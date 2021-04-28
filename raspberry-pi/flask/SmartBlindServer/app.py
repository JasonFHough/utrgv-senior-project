from flask import Flask
from flask_restful import Api
from SmartBlindServer.Endpoints.Blind.status import BlindStatusResource
from SmartBlindServer.Endpoints.Blind.open import BlindOpenResource
from SmartBlindServer.Endpoints.Blind.close import BlindCloseResource
from SmartBlindServer.Endpoints.Blind.percent import BlindPercentResource
from SmartBlindServer.Core.motor import Motor


app = Flask(__name__)
api = Api(app, prefix="/api/v1")

motor = Motor()

api.add_resource(BlindStatusResource, "/blind/status", resource_class_kwargs={"motor": motor})
api.add_resource(BlindOpenResource, "/blind/open", resource_class_kwargs={"motor": motor})
api.add_resource(BlindCloseResource, "/blind/close", resource_class_kwargs={"motor": motor})
api.add_resource(BlindPercentResource, "/blind/percent", resource_class_kwargs={"motor": motor})

if __name__ == "__main__":
    # app.run(debug=True)
    app.run()
