<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .recipe-write-wrap { max-width: 1080px; margin: 0 auto; }
    .recipe-write-title { font-weight: 800; margin-bottom: 18px; }
    .recipe-form-section {
        background: #fff;
        border: 1px solid #e6e6e6;
        border-radius: 12px;
        padding: 30px 36px;
        margin-bottom: 18px;
    }
    .recipe-form-section h3 {
    
    
    
    
      color: var(--bggchef-primary);
        font-size: 1.25rem;
        font-weight: 800;
        margin-bottom: 24px;
    
    
    
        <%--color: #24a043;
        font-size: 1.25rem;
        font-weight: 800;
        margin-bottom: 24px;--%>
    }
    .recipe-label { font-weight: 700; margin-bottom: 8px; }
    .help-text { color: #8b95a1; font-size: 0.86rem; }
    .photo-box {
        border: 1px solid #ddd;
        border-radius: 6px;
        background: #f7f7f7;
        min-height: 198px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }
    .photo-box .photo-badge {
        position: absolute;
        left: 10px;
        top: 10px;
        background: #777;
        color: #fff;
        border-radius: 2px;
        padding: 5px 10px;
        font-size: 0.82rem;
        font-weight: 700;
        z-index: 2;
    }
    .photo-plus {
        width: 58px;
        height: 58px;
        border: 2px solid #dedede;
        border-radius: 50%;
        color: #d0d0d0;
        font-size: 2.8rem;
        line-height: 50px;
        text-align: center;
    }
    .photo-preview {
        width: 100%;
        height: 100%;
        min-height: 198px;
        object-fit: cover;
        display: none;
    }
    .photo-preview.is-visible { display: block; }
    .category-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(140px, 1fr));
        gap: 14px;
    }
    .ingredient-group,
    .step-item {
        border: 1px solid #ddd;
        border-radius: 6px;
        background: #fff;
        padding: 14px 18px 18px;
        margin-bottom: 16px;
    }
    .ingredient-row {
        display: grid;
        grid-template-columns: 1fr 1fr 42px;
        gap: 10px;
        align-items: center;
        margin-top: 10px;
    }
    .step-head,
    .ingredient-group-head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        margin-bottom: 12px;
    }
    .remove-btn {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #ff8a8a;
        background: #fff;
        color: #ff6b6b;
        font-weight: 800;
        line-height: 1;
    }
    .add-soft-btn {      
    
    
        border: 1px solid var(--bggchef-primary);  
        color: var(--bggchef-primary); 
        background: #fff;
        border-radius: 28px;
        padding: 12px 48px;
        font-weight: 800;
    
    
    
                                           
       <%-- border: 1px solid #2fb344;
        color: #2fb344;
        background: #fff;
        border-radius: 28px;
        padding: 12px 48px;
        font-weight: 800;            제료묶음추가 버튼 색상변경@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@--%>
    } 
    
    .add-soft-btn:hover {background: var(--bggchef-primary-light);
        color: var(--bggchef-primary-hover);}                        <%--{ background: #f0fff4; color: #22963a; }--%>
    
    
    .step-content { min-height: 160px; resize: vertical; }
    .step-file-row {
        display: grid;
        grid-template-columns: 1fr;
        gap: 10px;
        margin-top: 12px;
    }
    .notice-box {
        background: #fffbe2;
        padding: 16px 24px;
        margin-bottom: 20px;
        font-weight: 700;
    }
    @media (max-width: 768px) {
        .recipe-form-section { padding: 22px 16px; }
        .category-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        .ingredient-row { grid-template-columns: 1fr; }
        .remove-btn { width: 100%; border-radius: 6px; }
    }
</style>

<div class="recipe-write-wrap">
    <h2 class="recipe-write-title">레시피 수정</h2>

    <form id="recipeForm" action="${pageContext.request.contextPath}/recipe/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="recipe_id" value="${recipe.recipeId}">
        <input type="hidden" name="thumbnail" value="${recipe.thumbnail}">

        <section class="recipe-form-section">
            <h3>기본정보</h3>
            <div class="row g-4">
                <div class="col-lg-7">
                    <div class="mb-4">
                        <label for="title" class="recipe-label">레시피 제목</label>
                        <input type="text" class="form-control" id="title" name="title" maxlength="200" value="${fn:escapeXml(recipe.title)}" required>
                    </div>
                    <div class="mb-4">
                        <label for="description" class="recipe-label">레시피 소개</label>
                        <textarea class="form-control" id="description" name="description" rows="5">${fn:escapeXml(recipe.description)}</textarea>
                    </div>
                </div>
                <div class="col-lg-5">
                    <label for="thumbnail_file" class="recipe-label">대표 이미지</label>
                    <label class="photo-box" for="thumbnail_file">
                        <span class="photo-badge"><i class="bi bi-camera"></i> 대표사진</span>
                        <c:choose>
                            <c:when test="${not empty recipe.thumbnail}">
                                <img id="thumbnailPreview" class="photo-preview is-visible" src="${pageContext.request.contextPath}${recipe.thumbnail}" alt="대표 이미지 미리보기">
                            </c:when>
                            <c:otherwise>
                                <span class="photo-plus">+</span>
                                <img id="thumbnailPreview" class="photo-preview" alt="대표 이미지 미리보기">
                            </c:otherwise>
                        </c:choose>
                    </label>
                    <input type="file" class="form-control mt-2" id="thumbnail_file" name="thumbnail_file" accept="image/*">
                    <div class="help-text mt-1">새 파일을 선택하면 기존 대표 이미지가 교체됩니다.</div>
                </div>
            </div>

            <div class="mt-4">
                <label class="recipe-label d-block">카테고리 / 요리정보</label>
                <div class="category-grid">
                    <div>
                        <label for="category_id" class="recipe-label small">카테고리</label>
                        <select class="form-select" id="category_id" name="category_id" required>
                            <option value="">선택</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.categorymId}" ${recipe.categoryId == category.categorymId ? 'selected' : ''}><c:out value="${category.name}" /></option>
                            </c:forEach>
                            <c:if test="${empty categoryList}">
                                <option value="${recipe.categoryId}" selected><c:out value="${empty recipe.categoryName ? '기존 카테고리' : recipe.categoryName}" /></option>
                            </c:if>
                        </select>
                    </div>
                    <div>
                        <label for="servings" class="recipe-label small">인원</label>
                        <select class="form-select" id="servings" name="servings" required>
                            <option value="">선택</option>
                            <option value="1" ${recipe.servings == 1 ? 'selected' : ''}>1인분</option>
                            <option value="2" ${recipe.servings == 2 ? 'selected' : ''}>2인분</option>
                            <option value="3" ${recipe.servings == 3 ? 'selected' : ''}>3인분</option>
                            <option value="4" ${recipe.servings == 4 ? 'selected' : ''}>4인분</option>
                            <option value="5" ${recipe.servings == 5 ? 'selected' : ''}>5인분</option>
                            <option value="6" ${recipe.servings >= 6 ? 'selected' : ''}>6인분 이상</option>
                        </select>
                    </div>
                    <div>
                        <label for="cook_time" class="recipe-label small">요리시간</label>
                        <select class="form-select" id="cook_time" name="cook_time" required>
                            <option value="">선택</option>
                            <option value="10" ${recipe.cookTime == 10 ? 'selected' : ''}>10분 이내</option>
                            <option value="20" ${recipe.cookTime == 20 ? 'selected' : ''}>20분 이내</option>
                            <option value="30" ${recipe.cookTime == 30 ? 'selected' : ''}>30분 이내</option>
                            <option value="60" ${recipe.cookTime == 60 ? 'selected' : ''}>60분 이내</option>
                            <option value="90" ${recipe.cookTime == 90 ? 'selected' : ''}>90분 이내</option>
                            <option value="120" ${recipe.cookTime >= 120 ? 'selected' : ''}>2시간 이상</option>
                        </select>
                    </div>
                    <div>
                        <label for="difficulty" class="recipe-label small">난이도</label>
                        <select class="form-select" id="difficulty" name="difficulty" required>
                            <option value="">선택</option>
                            <option value="1" ${recipe.difficulty == 1 ? 'selected' : ''}>쉬움</option>
                            <option value="2" ${recipe.difficulty == 2 ? 'selected' : ''}>보통</option>
                            <option value="3" ${recipe.difficulty == 3 ? 'selected' : ''}>어려움</option>
                        </select>
                    </div>
                </div>
            </div>
        </section>

        <section class="recipe-form-section">
            <h3>재료정보</h3>
            <div id="ingredientGroups">
                <div class="ingredient-group" data-server-group="true">
                    <div class="ingredient-group-head">
                        <strong class="ingredient-group-title">재료 묶음 1</strong>
                        <button type="button" class="remove-btn" title="재료 묶음 삭제">-</button>
                    </div>
                    <div class="ingredient-body">
                        <c:forEach var="ingredient" items="${ingredients}">
                            <div class="ingredient-row">
                                <input type="text" name="ingredient_name" class="form-control" maxlength="100" value="${fn:escapeXml(ingredient.name)}" placeholder="예) 양배추" required>
                                <input type="text" name="ingredient_amount" class="form-control" maxlength="50" value="${fn:escapeXml(ingredient.amount)}" placeholder="예) 200g, 2개" required>
                                <button type="button" class="remove-btn" title="재료 삭제">-</button>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-center mt-3">
                        <button type="button" class="btn btn-outline-danger btn-sm add-ingredient-row-btn">+ 재료 추가하기</button>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <button type="button" class="add-soft-btn" id="addIngredientGroupBtn">
                    <i class="bi bi-layers"></i> 재료 묶음 추가
                </button>
            </div>
        </section>

        <section class="recipe-form-section">
            <h3>요리순서</h3>
            <div class="notice-box">
                요리의 맛이 좌우될 수 있는 중요한 부분은 빠짐없이 적어주세요.
                <div class="help-text mt-1">예) 10분간 익혀주세요. -> 10분간 약한불로 익혀주세요.</div>
            </div>
            <div id="stepList">
                <c:forEach var="step" items="${steps}">
                    <div class="step-item" data-server-step="true">
                        <div class="step-head">
                            <strong class="step-title">Step${step.stepNo}</strong>
                            <button type="button" class="remove-btn" title="순서 삭제">-</button>
                        </div>
                        <input type="hidden" name="step_image_url" value="${step.imageUrl}">
                        <textarea name="step_content" class="form-control step-content" required>${fn:escapeXml(step.content)}</textarea>
                        <div class="step-file-row">
                            <input type="file" name="step_file" class="form-control" accept="image/*">
                            <c:if test="${not empty step.imageUrl}">
                                <div class="help-text">기존 이미지: ${step.imageUrl}</div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="text-center mt-4">
                <button type="button" class="add-soft-btn" id="addStepBtn">
                    <i class="bi bi-layers"></i> 순서 추가
                </button>
            </div>
        </section>

        <div class="d-flex justify-content-between align-items-center mb-5">
            <a href="${pageContext.request.contextPath}/recipe/view?recipe_id=${recipe.recipeId}" class=" btn btn-outline-secondary px-4<%--btn btn-outline-secondary btn-lg px-4--%>">수정취소</a>
            <div class="d-flex gap-2">
                <button type="submit" class="  btn btn-outline-danger px-4   <%-- btn btn-danger btn-lg px-5--%>">수정</button>
                <button type="submit" form="deleteRecipeForm" class=" btn btn-danger px-4"<%--btn btn-outline-danger btn-lg px-4--%>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
            </div>
        </div>
    </form>
    <form id="deleteRecipeForm" action="${pageContext.request.contextPath}/recipe/delete" method="post">
        <input type="hidden" name="recipe_id" value="${recipe.recipeId}">
    </form>
