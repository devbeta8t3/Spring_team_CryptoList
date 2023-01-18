# Spring_team
Spring framework for the team project at Busan IT training center

부산 IT 교육센터 블록체인 수업. Spring framework 과정의 Team project.
(B조: 이세환, 윤용석, 김록길)

  - 주요(Cap Top 100) 암화화페의 리스트를 나열.
  - 선택된 암호화폐의 정보 표시.
  - 간단한 코멘트를 위한 게시판 첨부.(표시/등록/수정/삭제)
  - 회원관리.(등록/수정/삭제)
  - 즐겨찾기.(등록/삭제)

Skills used
1. Spring framework, MyBatis
2. Java, JSP
3. HTML, CSS(Bootstrap), Javascript(jQuery, Ajax)
4. Oracle DB 11g
5. Messari API

발표 후 코멘트 by 윤요섭 선생님 
1. PPT - 구현 기능에 대한 자세한 기술(description)  
        1) 회원가입 - 유효성 검사 by JS 방법  
        2) 사용한 API에 대한 설명(소개), 선택한 이유 & 유사 API 비교(장점)  
        3) API 요청/응답에 사용한 방법 - AJAX JSON ARRAY 등 구현과정을 자세히  
        4) open API 요청/응답 & DB 즐겨찾기 요청/응답 활용시 동기 및 비동기 해결을 위한 방법 언급 (async: false 사용)  
        5) 게시판의 게시물 추가/삭제시 리사이클뷰? (게시물 전체를 리로드하지 말고 attach만 하는 방식으로 고려해볼 것)  
        6) 게시판 스크롤 or 페이지네이션 처리  
2. Code  
        1) 회원가입 유효성 검사 모듈화 해라  
        2) 로그인 ID/PW 검증을 따로 해라. service에서 2개의 mapper를 날리면 된다.  
        3) 즐겨찾기 추가/삭제시 실제 쿼리 success 후에 별색깔 바꿔보자.  
        4) 게시물 추가시 게시물 전체 리로드 없이 추가만 되는 방식으로.. 최신순으로 할때는 first child..?  
