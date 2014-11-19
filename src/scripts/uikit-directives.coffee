"use strict"

# Apply modifier classes to element
applyModifiers = (element, modifiers, directive) ->
  if modifiers
    element.addClass "uk-#{directive}-#{modifier}" for modifier in modifiers.split ","

# Remove selected attributes from element
clearAttrs = (element, attributes) ->
  element.removeAttr attribute for attribute in attributes

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
    title: "@"
    teaser: "@"
  templateUrl: "partials/panel.html"
  link: (scope, element, attributes) ->
    scope.badge = angular.fromJson attributes.badge
    scope.icon = angular.fromJson attributes.icon
    applyModifiers element, attributes.modifiers, "panel"
    clearAttrs element, ["badge", "icon", "modifiers", "teaser", "title"]

angular_uikit.directive "ukPanel", ukPanel

# Article
ukArticle = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    title: "@"
    meta: "@"
    lead: "@"
  templateUrl: "partials/article/default.html"
  link: (scope, element, attributes) ->
    scope.readmore = angular.fromJson attributes.readmore
    clearAttrs element, ["lead", "meta", "readmore", "title"]

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
    title: "@"
    meta: "@"
  templateUrl: "partials/comment/default.html"
  link: (scope, element, attributes) ->
    scope.avatar = angular.fromJson attributes.avatar
    applyModifiers element, attributes.modifiers, "comment"
    clearAttrs element, ["avatar", "meta", "modifiers", "title"]

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
      # If next element is a nested list append it in the current's parent element
      if nested next
        elm.parent().append next

angular_uikit.directive "ukCommentList", ukCommentList

# Common Components
# ------------------------------

# Button
ukButton = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope:
    href: "@"
  templateUrl: (element, attributes) ->
    template = if "href" of attributes then "anchor" else "default"
    "partials/button/#{template}.html"
  link: (scope, element, attributes) ->
    scope.disabled = "disabled" of attributes
    scope.fullwidth = "fullwidth" of attributes
    applyModifiers element, attributes.modifiers, "button"
    clearAttrs element, ["fullwidth", "href", "modifiers"]

angular_uikit.directive "ukButton", ukButton

# Button Group
ukButtonGroup = ->
  restrict: "E"
  replace: yes
  transclude: yes
  scope: {}
  templateUrl: "partials/button/group.html"

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
    clearAttrs element, ["href", "modifiers"]

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
    clearAttrs element, ["inalert", "inmodal", "modifiers"]

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
    clearAttrs element, ["modifiers"]

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
    clearAttrs element, ["close", "modifiers"]

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
    clearAttrs element, ["caption", "modifiers", "src", "type"]

angular_uikit.directive "ukThumbnail", ukThumbnail
