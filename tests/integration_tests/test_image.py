import pytest
import requests

GRAPH_QL_ENPOINT = 'http://0.0.0.0/graphql/'


class TestImageAPI(object):
    def test_query_images(self):
        query = '{images(first: 10) { edges { node { id } } } }'
        r = requests.get(GRAPH_QL_ENPOINT, params={'query': query})

        assert r.status_code == 200

    def test_query_image(self):
        query = '{image(id: "SW1hZ2VOb2RlOjQw") { name } }'
        r = requests.get(GRAPH_QL_ENPOINT, params={'query': query})

        assert r.status_code == 200

    def test_query_categories(self):
        query = '{categories(first: 10) { edges { node { id } } } }'
        r = requests.get(GRAPH_QL_ENPOINT, params={'query': query})

        assert r.status_code == 200
