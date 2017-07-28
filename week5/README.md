# Week5

### Assignment
- [ ] 교재 15, 19, 20장 문제 해결해보기
- [ ] 프로젝트 스토리보드 더 자세한 스펙 그려보기
- [ ] 스위프트에 옵셔널은 왜 존재할까?
- [ ] 사진 게시판 애플리케이션 만들어보기

### Todo
- [x] 14장 카메라

### Study
- 카메라
  - UIImagePickerControllerDelegate는 UINavigationController로부터 상속된 것
  - 상속된 delegate 프로퍼티는 UINavigationControllerDelegate를 따르는 객체를 참조하도록 선언
  - 따라서 UIImagePickerController를 사용할 때 UINavigationControllerDelegate도 추가

- 저장하기, 불러오기, 앱 상태
  - Object로 인코딩과 같이 객체를 원하는 메서드일 때 String은 NSString으로 자동 변환되기 때문에 String type을 사용할 수 있음
  - 인코딩은 재귀적 프로세스
  - guard
    - 사용하면 검사할 조건식을 실패 케이스에 직접 연결할 수 있음
    - 이는 코드를 더 쉽고 가독성 있게 만듬

### Question
