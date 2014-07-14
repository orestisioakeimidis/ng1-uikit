'use strict'

# Helper function to apply modifier classes into elements
apply_modifiers = (element, modifiers, directive) ->
    if modifiers
        for modifier in modifiers.split ","
            element.addClass 'uk-' + directive + '-' + modifier

# Helper function to insert transcluded text into placeholder element
replace_transclude = (element, transclude) ->
    element.find('text-placeholder').replaceWith transclude()

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
    link: ($scope, $element, $attributes, controller, transclude) ->
        replace_transclude $element, transclude
        $scope.badge = angular.fromJson $attributes.badge
        $scope.icon = angular.fromJson $attributes.icon
        apply_modifiers $element, $attributes.modifiers, 'panel'

# uk-article directive
angular_uikit.directive 'ukArticle', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope:
        title: '@'
        meta: '@'
        lead: '@'
    templateUrl: 'templates/ukarticle.html'
    link: ($scope, $element, $attributes, controller, transclude) ->
        replace_transclude $element, transclude

# uk-divider directive
angular_uikit.directive 'ukDivider', ->
    restrict: 'E'
    replace: true
    templateUrl: 'templates/ukdivider.html'

# uk-icon directive
angular_uikit.directive 'ukIcon', ->
    restrict: 'E'
    replace: true
    scope: {}
    templateUrl: 'templates/ukicon.html'
    link: ($scope, $element, $attributes) ->
        # TODO
        # Change element tag from "<i/>" to "<a/>" when modifier button is present
        $element.addClass 'uk-icon-' + $attributes.type
        apply_modifiers $element, $attributes.modifiers, 'icon'

# uk-close directive
angular_uikit.directive 'ukClose', ->
    restrict: 'E'
    replace: true
    scope: {}
    templateUrl: 'templates/ukclose.html'
    link: ($scope, $element, $attributes) ->
        $scope.inalert = true if 'inalert' of $attributes
        $scope.inmodal = true if 'inmodal' of $attributes
        apply_modifiers $element, $attributes.modifiers, 'close'

# uk-badge directive
angular_uikit.directive 'ukBadge', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope: {}
    templateUrl: 'templates/ukbadge.html'
    link: ($scope, $element, $attributes, controller, transclude) ->
        replace_transclude $element, transclude
        $scope.inpanel = true if 'inpanel' of $attributes
        apply_modifiers $element, $attributes.modifiers, 'badge'

# uk-alert directive
angular_uikit.directive 'ukAlert', ->
    restrict: 'E'
    replace: true
    transclude: true
    scope: {}
    templateUrl: 'templates/ukalert.html'
    link: ($scope, $element, $attributes, controller, transclude) ->
        replace_transclude $element, transclude
        if 'close' of $attributes
            $scope.close = if $attributes.close == '' then true else $attributes.close
            $element.attr 'data-uk-alert', ''
        apply_modifiers $element, $attributes.modifiers, 'alert'
