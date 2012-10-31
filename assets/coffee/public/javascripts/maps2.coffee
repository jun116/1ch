class Maps2

  constructor: (@canvas) ->

  currentPosition: (callback)->
    navigator.geolocation.getCurrentPosition (position) =>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      accuracy = position.coords.accuracy
      latlang = new google.maps.LatLng latitude, longitude
      console.log latlang
      callback(latlang)
    , (err) ->
      console.log err
      alert "位置情報サービスが使えないZ〜"


  show: ->
    console.log "show"
    @currentPosition (latlang) =>
      console.log "callback"
      options =
        zoom: 18
        disableDefaultUI: true
        scrollwheel: false
        center: latlang
        mapTypeId: google.maps.MapTypeId.ROADMAP

      @map = new google.maps.Map @canvas, options
      console.log @map
      marker = new google.maps.Marker
        position: latlang
        icon: 'images/bluedot.png'
        map: @map

      @out @aaa

  aaa: (latlang) =>
    @out @aaa
    @map.setCenter new google.maps.LatLng 35.7971876, 139.77502800000002
    marker = new google.maps.Marker
        position: new google.maps.LatLng 35.7971876, 139.77502800000002
        icon: 'images/bluedot.png'
        map: @map

  out: (callback)->
    setTimeout @currentPosition , 5000, callback