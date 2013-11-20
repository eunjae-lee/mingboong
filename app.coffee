express = require 'express'
routes = require './routes/index'
http = require 'http'
path = require 'path'

isBeforeExhibition = ->
  cur = new Date()
  year = 2013
  month = 11
  date = 13
  return false if cur.getFullYear() > year
  return false if cur.getMonth() + 1 > month
  return false if cur.getDate() >= date
  return true

app = express()

app.set 'port', 3001
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

#if isBeforeExhibition()
#app.get '/', (req, res) -> res.redirect '/invitation'
#else
#  app.get '/', routes.book

app.get '/', routes.index
app.get '/invitation', routes.invitation
app.get '/book', routes.book
app.get '/money', routes.money
app.get '/login', routes.login

http.createServer(app).listen app.get('port'), ->
	console.log "Express server listening on port #{app.get('port')}"
