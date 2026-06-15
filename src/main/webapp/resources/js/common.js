// BGGChef 공통 JS
// TODO: AJAX 좋아요 토글, 즐겨찾기, URL 복사 등
console.log('BGGChef loaded');

function checkSearch() {
    var keywordInput = document.getElementsByName("keyword")[0];

    if (!keywordInput) {
        return false;
    }
    var keywordValue = keywordInput.value;

    if (keywordValue.trim() === "") {
        alert("검색어를 입력해 주세요.");
        keywordInput.value = "";
        keywordInput.focus();
        return false;
    }
    return true;
}
