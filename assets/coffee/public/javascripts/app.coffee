"use strict"

# App Module 
angular.module("1ch", ["1chServices"]).config ["$routeProvider", ($routeProvider) ->
  $routeProvider.
  when("/",
    templateUrl: "partials/main.html"
    controller: MainCtrl
  ).
  when("/tweet",
    templateUrl: "partials/tweet.html"
    controller: TweetCtrl
  ).otherwise redirectTo: "/"
]

class Maps
  constructor: (@canvas)->
    #super @canvas

  geolocation: ->
    #@watchId = navigator.geolocation.watchPosition (position)=>
    navigator.geolocation.getCurrentPosition (position)=>
      @show position
      return
      
  show: (position) ->
    latitude = position.coords.latitude
    longitude = position.coords.longitude
    latlang = new google.maps.LatLng latitude, longitude
    options = 
      zoom: 18
      disableDefaultUI: true
      scrollwheel: false
      center: latlang
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map @canvas, options
    marker = new google.maps.Marker
      position: latlang
      icon:  'images/bluedot.png'
      map: map
    return

unless navigator.geolocation
  alert "位置情報サービスが使えないZ〜"
  return
