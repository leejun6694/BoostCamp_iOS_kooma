# Week2

### Assignment
- [x] 애플의 [MVC 문서](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html) 읽어오기
- [x] [Start Developing iOS Apps](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html)의 Define Your Data Model 파트까지 읽어오기
- [x] 교재 4 ~ 6장 문제 해결해보기
- [x] 교재의 UIGestureRecognizer(18장) 내용 익히기
- [x] [iOS Technology Overview](https://developer.apple.com/library/content/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Introduction/Introduction.html) 문서 훑어보기
- [x] Cocoa Fundamentals Guide 문서의 챕터 읽어오기
- [x] 스위프트 읽어오기 과제
- [ ] iOS 프로그래밍 가이드 읽어오기 과제
- [x] 나는 프로그래머인데 왜 H.I.G를 배웠을까?
- [x] 회원가입 화면 구현해보기
- 도전 과제
  - [x] 회원가입 화면이 나오도록 구성
  - [x] Modal dismiss
  - [x] 비밀번호 텍스트 일치 여부
  - [x] SignUp View Rotation

### Todo
- [ ] 1주차 layout -> code화
- [ ] SignUpView 아이디와 비밀번호 값이 없는 경우 dismiss하지 않고 각 경우에 맞는 Modal 띄우기

### Study
> View life cycle
- viewWillAppear : 해당 view가 view 계층에 추가되기 전에 호출
- viewDidAppear : 해당 view가 view 계층에 추가된 이후에 호출
  - fetching data or showing an animation
- viewWillDisappear : 해당 view가 view 계층에서 제거되기 전에 호출
- viewDidDisappear : 해당 view가 view 계층에서 제거된 이후에 호출
- viewDidLoad : 해당 view가 memory에 올라온 이후에 호출

> FoodTracker - Work with View Controllers
- interaction : need to define an action (gesture)
- UIImagePickerController
  - manages the user interface for taking pictures and for choosing saved images to use in your app
- present(_:animated:completion:)
  - _: UIViewController
  - animated: animates the presentation of the viewController
  - completion: executes after this method completes
- UIImagePickerControllerOriginalImage vs UIImagePickerControllerEditedImage
  - UIImagePickerController는 사용자가 사진이나 영상을 수정할 수 있는 allowsEditing 프로퍼티를 가지고 있는데 이를 통해 original image와 edited image를 구분
- SIGABRT signal : an error occurred that was serious enough to cause the app to abort

> FoodTracker - Implement a Custom Control
- init(frame:)
  - for programmatically initializing the view
- init?(coder:)
  - for loading the view from the storyboard
- override & required
  - subclass에서 초기화하지 않으면 superclass의 initializer를 자동으로 상속
  - subclass에서 initializer를 구현하면 더 이상 superclass에서 상속받지 않음
  - 그러나 superclass에서 하나 이상의 initializer를 표시가능 : required
  - subclass는 모든 initializer를 구현해야함 (또는 자동 상속)
  - 더 나아가 subclass가 required 표시를 함으로써 자신의 subclass가 initializer를 구현해야함을 나타냄
- private function : 선언한 클래스 내에서만 호출 가능
- translatesAutoresizingMaskIntoConstraints (필수로 적어줘야 하는건 아님))
  - true : use default constraints
  - false : disable automatically generated constraints
- @IBDesignable : Interface Builder가 캔버스 내에서 직접 컨트롤의 복사본을 인스턴스화 하고 그릴 수 있도록 함 (코드 -> 시각적)
- @IBInspectable : Attribute Inspector에서 설정할 수 있는 속성을 지정함 -> didSet 필요 (결과를 반영하기 위해)
- enumerated : (n, x) 꼴로 배열의 index와 함께 불러와줌
- Rating Control - work with Voice Over
  - Accessibility label
  - Accessibility value
  - Accessibility hint

> FoodTracker - Define Your Data Model
- cocoa touch class vs swift file
  - swift file : base file, no inherit from any other classes
- init? : Failable initializer
- guard : validating data before letting code execute

> Project - Sign Up View
- UIImageView : Tap Gesture Recognizer 사용시 User Interface Enabled 체크!

> Cocoa Fundamentals Guide
- Cocoa Touch : The frameworks in this layer directly support applications based on iOS. They include two Objective-C frameworks that are particularly important for developing applications for iOS
  - UIKit : provides the objects an application displays in its user interface and defines the structure for application behavior, including event handling and drawing.
  - Foundation : defines the basic behavior of objects, establishes mechanisms for their management, and provides objects for primitive data types, collections, and operating-system services.
- Foundation : defines a base layer of classes that can be used for any type of Cocoa program
  - no appear in a user interface
  - no exclusively used to support a user interface
  - memory management
  - object mutability
  - notification
  - object persist when they're needed
  - freed when they are no longer needed
  - garbage collection : automatically tracks and disposes of objects that your program no longer needs
  - Mutable class variants : mutable class always being a subclass of the immutable one
  - Class clusters
  - Notifications : allows objects to be kept informed of what another object is doing or is encountering in the way of user or system events

