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
/* 현재 공백으로 검색하면 전체검색되게 바꿔서 미사용중 */