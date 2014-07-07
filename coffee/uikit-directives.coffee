'use strict'

angular_uikit = angular.module 'angular-uikit', ['ngSanitize']

# uk-alert directive
angular_uikit.directive 'ukAlert', ->
    restrict: 'E'
    replace: true
    templateUrl: 'templates/ukalert.html'
    link: (scope, element, attrs) ->
        element.append attrs.title if attrs.title
        element.append attrs.message if attrs.message
        if 'closeable' of attrs
            scope.closeable = true
            element.attr 'data-uk-alert', ''
        element.addClass 'uk-alert-' + attrs.color if attrs.color
        element.addClass 'uk-alert-large' if 'large' of attrs

# uk-panel directive
angular_uikit.directive 'ukPanel', ->
    restrict: 'E'
    replace: true
    scope:
        title: '@'
        badge: '@'
        box: '@'
        teaser: '@'
        icon: '@'
    templateUrl: 'templates/ukpanel.html'
    link: (scope, element, attrs) ->
        scope.badge_object = angular.fromJson attrs.badge
        object =
            'header': 'uk-panel-header'
            'box': 'uk-panel-box'
            'space': 'uk-panel-space'
            'divider': 'uk-panel-divider'
        for attribute of object
            element.addClass object[attribute] if attribute of attrs
        element.append attrs.text if 'text' of attrs
