## Tutoring log

- 컴포넌트 별로 height값이 달라질 수 있다
  - 교재 컨텐츠 고유 크기 참고

- 튜터님이 1차 과제에서 Stack View를 안 쓴 이유
  - Stack View는 iOS 9.0+ 이므로

- iOS Version 업데이트
  - 새로운 컴포넌트들이 나올때마다 적용하기 어려움 일단 새롭게 나온 컴포넌트들의 기능을 알아두고 실무적으로 1년 후 정도에 적용
  - apple은 하위호환이 깔끔한편, 개발자들은 version 처리를 꼭 신경써줘야함
  - 릴리즈 정보를 잘 알아두고 api reference, Beta version 사용으로 미리 적용 사항 확인

- storyboard vs programming
  - ui 구성시 스토리보드, 코드는 둘다 알아둬야 한다
  - 조직마다 선호도가 다름 (NAVER는 코딩을 선호)
  - AutoLayout 코딩은 예전 보다 많이 중요해지고 잘 알아둬야 함

- Swift 문법 중 강조하신 것
  - optional 굉장히 중요함
    - !(force-unwrapping) 사용을 지양하자
    - 기존 언어에는 없었던 optional에 대해 많이 고민해 볼 것

- iOS 기술 관련
  - [App Life Cycle](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html#//apple_ref/doc/uid/TP40007072-CH2-SW1)에 해당하는 method 중요
  - 기본 자료형, 컬렉션 코드를 공부해서 Type Customizing에 쓰자
  - xCode 디버깅 툴을 잘 활용하자
  - Apple 문서 참고를 습관화 하자
  - awakeFromNib() -> 스토리보드로 작성한 화면이 실행되면 호출
  - AutoLayout Tip : 화면의 중요 View를 찾아라
    - 중요 View를 잡고 이 뷰에 대해서 상대적인 constraint를 정하자, hugging priority에 대해서도 알아두자
    - 중요 View는 디자이너와 상의

- AppDelegate Class에서 window 프로퍼티 UIWindow? 타입인데 nil일 가능성이 있는가?
  - window 교체 시 잠깐 nil이 될 가능성이 있다
  - window 개념이 macOS에서 따와서 생김

- 프로젝트 이름에 알파벳, 언더바 외에는 되도록 쓰지 말자

- Objective-C를 공부할 타이밍
  - Objective-C는 Swift를 자유자제로 쓰고 난 후 공부해도 늦지 않음

- 튜터님이 1기 App 중에 생각나는 앱
  - 성경낭독 (NAVER 음성인식 API)
  - 공연 정보 남기는 앱
  - 여행사진 경로 남겼던 앱

- 튜터님의 코딩방식
  - 일단 기능이 동작하는 코드를 완성한다
  - 그 코드를 모듈화하고 세분화한다

- 프로젝트 관련
  - open api나 공공데이터에서 써볼만한 api를 빨리 정하는게 좋다
  - 네트워크에 별 관심이 없다면 이미지나 동영상을 다루는 앱도 좋음
  - 프로젝트는 미리 생각해두자
  - 서버는 불가. DB로는 SQL Lite, Realm

- 권고사항
  - 매주 한 두번 주제를 가지고 스터디를 했으면 좋겠다
  - 조사하고 공유 발표, 스터디 할 내용을 튜터님께 미리 알려드려서 참고 자료같은 도움을 받을 수도 있음
  - 튜터님 추천 : AutoLayout
