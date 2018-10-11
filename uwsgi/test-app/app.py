from flask import Flask
application = Flask(__name__)

@application.route("/")
def hello():
    return "Congratulations!<br>Your new uWSGI server works!"
