class Maps

  constructor: (@canvas) ->

  getMap: ->
    options =
      credentials: "AqO6Yp2TKKTXRaVmveModdMqLPXMALcdYH_pYHhEomNkIlXgbrJJ2m2WqhDulqNt"
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

    @map2 = new Microsoft.Maps.Map $("#map_canvas2")[0], options
    center = @map2.getCenter()
    pin = new Microsoft.Maps.Pushpin center, text: 'あ'
    @map2.entities.push pin

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

    @geocoder = new google.maps.Geocoder()

  currentPosition: (callback) ->
    navigator.geolocation.getCurrentPosition (position) =>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      accuracy = position.coords.accuracy

      latlang = new google.maps.LatLng latitude, longitude

      @map.setCenter latlang
      @markerPositionChange latlang

      @map2.setView center: new Microsoft.Maps.Location latitude, longitude

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
