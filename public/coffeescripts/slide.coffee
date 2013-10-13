fadeInDuration = 300

class Slide
  constructor: (options) ->
    @currentSlide = null
    @containerElem = options.container
    @data = options.slides
    @slideWidth = options.slideWidth
    this.init()
  init: ->
    $(window).keyup (key) =>
      this.handleKeyUp(key)
      return false
    @containerElem.addClass "slide_size_#{@slideWidth}"
  doLeftAction: ->
    if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.left and @data[@currentIndex].keyUp.left(@currentSlide)
      return # because event is consumed
    else
      this.gotoPrevSlide()
  doRightAction: ->
    if @data[@currentIndex].fadeInImage and $(".fade_in_image", @currentSlide).css("display") is "none"
      $(".fade_in_image", @currentSlide).fadeIn fadeInDuration
    else if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.right and @data[@currentIndex].keyUp.right(@currentSlide)
      return # because event is consumed
    else
      this.gotoNextSlide()
  handleKeyUp: (key) ->
    if key.keyCode is 37 # left
      this.doLeftAction()
    else if key.keyCode is 39 or key.keyCode is 32 # right or space
      this.doRightAction()
  show: (index) ->
    prevSlide = @currentSlide
    data = @data[index]
    data.innerHTML = "" unless data.innerHTML
    data.fadeInImageHTML = data.fadeInImage = "" unless data.fadeInImage
    if data.fadeInImage
      data.fadeInImageHTML = """<img class="fade_in_image" src="#{data.fadeInImage}" style="display: none" />"""
    @currentSlide = $("""<div class="slide slide-#{index}">#{data.fadeInImageHTML}#{data.innerHTML}</div>""")
    @currentSlide.css
      "background": "url(#{data.background}) no-repeat"
      "background-size": "100%"
      "display": "none"
    @containerElem.append @currentSlide
    @currentIndex = index
    this.showSlideTransitionAnimation prevSlide, @currentSlide
    @currentSlide.ready => data.ready(@currentSlide) if data.ready and typeof data.ready is "function"
  showSlideTransitionAnimation: (prev, current) ->
    if prev
      prev.fadeOut fadeInDuration, ->
        prev.remove()
    current.fadeIn fadeInDuration
  gotoPrevSlide: ->
    if @currentIndex - 1 >= 0
      this.show @currentIndex - 1
      return true
    else
      return false
  gotoNextSlide: ->
    if @currentIndex + 1 < @data.length
      this.show @currentIndex + 1
      return true
    else
      return false
