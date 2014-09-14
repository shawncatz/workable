workable.factory 'Workers', ['$resource', ($resource) ->
  $resource '/workers/:id', {id: '@id'}, {

  }
]
