# findanimal

<h3> 플러터 경기도 유기견 찾기 </h3>
<hr>
<strong>스터디 주별 목표 </strong>
<br><br>
<ul style="list-style:none;">
  <ol><strong>1주 </strong>기본 화면 구축 및 시 별 검색</ol>
  <ol><strong>2주 </strong>검색 결과 및 상세 보기</ol>
  <ol><strong>3주 </strong>카카오 or 구글 맵 이용 위치 찾기</ol>
</ul>
<h4> 기본 bottomnavigator 구축</h4>
```
void main() {
  runApp(LayoutBuilder(
    builder: (context, constraints) {
      return GetMaterialApp(
        home: Home(),
        getPages: [
          GetPage(name: '/find', page: () => FindScreen()),
          GetPage(name: '/search', page: () => SearchForm()),

        ],
        title: '경기도 유기동물',
      );
    },
  ));
}
```
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
