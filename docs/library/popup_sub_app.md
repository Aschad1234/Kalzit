# popup_sub_app
## argumentList
contentGenerator
## comment

This function allows you to easily create a popup-based sub app.
A sub-app is a part of your app which the user can open - and close after using it.
While the sub-app is open, the user can not interact with the rest of the app.
This kind of behavior is typical for popup windows, which is why they are often used for sub-apps.

The "popupSubApp" function allows you to define a sub-app based on its content - which will be shown in a popup when it is opened.
The automatic opening and closing of the popup, as well as the closing of the active sub app when the popup itself is closed, is handled by this function.

For example, if you want a sub-app to display a website in a popup window, you can do this:
$appName registerSubApp popupSubApp: {
uiShowWebpageUrl: "yourWebpageHere"
}.

The first parameter of this function is a piece of code (or a function) which is called whenever the sub app is opened. The returned value is then used to populate the popup with content.

If you want to just show a popup without linking it to a sub-app (which you should not do!), use "uiPopup" and "print".
If you want more freedom when defining sub apps, take a look at "registerSubApp".
