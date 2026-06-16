// BGGChef 공통 JS
console.log('BGGChef loaded');

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.carousel-container').forEach(function (container) {
        var track = container.querySelector('.carousel-track');
        if (!track) return;

        var items = track.querySelectorAll('.slide-item');
        var total = items.length;
        var visible = 4;
        var maxPos = Math.max(0, total - visible);
        var pos = 0;

        if (total <= visible) {
            container.querySelectorAll('.carousel-arrow').forEach(function (btn) {
                btn.style.display = 'none';
            });
            return;
        }

        function move() {
            var itemWidth = items[0].offsetWidth;
            track.style.transform = 'translateX(-' + (pos * itemWidth) + 'px)';
        }

        var prevBtn = container.querySelector('.carousel-arrow.prev');
        var nextBtn = container.querySelector('.carousel-arrow.next');

        if (prevBtn) {
            prevBtn.addEventListener('click', function () {
                pos = pos <= 0 ? maxPos : pos - 1;
                move();
            });
        }

        if (nextBtn) {
            nextBtn.addEventListener('click', function () {
                pos = pos >= maxPos ? 0 : pos + 1;
                move();
            });
        }
    });
});
