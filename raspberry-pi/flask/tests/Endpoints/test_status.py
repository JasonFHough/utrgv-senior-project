from SmartBlindServer.Core.motor import Motor
from unittest import TestCase, mock
from unittest.mock import Mock, patch

# A class to mimic the structure of what cdll.LoadLibrary(libmotor.so) would contain
class FakeCLib():
    def Motor_new(self):
        pass

    def Motor_status(self, obj):
        pass
    
    def Motor_open(self, obj):
        pass

    def Motor_close(self, obj):
        pass

class TestStatusEndpoint(TestCase):
    def setUp(self):
        with patch("SmartBlindServer.Core.motor.lib", return_value=FakeCLib):
            from SmartBlindServer.app import app
            self.app = app.test_client()
    
    def test_success(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.get("/api/v1/blind/status", headers=request_headers)
            
            self.assertEqual(response.status_code, 200)

    def test_unauthorized(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True)):
            request_headers = {}
            response = self.app.get("/api/v1/blind/status", headers=request_headers)
            
            self.assertEqual(response.status_code, 401)
    
    def test_correct_json_format_open(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=True)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.get("/api/v1/blind/status", headers=request_headers)
            response_json = response.json

            expected_json = {"status": "open"}
            self.assertEqual(response_json, expected_json)

    def test_correct_json_format_close(self):
        with mock.patch.multiple(Motor, status=Mock(return_value=False)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.get("/api/v1/blind/status", headers=request_headers)
            response_json = response.json

            expected_json = {"status": "closed"}
            self.assertEqual(response_json, expected_json)
