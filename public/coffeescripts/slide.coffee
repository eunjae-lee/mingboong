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
    else if @data[@currentIndex].fadeOutImage and $(".fade_out_image", @currentSlide).css("display") != "none"
      $(".fade_out_image", @currentSlide).fadeOut fadeInDuration
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
    data.fadeOutImageHTML = data.fadeOutImage = "" unless data.fadeOutImage
    if data.fadeInImage
      data.fadeInImageHTML = """<img class="fade_in_image" src="#{data.fadeInImage}" style="display: none" />"""
    if data.fadeOutImage
      data.fadeOutImageHTML = """<img class="fade_out_image" src="#{data.fadeOutImage}" />"""
    @currentSlide = $("""<div class="slide slide-#{index}">#{data.fadeInImageHTML}#{data.fadeOutImageHTML}#{data.innerHTML}</div>""")
    @currentSlide.css
      "background": "url(#{data.background}) no-repeat"
      "background-size": "100%"
      "display": "none"
    @containerElem.append @currentSlide
    @currentIndex = index
    this.showSlideTransitionAnimation prevSlide, @currentSlide
    @currentSlide.ready =>
      $(".preparation", @containerElem).remove()
      data.ready(@currentSlide) if data.ready and typeof data.ready is "function"
      cachedCurrentIndex = @currentIndex
      setTimeout =>
        return if cachedCurrentIndex != @currentIndex
        return unless @data[@currentIndex + 1]
        nextData = @data[@currentIndex + 1]
        preparationHTML = """
          <img class="preparation" style="display: none; " src="#{nextData.background}" />
          <img class="preparation" style="display: none; " src="#{nextData.fadeInImage}" />
          <img class="preparation" style="display: none; " src="#{nextData.fadeOutImage}" />
        """
        @containerElem.append $(preparationHTML)
      , 1000
  showSlideTransitionAnimation: (prev, current) ->
    if prev
      setTimeout ->
        prev.remove()
      , fadeInDuration
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
