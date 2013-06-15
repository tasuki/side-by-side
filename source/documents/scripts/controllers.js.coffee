angular.module("sideBySide.controllers", [])
.controller "comparisonController", ['$scope', ($scope) ->
	$scope.columns = 2
	$scope.verses = [
		[
			{
				section: 'first'
				text: 'a'
			}, {
				section: 'I'
				text: '1'
			}
		], [
			{
				section: 'second'
				text: 'b'
			}, {
				section: 'II'
				text: '2'
			}
		], [
			{
				section: 'third'
				text: 'c'
			}, {
				section: 'III'
				text: '3'
			}
		], [
			{
				section: 'fourth'
				text: 'd'
			}, {
				section: 'IV'
				text: '4'
			}
		]
	]
]

#.controller "notificationController", ['$scope', '$timeout', ($scope, $timeout) ->
#	$scope.id = 0
#	$scope.notifications = []
#
#	$scope.notify = (text, type = "info") ->
#		$scope.notifications[$scope.id] = {
#			text: text
#			type: type
#		}
#		$timeout(() ->
#			$scope.remove($scope.id)
#		, 1000)
#		$scope.id++
#
#	$scope.remove = (id) ->
#		delete $scope.notifications[id]
#]
