exports.index = (req, res) ->
  res.redirect '/book'

exports.invitation = (req, res) ->
  res.render 'invitation'

exports.book = (req, res) ->
	res.render 'book'

exports.money = (req, res) ->
  res.send 404

exports.login = (req, res) ->
  res.render 'login'