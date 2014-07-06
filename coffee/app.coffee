'use strict'

angular_uikit = angular.module 'angular-uikit', []

# uk-alert directive
angular_uikit.directive 'ukAlert', ->
    restrict: 'E'
    replace: true
    templateUrl: 'templates/ukalert.html'
    link: (scope, element, attrs) ->
        element.append(attrs.title) if attrs.title
        element.append(attrs.message) if attrs.message
        if 'closeable' of attrs
            scope.closeable = true
            element.attr('data-uk-alert', '')
        element.addClass('uk-alert-' + attrs.color) if attrs.color
        element.addClass('uk-alert-large') if 'large' of attrs
