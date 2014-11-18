"use strict"

# Apply modifier classes to element
applyModifiers = (element, modifiers, directive) ->
  if modifiers
    element.addClass "uk-#{directive}-#{modifier}" for modifier in modifiers.split ","

# Create element based on an attribute else return fallback element
createElement = (mapper, attribute, fallback) ->
  angular.element if mapper[attribute] then mapper[attribute] else fallback

# Initialize module
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
  templateUrl: "partials/panel.html"
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
  templateUrl: "partials/article/default.html"
  link: (scope, element, attributes) ->
    scope.readmore = angular.fromJson attributes.readmore

angular_uikit.directive "ukArticle", ukArticle

# Article Divider
ukArticleDivider = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "partials/article/divider.html"

angular_uikit.directive "ukArticleDivider", ukArticleDivider

# Comment
ukComment = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    commentTitle: "@"
    meta: "@"
  templateUrl: "partials/comment/default.html"
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
  templateUrl: "partials/comment/list.html"
  link: (scope, element, attributes) ->
    nested = (node) ->
      node.hasClass "uk-comment-list"
    for child in element.children()
      elm = angular.element child
      next = elm.next()
      # If not a nested list render element normally
      if not nested elm
        elm.wrap "<li />"
      else
        # Remove comment list class because it is not needed in nested list
        elm.removeClass "uk-comment-list"
      # If next element is a nested list append it in the current element
      if nested next
        elm.parent().append next

angular_uikit.directive "ukCommentList", ukCommentList

# Common Components
# ------------------------------

# Button
ukButton = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "partials/button.html"
  link: (scope, element, attributes) ->
    mapper =
      "button": """<button type="button" />"""
    href = attributes.href or ""
    tempElement = createElement mapper, attributes.type, """<a href="#{href}" />"""
    tempElement.addClass "uk-button"
    tempElement.text attributes.text if attributes.text
    tempElement.attr "disabled", "disabled" if "disabled" of attributes
    tempElement.addClass "uk-width-1-1" if "fullwidth" of attributes
    applyModifiers tempElement, attributes.modifiers, "button"
    element.replaceWith tempElement

angular_uikit.directive "ukButton", ukButton

# Button Group
ukButtonGroup = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "partials/buttonGroup.html"

angular_uikit.directive "ukButtonGroup", ukButtonGroup

# Icon
ukIcon = ->
  restrict: "E"
  replace: yes
  scope:
    href: "@"
  templateUrl: (element, attributes) ->
    template = if "button" in attributes.modifiers.split "," then "button" else "default"
    "partials/icon/#{template}.html"
  link: (scope, element, attributes) ->
    applyModifiers element, attributes.modifiers, "icon"

angular_uikit.directive "ukIcon", ukIcon

# Close
ukClose = ->
  restrict: "E"
  replace: yes
  scope: {}
  templateUrl: "partials/close.html"
  link: (scope, element, attributes) ->
    scope.inalert = "inalert" of attributes
    scope.inmodal = "inmodal" of attributes
    applyModifiers element, attributes.modifiers, "close"

angular_uikit.directive "ukClose", ukClose

# Badge
ukBadge = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "partials/badge.html"
  link: (scope, element, attributes) ->
    scope.inpanel = "inpanel" of attributes
    applyModifiers element, attributes.modifiers, "badge"

angular_uikit.directive "ukBadge", ukBadge

# Alert
ukAlert = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "partials/alert.html"
  link: (scope, element, attributes) ->
    if "close" of attributes
      scope.close = if attributes.close is "" then yes else attributes.close
      element.attr "data-uk-alert", ""
    applyModifiers element, attributes.modifiers, "alert"

angular_uikit.directive "ukAlert", ukAlert

# Thumbnail
ukThumbnail = ->
  restrict: "E"
  replace: yes
  scope:
    src: "@"
    alt: "@"
    href: "@"
    caption: "@"
  templateUrl: (element, attributes) ->
    template = attributes.type or "default"
    if template is "default" and "caption" of attributes
      template = "caption"
    "partials/thumbnail/#{template}.html"
  link: (scope, element, attributes) ->
    applyModifiers element, attributes.modifiers, "thumbnail"
    element.removeAttr "src"
    element.removeAttr "caption"
    element.removeAttr "type"
    element.removeAttr "modifiers"

angular_uikit.directive "ukThumbnail", ukThumbnail