- UIKit : provide all the classes that an application needs to construct and manage its user interface
  - UIResponder : default behavior for event handling method
  - UIControl : set of event types for controls
  - UIEvent : represent events that user’s finger movements on the screen are what originate events

> TouchTracker
- 구조체
  - 구조체는 상속을 지원 안함
  - 구조체는 아무런 이니셜라이저 선언이 없으면 구조체 멤버 단위 이니셜라이저를 얻음
  - 모든 프로퍼티가 기본 값을 갖고 다른 이니셜라이저가 없다면 빈 이니셜라이저를 얻음
  - 값 타입
- UIBezierPath : view에 직선이나 곡선의 경로를 정의
  - lineWidth : 선의 굵기
  - lineCapStyle : 선의 끝부분 스타일
  - move(to:) : 현재 포인트에서 특정 위치로 이동
  - addLine(to:) : 이동 경로를 추가 -> move(to:) 와 같이 사용
  - stroke() : 현재 경로를 그림
- setNeedsDisplay() : view를 다시 그림
- view -> Multiple Touch : multipleTouchesEnabled = true
- NSValue(nonretainedObject:) : 지정된 객체를 포함하는 값을 생성
  - 이 method는 collection에 객체를 추가하지만 그 collection이 객체에 대한 string reference를 만들지 않길 원하는 경우에 유용
- print(#function) : method명을 나타내는 String 반환해서 출력
- UITouch 객체는 절대 retain하지 말라고 문서에 쓰여짐 -> init(nonretainedObject:)
- (gesture).require(toFail: (another gesture)) : 두 개의 제스처가 중복적으로 일어나는 것을 방지함
- 현재 위치에서 가장 가까운 선찾기
  - 완료된 선의 집합에서 index로 찾기
  - index : tap하는 point 기준으로 가장 가까운 점 (일정 거리 이내)로 탐색
- becomeFirstResponder()
  - 반드시 canBecomeFirstResponder() method를 override 해야함
- tap : 개별 제스처 vs long press : 연속 제스처
- cancelsTouchesInView
  - 모든 UIGestureRecognizer에 존재하는 property
  - 기본 값은 true
  - true : 제스처 인식기는 제스처를 인식하고 나서 터치를 먹음
  - false : 제스처 인식기가 인식한 터치가 UIResponder method를 통해 뷰에도 전달되는 것을 보장
- UIGestureRecognizerDelegate
  - gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {} : 중복 Gesture를 허용 (true)

> iOS Technology Overview
- Cocoa Touch Layer : define the appearance of the app
  - App Extension : iOS 8.0+. Share, Action, Widget, Photo editing, Document provider, Custom keyboard
  - Handoff : one device then switch another device
  - Document Picker : sharing document between apps
  - Air drop : share data nearby device
  - TextKit : handling text
  - UIKit Dynamics : dynamic behavior on view
  - Multitasking : focus on battery life
  - Auto Layout : define rules for how to layout the element in the user interface
  - Storyboard : design app's user interface
  - UI State Preservation : seamless experience
  - Apple Push Notification Service : alert users about new information even when user's app is not actively running
  - Local Notifications : can notify in background
  - Gesture Recognizer : detect common types of gesture
  - Standard System View Controller : use the provided view controllers
- Media Layer
  - Graphics Technologies
  - Audio Technologies
  - Video Technologies
  - AirPlay : content to 3rd party
- Core Services Layer : fundamental system services for apps
  - Peer-to-Peer Services : bluetooth
  - iCloud Storage : access item from all of iOS device
  - Data Protection
  - File-Sharing Support : device-iTunes
  - Grand Central Dispatch : manage the execution of tasks in the app
  - In-App Purchase
  - SQLite : embed a lightweight SQL database into the app
  - XML Support
- Core OS Layer : contains the low-level features that most other technologies are built upon

### Question
- resignFirstResponder()
  - 단지 hide keyboard에만 쓰이는게 아닐 듯
  - 정확한 기능
  - canBecomeFirstResponder
- required
  - 자동 상속이 아니고 필요함?
- Modal View code?
- UIResponder vs UIControl
  - UIResponder : touch
  - UIControl : button, slider
- Chapter 18 중 view의 이어지는 터치와 GestureRecognizer의 pan이 겹쳐서 view의 이어지는 터치가 불완전하게 끝나는 현상 발생
  - 이어지는 터치 중간에 pan을 isEnable false로 바꿔서 해결하긴 했지만 깔끔하지가 않은 느낌
  - touchesMoved, moveRecognizer
- MapView
  -ERROR /BuildRoot/Library/Caches/com.apple.xbs/Sources/VectorKit_Sim/VectorKit-1230.34.9.30.27/GeoGL/GeoGL/GLCoreContext.cpp 1763: InfoLog SolidRibbonShader:
  - ERROR /BuildRoot/Library/Caches/com.apple.xbs/Sources/VectorKit_Sim/VectorKit-1230.34.9.30.27/GeoGL/GeoGL/GLCoreContext.cpp 1764: WARNING: Output of vertex shader 'v_gradient' not read by fragment shader
- LogInView 180도 회전
