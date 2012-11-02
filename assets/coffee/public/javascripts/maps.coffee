class Maps

  constructor: (@canvas) ->

  init: ->
    options =
      zoom: 16
      disableDefaultUI: true
      scrollwheel: false
      draggable: false
      disableDoubleClickZoom: true
      mapTypeId: google.maps.MapTypeId.SATELLITE　# SATELLITE #HYBRID #SATELLITE #TERRAIN #ROADMAP 

    @map = new google.maps.Map @canvas, options

    @marker = new google.maps.Marker
      icon: 'images/bluedot.png'
      map: @map

    @circle = new google.maps.Circle
      map: @map
      radius: 130
      fillColor: "#0055ff"
      strokeColor: "#0055ff"

    @geocoder = new google.maps.Geocoder()

  currentPosition: (callback) ->
    navigator.geolocation.getCurrentPosition (position) =>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      accuracy = position.coords.accuracy

      latlang = new google.maps.LatLng latitude, longitude

      @map.setCenter latlang
      @markerPositionChange latlang

      callback(latlang)

    , (err) ->
      console.log err
      alert "位置情報サービスが使えないZ〜"

    , ->
      timeout: 3000
      maximumAge: 0
      enableHighAccuracy: true

  getAddress: (latlang, address) =>
    @geocoder.geocode latLng: latlang
    , (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        # 住所がいっぱい返ってくるが、最適なものをチョイスしなくてはいけない感じ
        console.dir results
        address @createAddress results[3].address_components
      else
        console.log "住所取得できず"

  createAddress: (geocode) ->
    geocode[2].short_name + geocode[1].short_name    

  markerPositionChange: (latlang) ->
    @marker.setPosition latlang
    @circle.setCenter latlang
