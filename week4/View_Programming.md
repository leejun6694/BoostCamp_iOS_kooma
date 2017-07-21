# View Programming Guide for iOS

## View Architecture Fundamentals
- Views work in conjunction with Core Animation layers to handle the rendering animating of a view's content
- Every view in UIKit is backed by a layer object which manages the backing store for the view and handles view-related animations
- Most operations you perform should be through the UIView interface. However, in situations where you need more control over the rendering or animation behavior of your view, you can perform operations through its layer instead
- UIToolbar button is not view but manages a view internally (internal view)
- Reuse already-rendered content eliminates the expensive drawing cycle usually needed to update views

## View Hierarchies and Subview Management
- relationship
  - child view : subview
  - parent view : superview
- Visually, the content of a subview obscures all or part of the content of its parent view
- When you change the size of a parent view, you can control the resizing behavior of each subview by configuring the view appropriately (Responder chain)
- The arrangement of views in a view hierarchy also determines how your application responds to events
  - When a touch occurs inside a specific view, the system sends an event object with the touch information directly to that view for handling
  - However, if the view does not handle a particular touch event, it can pass the event object along to its superview
  - If no object handles the event, it eventually reaches the application object, which generally discards it

## The View Drawing Cycle
