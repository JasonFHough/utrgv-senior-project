import json
from flask_httpauth import HTTPTokenAuth


auth = HTTPTokenAuth(scheme="Bearer")

@auth.verify_token
def verify_token(token):
    with open("SmartBlindServer/Core/tokens.json") as file:
        tokens = json.load(file)
    
        if token in tokens:
            return tokens[token]
