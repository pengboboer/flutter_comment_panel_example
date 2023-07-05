csdn：https://blog.csdn.net/pengbo6665631/article/details/131551882

掘金：https://juejin.cn/post/7252171043384246331
# flutter_comment_panel_example

### A very good comment panel demo!

base on sliding_up_panel: 

https://pub.dev/packages/sliding_up_panel

I have perfected the following details:

1. Swipe link for list and panel gestures
2. Swipe connection for multiple lists and panel gestures when there are partial routes
3. Gesture monitoring of TopBar at the top of the panel
4. When the keyboard pops up, the corresponding list item will be positioned above the comment box
5. After the keyboard pops up, the panel gestures are disabled to prevent users from accidentally touching
6. Monitor the side slide back of the mobile phone to make it meet our expectations
7. Handle the conflict between ios side sliding gesture and pull down gesture

example:

![image](/example.gif)





