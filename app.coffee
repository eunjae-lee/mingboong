express = require 'express'
routes = require './routes'
user = require './routes/user'
http = require 'http'
path = require 'path'

app = express()

app.set 'port', 3123
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static path.join __dirname, 'public'
app.use 'public/javascripts', express.static path.join __dirname, 'public/javascripts'
app.use 'public/stylesheets', express.static path.join __dirname, 'public/stylesheets'
app.use 'public/images', express.static path.join __dirname, 'public/images'

if app.get 'env' is 'development'
	app.use express.errorHandler()

app.get '/', routes.index
app.get '/users', user.list

http.createServer(app).listen app.get('port'), ->
	console.log "Express server listening on port #{app.get('port')}"