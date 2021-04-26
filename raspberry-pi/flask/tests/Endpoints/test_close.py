from SmartBlindServer.Core.motor import Motor
from fake_clib import FakeCLib
from unittest import TestCase, mock
from unittest.mock import Mock, patch


class TestCloseEndpoint(TestCase):
    def setUp(self):
        with patch("SmartBlindServer.Core.motor.lib", return_value=FakeCLib):
            from SmartBlindServer.app import app
            self.app = app.test_client()
    
    def test_success(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True), close=Mock(return_value=None)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.put("/api/v1/blind/close", headers=request_headers)
            
            self.assertEqual(response.status_code, 200)

    def test_unauthorized(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True), close=Mock(return_value=None)):
            request_headers = {}
            response = self.app.put("/api/v1/blind/close", headers=request_headers)
            
            self.assertEqual(response.status_code, 401)
    
    def test_correct_json_format_open(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True), close=Mock(return_value=None)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.put("/api/v1/blind/close", headers=request_headers)
            response_json = response.json

            expected_json = {"result": "opened"}
            self.assertEqual(response_json, expected_json)

    def test_correct_json_format_close(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=False), close=Mock(return_value=None)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.put("/api/v1/blind/close", headers=request_headers)
            response_json = response.json

            expected_json = {"result": "closed"}
            self.assertEqual(response_json, expected_json)
