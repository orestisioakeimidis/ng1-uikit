"use strict"

partials = "partials"

# Helper function to apply modifier classes to elements
_applyModifiers = (element, modifiers, directive) ->
  if modifiers
    element.addClass "uk-#{directive}-#{modifier}" for modifier in modifiers.split ","

# Helper function to create element based on an attribute else fallback to default element
_createElement = (mapper, attribute, fallback) ->
  angular.element if mapper[attribute] then mapper[attribute] else fallback

# Initialize angular-uikit module
angular_uikit = angular.module "angular-uikit", ["ngSanitize"]

# uk-article directive
ukArticle = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    articleTitle: "@"
    meta: "@"
    lead: "@"
  templateUrl: "#{partials}/ukarticle.html"
  link: ($scope, $element, $attributes) ->
    $scope.readmore = angular.fromJson $attributes.readmore

angular_uikit.directive "ukArticle", ukArticle

# uk-panel directive
ukPanel = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    panelTitle: "@"
    teaser: "@"
  templateUrl: "#{partials}/ukpanel.html"
  link: ($scope, $element, $attributes) ->
    $scope.badge = angular.fromJson $attributes.badge
    $scope.icon = angular.fromJson $attributes.icon
    _applyModifiers $element, $attributes.modifiers, "panel"

angular_uikit.directive "ukPanel", ukPanel

# uk-divider directive
ukDivider = ->
  restrict: "E"
  replace: yes
  templateUrl: "#{partials}/ukdivider.html"

angular_uikit.directive "ukDivider", ukDivider

# uk-comment directive
ukComment = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    commentTitle: "@"
    meta: "@"
  templateUrl: "#{partials}/ukcomment.html"
  link: ($scope, $element, $attributes) ->
    $scope.avatar = angular.fromJson $attributes.avatar
    _applyModifiers $element, $attributes.modifiers, "comment"

angular_uikit.directive "ukComment", ukComment

# uk-comment-list directive
ukCommentList = ->
  restrict: "E"
  replace: yes
  transclude: yes
  templateUrl: "#{partials}/ukcommentlist.html"
  link: ($scope, $element, $attributes) ->
    angular.element comment
      .wrap "<li />" for comment in $element.children()

angular_uikit.directive "ukCommentList", ukCommentList

# uk-button directive
ukButton = ->
  restrict: "E"
  replace: yes
  templateUrl: "#{partials}/ukbutton.html"
  link: ($scope, $element, $attributes) ->
    mapper =
      "button": "<button type='button' />"
    href = if $attributes.href then $attributes.href else ""
    temp_element = _createElement mapper, $attributes.type, "<a href='#{href}' />"
    temp_element.addClass "uk-button"
    temp_element.text $attributes.text if $attributes.text
    temp_element.attr "disabled", "" if "disabled" of $attributes
    temp_element.addClass "uk-width-1-1" if "fullwidth" of $attributes
    _applyModifiers temp_element, $attributes.modifiers, "button"
    $element.replaceWith temp_element

angular_uikit.directive "ukButton", ukButton

# uk-button-group directive
ukButtonGroup = ->
  restrict: "E"
  replace: yes
  transclude: yes
  templateUrl: "#{partials}/ukbuttongroup.html"

angular_uikit.directive "ukButtonGroup", ukButtonGroup

# uk-icon directive
ukIcon = ->
  restrict: "E"
  replace: yes
  templateUrl: "#{partials}/ukicon.html"
  link: ($scope, $element, $attributes) ->
    href = if $attributes.href then $attributes.href else ""
    mapper =
      "button": "<a href='#{href}' />"
    temp_element = _createElement mapper, $attributes.modifiers, "<i />"
    temp_element.addClass "uk-icon-#{$attributes.type}"
    _applyModifiers temp_element, $attributes.modifiers, "icon"
    $element.replaceWith temp_element

angular_uikit.directive "ukIcon", ukIcon

# uk-close directive
ukClose = ->
  restrict: "E"
  replace: yes
  templateUrl: "#{partials}/ukclose.html"
  link: ($scope, $element, $attributes) ->
    $scope.inalert = yes if "inalert" of $attributes
    $scope.inmodal = yes if "inmodal" of $attributes
    _applyModifiers $element, $attributes.modifiers, "close"

angular_uikit.directive "ukClose", ukClose

# uk-badge directive
ukBadge = ->
  restrict: "E"
  replace: yes
  transclude: yes
  templateUrl: "#{partials}/ukbadge.html"
  link: ($scope, $element, $attributes) ->
    $scope.inpanel = yes if "inpanel" of $attributes
    _applyModifiers $element, $attributes.modifiers, "badge"

angular_uikit.directive "ukBadge", ukBadge

# uk-alert directive
ukAlert = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: yes
  templateUrl: "#{partials}/ukalert.html"
  link: ($scope, $element, $attributes) ->
    if "close" of $attributes
      $scope.close = if $attributes.close == "" then yes else $attributes.close
      $element.attr "data-uk-alert", ""
    _applyModifiers $element, $attributes.modifiers, "alert"

angular_uikit.directive "ukAlert", ukAlert
