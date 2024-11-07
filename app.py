from flask import Flask, render_template
import flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template("index.html", title="Hello")


# users = dict()

@app.route('/register', methods=['GET', 'POST'])
def register():
    if flask.request.method == 'POST':
        username = flask.request.values.get('user') # Your form's
        password = flask.request.values.get('pass') # input names
        users[username] = password
    else:
        # You probably don't have args at this route with GET
        # method, but if you do, you can access them like so:
        yourarg = flask.request.args.get('argname')
        return "register/get"
    

from flask import Flask, render_template, request, redirect, session

# Set a secret key for encrypting session data
app.secret_key = 'my_secret_key'

# dictionary to store user and password
users = {
	'kunal': '1234',
	'user2': 'password2'
}

# To render a login form 
@app.route('/gfg')
def view_form():
	return render_template('gfg.html')

# For handling get request form we can get
# the form inputs value by using args attribute.
# this values after submitting you will see in the urls.
# e.g http://127.0.0.1:5000/handle_get?username=kunal&password=1234
# this exploits our credentials so that's 
# why developers prefer POST request.
@app.route('/handle_get', methods=['GET'])
def handle_get():
	if request.method == 'GET':
		username = request.args['username']
		password = request.args['password']
		print(username, password)
		if username in users and users[username] == password:
			return '<h1>Welcome!!!</h1>'
		else:
			return '<h1>invalid credentials!</h1>'
	else:
		return render_template('gfg.html')

# For handling post request form we can get the form
# inputs value by using POST attribute.
# this values after submitting you will never see in the urls.
@app.route('/handle_post', methods=['POST'])
def handle_post():
	if request.method == 'POST':
		username = request.form['username']
		password = request.form['password']
		print(username, password)
		if username in users and users[username] == password:
			return '<h1>Welcome!!!</h1>'
		else:
			return '<h1>invalid credentials!</h1>'
	else:
		return render_template('gfg.html')

# if __name__ == '__main__':
# 	app.run()