</div>

<script>
(() => {
    const ingredientGroups = document.getElementById('ingredientGroups');
    const stepList = document.getElementById('stepList');
    const addIngredientGroupBtn = document.getElementById('addIngredientGroupBtn');
    const addStepBtn = document.getElementById('addStepBtn');
    const thumbnailInput = document.getElementById('thumbnail_file');
    const thumbnailPreview = document.getElementById('thumbnailPreview');

    function createButton(className, text, title) {
        const button = document.createElement('button');
        button.type = 'button';
        button.className = className;
        button.textContent = text;
        if (title) button.title = title;
        return button;
    }

    function renumberIngredientGroups() {
        ingredientGroups.querySelectorAll('.ingredient-group').forEach((group, index) => {
            group.querySelector('.ingredient-group-title').textContent = '재료 묶음 ' + (index + 1);
        });
    }

    function renumberSteps() {
        stepList.querySelectorAll('.step-item').forEach((step, index) => {
            step.querySelector('.step-title').textContent = 'Step' + (index + 1);
        });
    }

    function addIngredientRow(groupBody, nameValue = '', amountValue = '') {
        const row = document.createElement('div');
        row.className = 'ingredient-row';

        const nameInput = document.createElement('input');
        nameInput.type = 'text';
        nameInput.name = 'ingredient_name';
        nameInput.className = 'form-control';
        nameInput.placeholder = '예) 양배추';
        nameInput.maxLength = 100;
        nameInput.required = true;
        nameInput.value = nameValue;

        const amountInput = document.createElement('input');
        amountInput.type = 'text';
        amountInput.name = 'ingredient_amount';
        amountInput.className = 'form-control';
        amountInput.placeholder = '예) 200g, 2개';
        amountInput.maxLength = 50;
        amountInput.required = true;
        amountInput.value = amountValue;

        const removeBtn = createButton('remove-btn', '-', '재료 삭제');
        removeBtn.addEventListener('click', () => removeIngredientRow(row, groupBody));

        row.append(nameInput, amountInput, removeBtn);
        groupBody.appendChild(row);
    }

    function removeIngredientRow(row, groupBody) {
        if (groupBody.querySelectorAll('.ingredient-row').length > 1) {
            row.remove();
            return;
        }
        row.querySelectorAll('input').forEach(input => input.value = '');
        row.querySelector('input').focus();
    }

    function wireIngredientGroup(group) {
        const body = group.querySelector('.ingredient-body') || group.querySelector('div:nth-child(2)');
        group.querySelector('.ingredient-group-head .remove-btn').addEventListener('click', () => {
            if (ingredientGroups.querySelectorAll('.ingredient-group').length > 1) {
                group.remove();
                renumberIngredientGroups();
            }
        });
        group.querySelectorAll('.ingredient-row .remove-btn').forEach(button => {
            button.addEventListener('click', () => removeIngredientRow(button.closest('.ingredient-row'), body));
        });
        group.querySelector('.add-ingredient-row-btn').addEventListener('click', () => addIngredientRow(body));
    }

    function addIngredientGroup(rows = [{ name: '', amount: '' }]) {
        const group = document.createElement('div');
        group.className = 'ingredient-group';

        const head = document.createElement('div');
        head.className = 'ingredient-group-head';

        const title = document.createElement('strong');
        title.className = 'ingredient-group-title';
        const removeGroupBtn = createButton('remove-btn', '-', '재료 묶음 삭제');
        head.append(title, removeGroupBtn);

        const body = document.createElement('div');
        body.className = 'ingredient-body';
        rows.forEach(row => addIngredientRow(body, row.name, row.amount));

        const addRowWrap = document.createElement('div');
        addRowWrap.className = 'text-center mt-3';
        const addRowBtn = createButton('btn btn-outline-danger btn-sm add-ingredient-row-btn', '+ 재료 추가하기');
        addRowWrap.appendChild(addRowBtn);

        group.append(head, body, addRowWrap);
        ingredientGroups.appendChild(group);
        wireIngredientGroup(group);
        renumberIngredientGroups();
    }

    function wireStep(step) {
        step.querySelector('.remove-btn').addEventListener('click', () => {
            if (stepList.querySelectorAll('.step-item').length > 1) {
                step.remove();
                renumberSteps();
            }
        });
    }

    function addStep(contentValue = '') {
        const step = document.createElement('div');
        step.className = 'step-item';

        const head = document.createElement('div');
        head.className = 'step-head';
        const title = document.createElement('strong');
        title.className = 'step-title';
        const removeBtn = createButton('remove-btn', '-', '순서 삭제');
        head.append(title, removeBtn);

        const textarea = document.createElement('textarea');
        textarea.name = 'step_content';
        textarea.className = 'form-control step-content';
        textarea.placeholder = '예) 그 사이 양파와 버섯, 대파도 썰어서 준비해주세요.';
        textarea.required = true;
        textarea.value = contentValue;

        const fileWrap = document.createElement('div');
        fileWrap.className = 'step-file-row';
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.name = 'step_file';
        fileInput.className = 'form-control';
        fileInput.accept = 'image/*';
        fileWrap.appendChild(fileInput);

        step.append(head, textarea, fileWrap);
        stepList.appendChild(step);
        wireStep(step);
        renumberSteps();
    }

    thumbnailInput.addEventListener('change', () => {
        const file = thumbnailInput.files && thumbnailInput.files[0];
        if (!file) return;
        thumbnailPreview.src = URL.createObjectURL(file);
        thumbnailPreview.classList.add('is-visible');
        const plus = thumbnailPreview.parentElement.querySelector('.photo-plus');
        if (plus) plus.remove();
    });

    ingredientGroups.querySelectorAll('.ingredient-group').forEach(wireIngredientGroup);
    stepList.querySelectorAll('.step-item').forEach(wireStep);

    if (!ingredientGroups.querySelector('.ingredient-row')) {
        ingredientGroups.innerHTML = '';
        addIngredientGroup([
            { name: '', amount: '' },
            { name: '', amount: '' },
            { name: '', amount: '' }
        ]);
    } else {
        renumberIngredientGroups();
    }

    if (!stepList.querySelector('.step-item')) {
        addStep();
    } else {
        renumberSteps();
    }

    addIngredientGroupBtn.addEventListener('click', () => addIngredientGroup());
    addStepBtn.addEventListener('click', () => addStep());
})();
</script>
