import pytest
import requests

IP = 'http://0.0.0.0'

class TestWebUI(object):
    def test_home(self):
        r = requests.get(IP)
        assert r.status_code == 200

    def test_about_me(self):
        about_me_url = ''.join((IP, '/about_me'))

        r = requests.get(about_me_url)
        assert r.status_code == 200

    def test_contact(self):
        contact_url = ''.join((IP, '/contact'))

        r = requests.get(contact_url)
        assert r.status_code == 200

    def test_art_categories(self):
        art_category_url = ''.join((IP, '/art'))

        r = requests.get(art_category_url)
        assert r.status_code == 200

    def test_art_category(self):
        art_category_url = ''.join((IP, '/art/abstract'))

        r = requests.get(art_category_url)
        assert r.status_code == 200

    def test_art_piece(self):
        art_piece_url = ''.join((IP, '/art/abstract/abstract_one'))

        r = requests.get(art_piece_url)
        assert r.status_code == 200
