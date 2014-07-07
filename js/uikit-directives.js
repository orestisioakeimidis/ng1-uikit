// Generated by CoffeeScript 1.7.1
(function() {
  'use strict';
  var angular_uikit;

  angular_uikit = angular.module('angular-uikit', ['ngSanitize']);

  angular_uikit.directive('ukAlert', function() {
    return {
      restrict: 'E',
      replace: true,
      templateUrl: 'templates/ukalert.html',
      link: function(scope, element, attrs) {
        if (attrs.title) {
          element.append(attrs.title);
        }
        if (attrs.message) {
          element.append(attrs.message);
        }
        if ('closeable' in attrs) {
          scope.closeable = true;
          element.attr('data-uk-alert', '');
        }
        if (attrs.color) {
          element.addClass('uk-alert-' + attrs.color);
        }
        if ('large' in attrs) {
          return element.addClass('uk-alert-large');
        }
      }
    };
  });

  angular_uikit.directive('ukPanel', function() {
    return {
      restrict: 'E',
      replace: true,
      scope: {
        title: '@',
        badge: '@',
        box: '@',
        teaser: '@',
        icon: '@'
      },
      templateUrl: 'templates/ukpanel.html',
      link: function(scope, element, attrs) {
        var attribute, object;
        scope.badge_object = angular.fromJson(attrs.badge);
        object = {
          'header': 'uk-panel-header',
          'box': 'uk-panel-box',
          'space': 'uk-panel-space',
          'divider': 'uk-panel-divider'
        };
        for (attribute in object) {
          if (attribute in attrs) {
            element.addClass(object[attribute]);
          }
        }
        if ('text' in attrs) {
          return element.append(attrs.text);
        }
      }
    };
  });

}).call(this);
