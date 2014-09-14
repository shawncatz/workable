workable.factory 'Workers', ['$resource', ($resource) ->
  $resource '/workers/:id', {id: '@id'}, {

  }
]
workable.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when '/workers/queue',
    templateUrl: "/assets/workable/angular/workers/queue.html"
]
