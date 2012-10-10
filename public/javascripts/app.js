// Generated by CoffeeScript 1.3.3
"use strict";

var Maps, maps;

angular.module('1ch', ['1chServices']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: 'partials/main.html', controller: MainCtrl}).
      otherwise({redirectTo: '/'});
}]);

Maps = (function() {

  function Maps(canvas) {
    this.canvas = canvas;
  }

  Maps.prototype.geolocation = function() {
    var _this = this;
    return navigator.geolocation.watchPosition(function(position) {
      _this.show(position);
    });
  };

  Maps.prototype.show = function(position) {
    var latitude, latlang, longitude, map, marker, options;
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    latlang = new google.maps.LatLng(latitude, longitude);
    options = {
      zoom: 18,
      disableDefaultUI: true,
      center: latlang,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(this.canvas, options);
    marker = new google.maps.Marker({
      position: latlang,
      icon: 'images/bluedot.png',
      map: map
    });
  };

  return Maps;

})();

if (!navigator.geolocation) {
  alert("位置情報サービスが使えないZ〜");
  return;
}

