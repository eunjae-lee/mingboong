ratio = 6722 / 1300

heights = [1300, 950, 640, 400]
lastShowingHeight = null
contentImgTop = 0

getImageHeight = ->
  currentHeight = $(window).height()
  imgHeight = heights[heights.length - 1]
  for h in heights
    if currentHeight >= h
      imgHeight = h
      break
  return imgHeight

getImageRealHeight = ->
  return getImageHeight() * (window.devicePixelRatio or 1)

getImageRect = ->
  currentHeight = $(window).height()
  imgHeight = getImageHeight()
  imgWidth = ratio * imgHeight
  rect =
    top: (currentHeight - imgHeight) / 2
    width: imgWidth
    height: imgHeight
  return rect

getImageUrl = (height) ->
  postfix = ""
  if window.devicePixelRatio in [1.5, 2, 3]
    postfix = "x#{window.devicePixelRatio}"
  url = "/images/invitation/invitation-h#{height}#{postfix}.png"

showImage = ->
  rect = getImageRect()
  return if lastShowingHeight == rect.height
  url = getImageUrl rect.height
  arrangeImageRect()
  contentImgTop = rect.top
  $("#content").attr "src", url

arrangeImageRect = ->
  rect = getImageRect()
  $("#content").css
    top: rect.top
    width: rect.width
    height: rect.height

$(window).resize ->
  #arrangeImageRect()

log = (msg) ->
  if $("#log").length == 0
    $(document.body).append $("<div id='log' style='position:absolute;top:0;left:0;'></div>")
  $("#log").html msg

addLinks = ->
  imgHeight = getImageHeight()
  ratio = imgHeight / 400
  mapLink = $("""<a class="map_link" href="#" target="_blank" style="position:absolute;"></a>""")
  mapLink.css
    width: 131*ratio
    height: 14*ratio
    left: 1172*ratio
    top: 354*ratio + contentImgTop
    cursor: "pointer"
  $(document.body).append mapLink

  siteLink = $("""<a class="site_link" href="#" target="_blank" style="position:absolute;"></a>""")
  siteLink.css
    width: 131*ratio
    height: 14*ratio
    left: 1172*ratio
    top: 369*ratio + contentImgTop
    cursor: "pointer"
  $(document.body).append siteLink

  mapLink.click ->
    window.open "http://dmaps.kr/gq4p", "_blank"
    return false
  siteLink.click ->
    window.open "http://www.usw2013play.com", "_blank"
    return false

$(document).ready ->
  showImage()
  addLinks()
