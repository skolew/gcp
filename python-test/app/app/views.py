#we're creating a new view using the @app.route decorator and passing it a URL.
#We're actually importing the app variable we created in the __init__.py. Meaning we can access it anywhere in our package!
from app import app

# Render template for html files
from flask import render_template


@app.route("/")
def index():
    return "Sample python app"
