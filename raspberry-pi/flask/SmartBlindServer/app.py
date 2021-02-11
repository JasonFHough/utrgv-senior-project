from flask import Flask
from flask_restful import Api
from SmartBlindServer.Endpoints.Blind.status import BlindStatusResource
from SmartBlindServer.Endpoints.Blind.open import BlindOpenResource
from SmartBlindServer.Endpoints.Blind.close import BlindCloseResource

app = Flask(__name__)
api = Api(app, prefix="/api/v1")

api.add_resource(BlindStatusResource, "/blind/status")
api.add_resource(BlindOpenResource, "/blind/open")
api.add_resource(BlindCloseResource, "/blind/close")

if __name__ == "__main__":
    # app.run(debug=True)
    app.run()
