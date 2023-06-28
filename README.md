# chagawa
* 카풀 매칭 사이트
* JSP 프로젝트
* 5인 팀 프로젝트

## 🖥 프로젝트 소개
* 운전자 회원은 카풀 정보를 등록할 수 있다.
* 동승자 회원은 카풀 정보를 확인하고 원하는 카풀을 신청할 수 있다.
* 회원들은 해당 이용내역에 대한 후기를 작성할 수 있다.
* 회원들은 메세지를 통해 관리자에게 문의하거나 회원 간의 소통을 할 수 있다.
* 사이트는 카풀 이용료를 받아 수익을 창출한다.

## 📆 개발 기간
* 2023.02.20. ~ 2023.03.03. (2주)

## 👨‍👧‍👧 담당자별 개발 내용
* **주해린**(DBA)
  - 비회원: 로그인, 회원가입, 아이디/비밀번호 찾기
  - 회원: 내정보보기, 내정보수정, 비밀번호변경, 등급변경, 탈퇴
  - 관리자: 회원리스트, 회원정보보기, 회원 등급/상태 변경
* 김소연(서기) - 공지사항 CRUD
* 정하영(PL) - 카풀 리스트, 내 이용 내역, 상세 보기, 카풀 등록, 동승 신청 부터 종료까지 각 단계에 따른 운영 시스템
* 조용우(PM) - 대화방 리스트, 채팅 로그, 메시지 보내기, 안 읽은 메시지, 방 상태 수정
* 김태웅(팀장) - 이용후기 CRUD

## ⚙ 개발 환경
* `Java 8`
* `JDK 1.8`
* **IDE**: Eclipse
* **Database**: OracleDB 11g XE
* **WAS**: Apache Tomcat9
* 기타 주요 라이브러리: jQuery, cos, JSTL

***
## 📌 주요 개발 기능
#### 회원가입 제약 조건
* 각 칼럼마다 정규표현식을 적용하여 이에 해당하지 않는 데이터가 입력된 경우 알림창이 뜨도록 구현함. - **<a href="https://github.com/nireah/chagawa/blob/961fc6c3eb31924c7c1f5d987e011bf332ede28c/src/main/webapp/js/regEx.js#L5-L95">코드보기<a>**
* 중복이 불가능하도록 설정한 칼럼은 중복되는 데이터가 이미 존재하는지 확인한 후 사용이 가능하도록 구현함. - **<a href="https://github.com/nireah/chagawa/blob/ac0521b93c60d6240850106ba68c9ee12d831d60/src/main/java/com/chagawa/member/dao/MemberDAOImpl.java#L145-L179">코드보기<a>**

#### 아이디/비밀번호 찾기 - <a href="https://github.com/nireah/chagawa/blob/c907f44ec21c3ea2997d4e64d5c28e610dd25777/src/main/java/com/chagawa/member/dao/MemberDAOImpl.java#L182-L242">코드보기<a>
* 이름, 연락처 등의 정보를 입력하여 이것과 회원 정보가 일치할 경우 아이디 또는 비밀번호를 알려주도록 구현함.

#### 검색 및 페이징 처리
* 검색 키를 선택한 후 검색어를 입력하도록 하여 특정 칼럼에 해당되는 정보만 검색할 수 있도록 구현함. - **<a href="https://github.com/nireah/chagawa/blob/ac0521b93c60d6240850106ba68c9ee12d831d60/src/main/java/com/chagawa/member/dao/MemberDAOImpl.java#L526-L624">코드보기<a>**
* 페이지 당 보여지는 게시글 수를 선택할 수 있도록 구현함. - **<a href="https://github.com/nireah/chagawa/blob/ac0521b93c60d6240850106ba68c9ee12d831d60/src/main/webapp/WEB-INF/views/member/list.jsp#L98-L107">코드보기<a>**

#### 이미지 수정 / 기본이미지로 변경 - <a href="https://github.com/nireah/chagawa/blob/ac0521b93c60d6240850106ba68c9ee12d831d60/src/main/java/com/chagawa/member/controller/MemberController.java#L404-L433">코드보기<a>
* MultipartRequest를 이용하여 파일 선택을 통해 이미지를 업로드 하도록 구현함.
* ‘기본이미지로 변경’ 버튼을 클릭할 경우 미리 설정해 놓은 이미지로 변경되도록 구현함.

***
## 🗂 첨부파일
* **<a href="요구사항 정의서 합본.pdf">요구사항 정의서 합본.pdf<a>**
* **<a href="테이블 정의서 합본.pdf">테이블 정의서 합본.pdf<a>**
* **<a href="스키마 종합.sql">스키마 종합.sql<a>**
