## [2.1.3] - Release
 * Improvement


## [2.1.2] - Release
 * replace `sliderShadow` to `sliderBoxShadow`
 * Slider RightToLeft : Gesture area issue fixed
 * Fixed issue : #21 and #23

## [2.1.1] - Release
 * Provide custom appBar feature
 * Slider LeftToRight and RightToLeft issue fixed


## [2.1.0] - Release
 * Code Refactor
 * Improve Documentation
 * deprecated : `sliderMenuOpenSize` and `sliderMenuCloseSize`
 * deprecated : `sliderMenu` and `sliderMain`
 * deprecated : `closeDrawer` and `openDrawer`
 * deprecated : `SliderMenuContainerState`
 * deprecated : `hasAppBar`
 * deprecated : `isShadow`
 * replace `sliderMenuOpenSize` and `sliderMenuCloseSize` to `sliderOpenSize` and `sliderCloseSize`
 * replace `sliderMenu` and `sliderMain` to `slider` and `child`
 * replace `closeDrawer` and `openDrawer` to `closeSlider` and `openSlider`
 * replace `SliderMenuContainerState`  to `SliderDrawerState`
 * replace `hasAppBar`  to 'appBar' : if you set `app:null` then it will hide
 * replace `isShadow`  to 'sliderShadow' : if you set `sliderShadow:null` then shadow will not come
   by default it's null



## [2.0.0] - Release

 * Added null safety 

## [1.2.1] - Release

 * Improve code document

## [1.2.0] - Release

 * Implement swipe to open feature for sliderDirection **LEFT_TO_RIGHT** and **RIGHT_TO_LEFT**.
 * Deprecate parameter `sliderMenuOpenOffset` and `sliderMenuCloseOffset`. You can use `sliderMenuOpenSize` and `sliderMenuCloseSize`.
 * Deprecate parameter `sliderOpen`. You can use `slideDirection`
 * Deprecate parameter `sliderAnimationTimeInMilliseconds`. You can use `animationDuration`
 * You can access `animationController` by key.
 * Bug fixed

## [1.0.3] - Release

 * Added TopToBottom slide feature
 * Added Shadow feature with shadowColor,shadowBlurRadius and shadowSpread dynamic handle
 * Bug fixed


## [1.0.2] - Release 

 * Added RightToLeft/LeftToRight slide feature
 * Bug fixed

## [1.0.1] - Release 

 * Bug fixed
 
## [1.0.0] - Release 

 * Slider with custom animation time
 * Provide Basic Appbar with customization of color, sizes and title
 * Dynamic slider open and close offset
 * Provide drawer icon animation 
