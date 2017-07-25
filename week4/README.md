# Week4

### Assignment
- [x] 교재 8, 13, 17장 문제 해결해보기
- [ ] 프로젝트 스토리보드 그려보기
- [ ] iOS 프로그래밍 가이드 읽어오기 과제
- [x] 우리는 왜 클래스 또는 구조체를 사용할까?
- [x] 1 to 25

### Todo
- [x] Chapter 12 - 스택뷰
- [x] tableView 하단 버튼, 최고기록 갱신, 생성날짜

### Study
> Stack View
- Segue
  - UIStoryboardSegue
  - style : 어떻게 나타낼지
  - action item : UIControl과 같은 스토리보드 파일의 뷰 객체
  - identifier : 프로그래밍으로 세그웨이에 접근할 때 사용
- prepareForSegue(_:sender:)
  - 발생한 세그웨이에 대한 정보를 주는 UIStoryboardSegue
    - source view controller
    - destination view controller
    - identifier
  - 세그웨이를 발생시킨 객체 (sender)

> UINavigationController
- drill-down interface
- Navigation 컨트롤러 안에 내장된 뷰 컨트롤러에서 show 세그웨이를 호출할 때 목표 뷰 컨트롤러가 Navigation 컨트롤러의 뷰 컨트롤러의 스택 안으로 푸시
- UINavigationController가 뷰들을 교환하기 직전에 viewWillDisappear(_:)와 viewWillAppear(_:) 메서드를 호출
- UINavigationItem은 UIView의 하위 클래스가 아님
  - title string or title view

> 1 to 25
- archiving
  - archiving : 객체의 프로퍼티들을 모두 기록하고 파일시스템에 그 내용을 저장하는 것
  - unarchiving : 아카이브한 데이터로부터 객체를 다시 만듬
  - String archiving : String -> NSString
- Application Sandbox
  - Documents/ : 앱이 실행 중에 생성한 데이터를 다시 실행 했을 때도 유지할 수 있도록 데이터를 저장하는 디렉터리
  - Library/Caches/ : Documents와 같이 데이터를 저장하지만 동기화할 때 백업되지 않음
  - Library/Preferences/ : 설정 내용이 저장되고 설정 앱이 앱의 설정을 검색하는 디렉터리
  - tmp/ : 앱 실행 중에 임시로 사용하는 데이터를 저장하는 디렉터리

### Question
- 왜 문자열 삽입 대신에 포맷지정자?
- @obj
