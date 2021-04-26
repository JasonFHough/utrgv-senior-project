from SmartBlindServer.Core.motor import Motor
from fake_clib import FakeCLib
from unittest import TestCase, mock
from unittest.mock import Mock, patch


class TestGetPercentEndpoint(TestCase):
    def setUp(self):
        with patch("SmartBlindServer.Core.motor.lib", return_value=FakeCLib):
            from SmartBlindServer.app import app
            self.app = app.test_client()
    
    def test_success(self):
        with mock.patch.multiple(Motor, get_current_percent=Mock(return_value=50)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.get("/api/v1/blind/percent", headers=request_headers)
            
            self.assertEqual(response.status_code, 200)

    def test_unauthorized(self):
        with mock.patch.multiple(Motor, get_current_percent=Mock(return_value=50)):
            request_headers = {}
            response = self.app.get("/api/v1/blind/percent", headers=request_headers)
            
            self.assertEqual(response.status_code, 401)
    
    def test_correct_json_format(self):
        with mock.patch.multiple(Motor, get_current_percent=Mock(return_value=50)):
            request_headers = {"Authorization": "Bearer testing-token"}
            response = self.app.get("/api/v1/blind/percent", headers=request_headers)
            response_json = response.json

            expected_json = {"percentage": 50}
            self.assertEqual(response_json, expected_json)

class TestPutPercentEndpoint(TestCase):
    def setUp(self):
        with patch("SmartBlindServer.Core.motor.lib", return_value=FakeCLib):
            from SmartBlindServer.app import app
            self.app = app.test_client()
    
    def test_success(self):
        new_percent = 35
        with mock.patch.multiple(Motor, move_to_percent=Mock(return_value=None), get_current_percent=Mock(return_value=new_percent), status=Mock(return_value=True)):
            request_headers = {"Authorization": "Bearer testing-token"}
            query_params = {
                "percentage": new_percent
            }
            response = self.app.put("/api/v1/blind/percent", headers=request_headers, query_string=query_params)
            
            self.assertEqual(response.status_code, 200)

    def test_unauthorized(self):
        new_percent = 35
        with mock.patch.multiple(Motor, move_to_percent=Mock(return_value=None), get_current_percent=Mock(return_value=new_percent), status=Mock(return_value=True)):
            request_headers = {}
            query_params = {
                "percentage": new_percent
            }
            response = self.app.put("/api/v1/blind/percent", headers=request_headers, query_string=query_params)
            
            self.assertEqual(response.status_code, 401)
    
    def test_correct_json_format_open(self):
        new_percent = 35
        with mock.patch.multiple(Motor, move_to_percent=Mock(return_value=None), get_current_percent=Mock(return_value=new_percent), status=Mock(return_value=True)):
            request_headers = {"Authorization": "Bearer testing-token"}
            query_params = {
                "percentage": new_percent
            }
            response = self.app.put("/api/v1/blind/percent", headers=request_headers, query_string=query_params)
            response_json = response.json

            expected_json = {
                "new_percent": new_percent,
                "result": "opened"
            }
            self.assertEqual(response_json, expected_json)

    def test_correct_json_format_close_0(self):
        new_percent = 0
        with mock.patch.multiple(Motor, move_to_percent=Mock(return_value=None), get_current_percent=Mock(return_value=new_percent), status=Mock(return_value=False)):
            request_headers = {"Authorization": "Bearer testing-token"}
            query_params = {
                "percentage": new_percent
            }
            response = self.app.put("/api/v1/blind/percent", headers=request_headers, query_string=query_params)
            response_json = response.json

            expected_json = {
                "new_percent": new_percent,
                "result": "closed"
            }
            self.assertEqual(response_json, expected_json)

    def test_correct_json_format_close_100(self):
        new_percent = 100
        with mock.patch.multiple(Motor, move_to_percent=Mock(return_value=None), get_current_percent=Mock(return_value=new_percent), status=Mock(return_value=False)):
            request_headers = {"Authorization": "Bearer testing-token"}
            query_params = {
                "percentage": new_percent
            }
            response = self.app.put("/api/v1/blind/percent", headers=request_headers, query_string=query_params)
            response_json = response.json

            expected_json = {
                "new_percent": new_percent,
                "result": "closed"
            }
            self.assertEqual(response_json, expected_json)
