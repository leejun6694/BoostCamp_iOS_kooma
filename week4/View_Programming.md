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
- UIView class uses an on-demand drawing model for presenting content
- view first appears : system captures a snapshot -> uses the snapshot as the view's visual representation
  - 뷰 컨텐트가 바뀌지 않는 이상 drawing code도 호출되지 않는다.
  - 뷰 컨텐트가 바뀌면 시스템에게 뷰를 바꾸라고 알려준다. (notify)
  - 뷰 컨텐트가 바뀐다고 해서 바로 바뀌진 않고 setNeedsDisplay 또는 setNeedsDisplayInRect 메서드를 호출해 주어야 한다.
- 시스템은 현재 run loop가 끝나고 나서 다른 drawing operation을 시작한다.
  - 이런 지연 시간에는 여러 뷰를 뷰 계층에서 추가하거나 삭제 등 동시에 재배치 되는 것을 막는다.
  - 모든 변화들은 동시에 반영된다.
  - view의 content mode는 새로 그리는 것이 아닌 이미 존재해 있는 컨텐트의 snapshot을 재배치
