# Week5

### Assignment
- [x] 교재 15, 19, 20장 문제 해결해보기
- [ ] 프로젝트 스토리보드 더 자세한 스펙 그려보기
- [x] 스위프트에 옵셔널은 왜 존재할까?
- [ ] 사진 게시판 애플리케이션 만들어보기
  - [x] 회원가입 (성공/실패)
  - [x] 회원가입 (입력값 확인)
  - [x] 로그인
  - [x] 테이블뷰
  - [ ] 게시물 작성 / 새로고침
  - [ ] 게시물 삭제
  - [ ] 게시물 수정
  - [ ] 컬렉션뷰
  - [ ] 도전과제 - 이메일 형식 확인
  - [ ] 도전과제 - 이메일 기억하기
  - [ ] 도전과제 - 이미지 확대화면

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

- Web Services
  - URLRequest
    - allHTTPHeaderFields : HTTP 트랜젝션에 관한 메타데이터의 딕셔너리. 문자 인코딩, 서버의 캐싱 처리법 등을 포함
    - allowsCellularAccess : 요청에서 셀룰러 데이터를 사용할 것인지의 여부를 나타냄. boolean
    - cachePolicy : 로컬 캐시를 어떻게 사용할지를 결정
    - HTTPMethod : 요청 메서드. 기본 값은 GET이고 다른 값으로 POST, PUT, DELETE
    - timeoutInterval : 서버에 요청을 시도할 연결의 최대 지속 시간
  - URLSession
    - URLSessionDataTask : 서버로부터 데이터를 가져와서 메모리에 NSData로 반환
    - URLSessionDownloadTask : 서버로부터 데이터를 가져와서 파일시스템에 파일로 저장
    - URLSessionUploadTask : 서버로 데이터를 보낸다
  - awakeFromNib() : 인터페이스 파일이 로드되고 아웃렛 커넥션이 만들어진 후에 호출
  - prepareForReuse() : 셀이 재사용되기 직전에 호출
  - case let
    ```swift
    if case let .success(image) = result {
      photo.image = image
    }
    ```

    same

    ```swift
    switch result {
      case let .success(image):
        photo.image = image
      case .failure:
        break
    }
    ```

- ImageBoard
  - navigation bar가 있다면 topLayoutGuide는 bar 기준

  ```
  url
  request = URLRequest(url: url)
  request 설정 (method, value, body)
  session.task(with: request)
  task.resume()
  ```

  - session
    - 상호작용적인 정보 교환
    - 서버가 해당 서버(웹)로 접근 (request)한 클라이언트를 식별하는 방법

### Question
