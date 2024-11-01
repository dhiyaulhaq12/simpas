from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template("landing.html")

@app.route("/chatbot")
def chatbot():
    return render_template("chatbot.html")

app.run(debug=True)
