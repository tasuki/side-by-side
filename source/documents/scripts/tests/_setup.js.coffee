this.injector = angular.injector(['ng', 'sideBySide'])

init = {
	setup: () ->
		this.$scope = injector.get('$rootScope').$new();
}

this.module('tests', init);
