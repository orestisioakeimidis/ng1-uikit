"use strict"

# Global variables
partials = "partials"

# Apply modifier classes to elements
applyModifiers = (element, modifiers, directive) ->
  if modifiers
    element.addClass "uk-#{directive}-#{modifier}" for modifier in modifiers.split ","

# Create element based on an attribute else return fallback element
createElement = (mapper, attribute, fallback) ->
  angular.element if mapper[attribute] then mapper[attribute] else fallback

# Initialize angular-uikit module
angular_uikit = angular.module "angular-uikit", ["ngSanitize"]

# Layout Components
# ------------------------------

# Panel
ukPanel = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    panelTitle: "@"
    teaser: "@"
  templateUrl: "#{partials}/ukpanel.html"
  link: (scope, element, attributes) ->
    scope.badge = angular.fromJson attributes.badge
    scope.icon = angular.fromJson attributes.icon
    applyModifiers element, attributes.modifiers, "panel"

angular_uikit.directive "ukPanel", ukPanel

# Article
ukArticle = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    articleTitle: "@"
    meta: "@"
    lead: "@"
  templateUrl: "#{partials}/ukarticle.html"
  link: (scope, element, attributes) ->
    scope.readmore = angular.fromJson attributes.readmore

angular_uikit.directive "ukArticle", ukArticle

# Divider
ukDivider = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "#{partials}/ukdivider.html"

angular_uikit.directive "ukDivider", ukDivider

# Comment
ukComment = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    commentTitle: "@"
    meta: "@"
  templateUrl: "#{partials}/ukcomment.html"
  link: (scope, element, attributes) ->
    scope.avatar = angular.fromJson attributes.avatar
    applyModifiers element, attributes.modifiers, "comment"

angular_uikit.directive "ukComment", ukComment

# Comment List
ukCommentList = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "#{partials}/ukcommentlist.html"
  link: (scope, element, attributes) ->
    for child in element.children()
      elm = angular.element child
      next = elm.next()
      # If not a nested list render element normally
      if not elm.hasClass "uk-comment-list"
        elm.wrap "<li />"
      else
        # Remove comment list because it is not needed in nested list
        elm.removeClass "uk-comment-list"
      # If nested list append it in the current li
      if next.hasClass "uk-comment-list"
        elm.parent().append next

angular_uikit.directive "ukCommentList", ukCommentList

# Common Components
# ------------------------------

# Button
ukButton = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "#{partials}/ukbutton.html"
  link: (scope, element, attributes) ->
    mapper =
      "button": """<button type="button" />"""
    href = if attributes.href then attributes.href else ""
    temp_element = createElement mapper, attributes.type, """<a href="#{href}" />"""
    temp_element.addClass "uk-button"
    temp_element.text attributes.text if attributes.text
    temp_element.attr "disabled", "disabled" if "disabled" of attributes
    temp_element.addClass "uk-width-1-1" if "fullwidth" of attributes
    applyModifiers temp_element, attributes.modifiers, "button"
    element.replaceWith temp_element

angular_uikit.directive "ukButton", ukButton

# Button Group
ukButtonGroup = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "#{partials}/ukbuttongroup.html"

angular_uikit.directive "ukButtonGroup", ukButtonGroup

# Icon
ukIcon = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "#{partials}/ukicon.html"
  link: (scope, element, attributes) ->
    href = if attributes.href then attributes.href else ""
    mapper =
      "button": """<a href="#{href}" />"""
    temp_element = createElement mapper, attributes.modifiers, "<i />"
    temp_element.addClass "uk-icon-#{attributes.type}"
    applyModifiers temp_element, attributes.modifiers, "icon"
    element.replaceWith temp_element

angular_uikit.directive "ukIcon", ukIcon

# Close
ukClose = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "#{partials}/ukclose.html"
  link: (scope, element, attributes) ->
    scope.inalert = yes if "inalert" of attributes
    scope.inmodal = yes if "inmodal" of attributes
    applyModifiers element, attributes.modifiers, "close"

angular_uikit.directive "ukClose", ukClose

# Badge
ukBadge = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "#{partials}/ukbadge.html"
  link: (scope, element, attributes) ->
    scope.inpanel = yes if "inpanel" of attributes
    applyModifiers element, attributes.modifiers, "badge"

angular_uikit.directive "ukBadge", ukBadge

# Alert
ukAlert = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "#{partials}/ukalert.html"
  link: (scope, element, attributes) ->
    if "close" of attributes
      scope.close = if attributes.close == "" then yes else attributes.close
      element.attr "data-uk-alert", ""
    applyModifiers element, attributes.modifiers, "alert"

angular_uikit.directive "ukAlert", ukAlert
