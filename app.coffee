express = require 'express'
routes = require './routes/index'
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
app.use express.static path.join __dirname, 'public_built'

if app.get 'env' is 'development'
	app.use express.errorHandler()

app.get '/', routes.invitation
app.get '/invitation', routes.invitation
app.get '/book', routes.book

http.createServer(app).listen app.get('port'), ->
	console.log "Express server listening on port #{app.get('port')}"
