# Week3

### Assignment
- [ ] 교재 9~11장 문제 해결해보기
- [ ] 스위프트 읽어오기 과제
- [ ] 생각 : 코딩 컨벤션은 왜 중요할까?
- [ ] UIView를 상속받아 버튼 만들어보기
- [ ] 스스로 만든 버튼을 로그인, 회원가입 화면에 적용해보기

### Todo

### Study
- initializer
  - 지정 initializer : 반드시 super class의 지정 initializer를 호출해야 함
  - convenience initializer : 반드시 같은 타입의 또 다른 initializer를 호출해야 함
- Cocoa Touch Table View
  - Data -> Data Source -> View
- App Delegate
  - 앱의 상태가 변하는 것을 제어
- UITableViewCell(style:reuseIdentifier:)
  - 현재 화면에서 불필요한 셀을 메모리에 요구하지 않음
  - 메모리를 절약하면서 성능을 개선하기 위해 테이블 뷰 셀들을 재사용할 수 있음
  - 화면 밖의 셀들은 재사용을 위해 가용 셀 풀(pool)에 들어감
  - 데이터 소스는 매 요청마다 새로운 셀을 만드는 대신에 가용 풀을 먼저 확인
  - 풀에 사용하지 않은 셀이 있다면 그 셀에 새로운 데이터를 설정하고, 테이블 데이터 소스는 뷰에 셀을 반환
  - 반드시 반환된 셀의 타입을 확인해야 함(다른 타입의 셀이 존재할 수도 있음)
  - reuseIdentifier 프로퍼티를 사용해 재사용 -> 관례적으로 보통 셀 클래스의 이름을 사용
- isEditing
  - @property(nonatomic,getter=isEditing) BOOL editing;
  - Updates the appearance of the Edit|Done button item as necessary. Clients who override it must call super first
- setEditing
  - extension UIViewController
  - open func setEditing(_ editing: Bool, animated: Bool)
- move item
  - select -> delete -> create
- ActionController
  - .alert : 계속 진행하기 위해 사용자의 결정이 필요한 중요 정보를 표시
  - .actionsheet : 사용자의 결정을 되돌리거나 그 동작이 중요하지 않은 정보를 표시

### Question
- 의존 관계 역전 원칙
- Insets
