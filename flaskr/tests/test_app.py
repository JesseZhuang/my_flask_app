# Import sys module for modifying Python's runtime environment
import sys
# Import os module for interacting with the operating system
import os

# Add the parent directory to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Import the Flask app instance from the main app file
from flaskr import create_app
# Import pytest for writing and running tests
import pytest

@pytest.fixture()
def app():
    app = create_app()
    app.config.update({
        "TESTING": True,
    })
    # other setup can go here
    yield app
    # clean up / reset resources here

@pytest.fixture
def client():
    # app.config.update({
    #     "TESTING": True,
    # })
    """A test client for the app."""
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test the home route."""
    response = client.get('/hello')
    assert response.status_code == 200
    assert response.json == {"message": "Hello, Flask!"}

def test_about(client):
    """Test the about route."""
    response = client.get('/about')
    assert response.status_code == 200
    assert response.json == {"message": "This is the About page"}

def test_multiply(client):
    """Test the multiply route with valid input."""
    response = client.get('/multiply/3/4')
    assert response.status_code == 200
    assert response.json == {"result": 12}

def test_multiply_invalid_input(client):
    """Test the multiply route with invalid input."""
    response = client.get('/multiply/three/four')
    assert response.status_code == 404

def test_non_existent_route(client):
    """Test for a non-existent route."""
    response = client.get('/non-existent')
    assert response.status_code == 404

