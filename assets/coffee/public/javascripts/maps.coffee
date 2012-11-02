class Maps

  constructor: (@canvas) ->

  init: ->
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
