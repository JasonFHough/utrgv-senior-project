import os
import json
from flask_httpauth import HTTPTokenAuth


auth = HTTPTokenAuth(scheme="Bearer")

@auth.verify_token
def verify_token(token):
    token_json_path = "SmartBlindServer/Core/tokens.json"                           # Path appropriate for running Flask in production
    if not os.path.exists(token_json_path):
        token_json_path = "raspberry-pi/flask/SmartBlindServer/Core/tokens.json"    # Path appropriate for GitHub Actions
    
    with open(token_json_path) as file:
        tokens = json.load(file)
    
        if token in tokens:
            return tokens[token]
