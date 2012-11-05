class Maps

  key = "AqO6Yp2TKKTXRaVmveModdMqLPXMALcdYH_pYHhEomNkIlXgbrJJ2m2WqhDulqNt"

  constructor: (@canvas) ->

  init: ->
    options =
      credentials: key
      mapTypeId: Microsoft.Maps.MapTypeId.birdseye
      zoom: 18
      animate: false
      disableKeyboardInput: true
      disableMouseInput: true
      disableTouchInput: true
      showDashboard: false
      showScalebar: false
      showCopyright: false
      enableSearchLogo: false
      enableClickableLogo: false
      labelOverlay: Microsoft.Maps.LabelOverlay.hidden

    @map = new Microsoft.Maps.Map @canvas, options

  currentPosition: (callback) ->
    navigator.geolocation.getCurrentPosition (position) =>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      accuracy = position.coords.accuracy

      location = new Microsoft.Maps.Location latitude, longitude

      @map.setView center: location

      callback(location)

    , (err) ->
      console.log err
      alert "位置情報サービスが使えないZ〜"

    , ->
      timeout: 3000
      maximumAge: 0
      enableHighAccuracy: true

  getAddress: (position, callback) =>


    $.ajax 
      url : "http://dev.virtualearth.net/REST/v1/Locations/#{position.latitude},#{position.longitude}"
      type: "GET"
      data: 
        o  : "json"
        key: key
        c  : "ja-JP"
      dataType: "jsonp"
      jsonp: "jsonp"
    .done (json) ->
      console.log json
      address = json.resourceSets[0].resources[0].address
      callback address.locality + address.addressLine
      
  createAddress: (geocode) ->
    geocode[2].short_name + geocode[1].short_name    

  markerPositionChange: (latlang) ->
    @marker.setPosition latlang
    # @circle.setCenter latlang
