# ui_additional_actions_button
## argumentList
object
additionalActions
## comment

An easier to use version of `uiActionPickerWithIcon` that deals with a specific value.
* `object` is the value which every action gets as its parameter.
* `additionalActions` is a list of pairs, where each pair contains a string (first item) and a function (second item). These pairs are used to construct an action picker ("three dot button"), where the string specifies the title of each action and the function specifies the action itself. When an action is selected by the user, the appropriate function is called with the `object`
