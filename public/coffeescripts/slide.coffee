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
    if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.left
      @data[@currentIndex].keyUp.left(@currentSlide)
    else
      this.gotoPrevSlide()
  doRightAction: ->
    if @data[@currentIndex].fadeInImage and $(".fade_in_image", @currentSlide).css("display") is "none"
      $(".fade_in_image", @currentSlide).show()
    else if @data[@currentIndex].keyUp and @data[@currentIndex].keyUp.right
      @data[@currentIndex].keyUp.right(@currentSlide)
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
    @containerElem.append @currentSlide
    @currentIndex = index
    this.showSlideTransitionAnimation prevSlide, @currentSlide
    @currentSlide.ready => data.ready(@currentSlide) if data.ready and typeof data.ready is "function"
  showSlideTransitionAnimation: (prev, current) ->
    if prev
      prev.fadeOut 100, ->
        prev.remove()
    current.fadeIn 100
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
