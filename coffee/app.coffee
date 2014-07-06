'use strict'

capitalize = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

angular_uikit = angular.module('angular-uikit', [])

angular_uikit.directive('ukAlert', ->
    restrict: 'E',
    replace: true,
    scope:
        title: '@',
        message: '@',
        color: '@'
    ,
    templateUrl: 'templates/ukalert.html',
    link: (scope, element, attrs) ->
        scope.closeable = 'close' of attrs
        element.attr('data-uk-alert', '') if scope.closeable
        element.addClass('uk-alert-' + attrs.color) if 'color' of attrs and attrs.color != ''
        element.addClass('uk-alert-large') if 'large' of attrs
)
