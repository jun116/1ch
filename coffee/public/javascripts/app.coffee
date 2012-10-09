"use strict"

# App Module 
angular.module("1ch", []).config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "partials/main.html"
    controller: MainCtrl
  ).otherwise redirectTo: "/"
]
