"use strict";

var MainCtrl;
MainCtrl = function($scope, socket) {

  var maps = new Maps($("#map_canvas")[0]);
  maps.geolocation();

  socket.on('send:name', function (data) {
    $scope.tweets = data.tweets;
  });

}

MainCtrl.$inject =  ['$scope', 'socket'];

