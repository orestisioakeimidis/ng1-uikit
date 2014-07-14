// Generated by CoffeeScript 1.7.1
(function() {
  'use strict';
  var angular_uikit, apply_modifiers, replace_transclude;

  apply_modifiers = function(element, modifiers, directive) {
    var modifier, _i, _len, _ref, _results;
    if (modifiers) {
      _ref = modifiers.split(",");
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        modifier = _ref[_i];
        _results.push(element.addClass('uk-' + directive + '-' + modifier));
      }
      return _results;
    }
  };

  replace_transclude = function(element, transclude) {
    return element.find('text-placeholder').replaceWith(transclude());
  };

  angular_uikit = angular.module('angular-uikit', ['ngSanitize']);

  angular_uikit.directive('ukPanel', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      scope: {
        title: '@',
        teaser: '@'
      },
      templateUrl: 'templates/ukpanel.html',
      link: function($scope, $element, $attributes, controller, transclude) {
        replace_transclude($element, transclude);
        $scope.badge = angular.fromJson($attributes.badge);
        $scope.icon = angular.fromJson($attributes.icon);
        return apply_modifiers($element, $attributes.modifiers, 'panel');
      }
    };
  });

  angular_uikit.directive('ukArticle', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      scope: {
        title: '@',
        meta: '@',
        lead: '@'
      },
      templateUrl: 'templates/ukarticle.html',
      link: function($scope, $element, $attributes, controller, transclude) {
        return replace_transclude($element, transclude);
      }
    };
  });

  angular_uikit.directive('ukDivider', function() {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'templates/ukdivider.html'
    };
  });

  angular_uikit.directive('ukIcon', function() {
    return {
      restrict: 'E',
      replace: true,
      scope: {},
      templateUrl: 'templates/ukicon.html',
      link: function($scope, $element, $attributes) {
        $element.addClass('uk-icon-' + $attributes.type);
        return apply_modifiers($element, $attributes.modifiers, 'icon');
      }
    };
  });

  angular_uikit.directive('ukClose', function() {
    return {
      restrict: 'E',
      replace: true,
      scope: {},
      templateUrl: 'templates/ukclose.html',
      link: function($scope, $element, $attributes) {
        if ('inalert' in $attributes) {
          $scope.inalert = true;
        }
        if ('inmodal' in $attributes) {
          $scope.inmodal = true;
        }
        return apply_modifiers($element, $attributes.modifiers, 'close');
      }
    };
  });

  angular_uikit.directive('ukBadge', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      scope: {},
      templateUrl: 'templates/ukbadge.html',
      link: function($scope, $element, $attributes, controller, transclude) {
        replace_transclude($element, transclude);
        if ('inpanel' in $attributes) {
          $scope.inpanel = true;
        }
        return apply_modifiers($element, $attributes.modifiers, 'badge');
      }
    };
  });

  angular_uikit.directive('ukAlert', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      scope: {},
      templateUrl: 'templates/ukalert.html',
      link: function($scope, $element, $attributes, controller, transclude) {
        replace_transclude($element, transclude);
        if ('close' in $attributes) {
          $scope.close = $attributes.close === '' ? true : $attributes.close;
          $element.attr('data-uk-alert', '');
        }
        return apply_modifiers($element, $attributes.modifiers, 'alert');
      }
    };
  });

}).call(this);
