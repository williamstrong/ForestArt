import pytest
import requests

COMMUNICATION_REST_ENDPOINT = 'http://0.0.0.0/communications'

class TestCommunicationAPI(object):
    @pytest.mark.skip(reason="test is failing on Travi exclusively")
    def test_create_communication(self):
        post_data = {
                "first_name": "will",
	        "last_name": "strong",
	        "email": "test2@email.com",
                "message_body": "A body",
                "subject": "A good one"
                }
        r = requests.post(COMMUNICATION_REST_ENDPOINT, data=post_data)
        assert r.status_code == 201

    def test_query_person(self):
        # TODO Add to NGINX config
        pass

    def test_query_message(self):
        # TODO Add to NGINX config
        pass

