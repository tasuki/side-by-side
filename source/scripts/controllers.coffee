angular.module("sideBySide.controllers", [])
.controller "comparisonController", ($scope) ->
    $scope.verses = [
        { section: 'first',  versions: [ 'a', '1' ] }
        { section: 'second', versions: [ 'b', '2' ] }
    ]
