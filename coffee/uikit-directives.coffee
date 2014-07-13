'use strict'

apply_modifiers = (element, modifiers, directive) ->
    if modifiers
        for modifier in modifiers.split ","
            element.addClass 'uk-' + directive + '-' + modifier

angular_uikit = angular.module 'angular-uikit', ['ngSanitize']

# uk-panel directive
angular_uikit.directive 'ukPanel', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope:
        title: '@'
        teaser: '@'
    templateUrl: 'templates/ukpanel.html'
    link: (scope, element, attrs, ctrl, transclude) ->
        element.find('text-placeholder').replaceWith transclude()
        scope.badge = angular.fromJson attrs.badge
        scope.icon = angular.fromJson attrs.icon
        apply_modifiers element, attrs.modifiers, 'panel'

#  uk-icon directive
angular_uikit.directive 'ukIcon', ->
    restrict: 'E'
    replace: true
    scope: {}
    templateUrl: 'templates/ukicon.html'
    link: (scope, element, attrs) ->
        element.addClass 'uk-icon-' + attrs.type
        apply_modifiers element, attrs.modifiers, 'icon'

# uk-badge directive
angular_uikit.directive 'ukBadge', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope: {}
    templateUrl: 'templates/ukbadge.html'
    link: (scope, element, attrs, ctrl, transclude) ->
        element.find('text-placeholder').replaceWith transclude()
        scope.inpanel = true if 'inpanel' of attrs
        apply_modifiers element, attrs.modifiers, 'badge'

# uk-alert directive
angular_uikit.directive 'ukAlert', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope: {}
    templateUrl: 'templates/ukalert.html'
    link: (scope, element, attrs, ctrl, transclude) ->
        element.find('text-placeholder').replaceWith transclude()
        if 'closeable' of attrs
            scope.closeable = true
            element.attr 'data-uk-alert', ''
        apply_modifiers element, attrs.modifiers, 'alert'
