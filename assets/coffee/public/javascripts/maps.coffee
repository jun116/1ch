class Maps
  constructor: ->
    #super @canvas

  latlang: (callback) ->
    navigator.geolocation.getCurrentPosition (position) =>
      latitude = position.coords.latitude
      longitude = position.coords.longitude
      @latlang = new google.maps.LatLng latitude, longitude

      callback()
      return
    , (err) ->
      console.log err
      alert "位置情報サービスが使えないZ〜"
    , ->
      maximumAge: Infinity,
      $timeout: 5000

  show: (@canvas) ->

    @latlang =>
      options = 
        zoom: 9
        disableDefaultUI: true
        scrollwheel: false
        center: @latlang
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map @canvas, options
      # 衛生写真の場合は以下のコメントアウトを解除  
      # map.setMapTypeId google.maps.MapTypeId.SATELLITE
      marker = new google.maps.Marker
        position: @latlang
        icon: 'images/bluedot.png'
        map: map

  address: (@callback) ->

    @latlang =>
      geocoder = new google.maps.Geocoder()
      geocoder.geocode
        latLng: @latlang
      , (results, status)=>
        if status  == google.maps.GeocoderStatus.OK
          if results[0].geometry
            address = @makeAddress results[3].address_components
            console.log address
            @callback address
        else
          console.log "住所取得できず"

  makeAddress: (geocode)->
    geocode[3].short_name + geocode[2].short_name + geocode[1].short_name

  position: (callback) ->
    navigator.geolocation.getCurrentPosition (position) =>
      pos = {}
      pos.latitude = position.coords.latitude
      pos.longitude = position.coords.longitude
      pos.accuracy = position.coords.accuracy

      callback pos

  watchPosition: (callback) ->
    options = {frequency : 3000};
    navigator.geolocation.watchPosition (position) =>
      pos = {}
      pos.latitude = position.coords.latitude
      pos.longitude = position.coords.longitude
      pos.accuracy = position.coords.accuracy
      @latlang = new google.maps.LatLng position.coords.latitude, position.coords.longitude

      callback pos
    , (err) ->
      console.log 'error'
    , options


unless navigator.geolocation
  alert "位置情報サービスが使えないZ〜"
