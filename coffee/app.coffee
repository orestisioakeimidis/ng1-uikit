'use strict'

capitalize = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

angular_uikit = angular.module('angular-uikit', [])

angular_uikit.directive('ukAlert', ->
    {
        restrict: 'E',
        transclude: true,
        scope: {
            title: '@',
            message: '@',
            close: '@',
            color: '@',
            size: '@'
        },
        templateUrl: 'templates/ukalert.html',
        controller: ($scope, $parse) ->
            for variable in ['color', 'size']
                element_class = $parse('alert' + capitalize(variable))
                value = if $scope[variable] then ' uk-alert-' + $scope[variable] else ''
                element_class.assign($scope, value)
    }
)
