// =====================
// UI Script (Fixed)
// =====================
document.addEventListener('DOMContentLoaded', () => {

    // ===== Mobile Menu Toggle =====
    const navMenu = document.getElementById('navMenu');
    const menuToggle = document.querySelector('.menu-toggle');
    if (menuToggle && navMenu) {
        menuToggle.addEventListener('click', () => navMenu.classList.toggle('show'));
    }

    // ===== Dropdown Toggle =====
    window.toggleDropdown = function (element) {
        const navItem = element?.parentElement;
        if (navItem) navItem.classList.toggle('active');
    };

    // ===== User Dropdown =====
    window.toggleUserDropdown = function () {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) dropdown.classList.toggle('show');
    };

    // ===== Slider functionality =====
    let currentSlide = 0;
    window.slideDeals = function (direction) {
        const container = document.getElementById('dealsContainer');
        if (!container) return;
        const cards = container.getElementsByClassName('deal-card');
        if (!cards.length) return;

        const cardWidth = cards[0].offsetWidth + 20;
        currentSlide += direction;

        if (currentSlide < 0) currentSlide = cards.length - 4;
        else if (currentSlide > cards.length - 4) currentSlide = 0;

        container.scroll({ left: currentSlide * cardWidth, behavior: 'smooth' });
    };

    // ===== News Tabs =====
    const tabBtns = document.querySelectorAll('.tab-btn');
    if (tabBtns.length) {
        tabBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                tabBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });
    }

    // ===== Scroll to Top =====
    const scrollBtn = document.createElement('button');
    scrollBtn.classList.add('scroll-top-btn');
    scrollBtn.innerHTML = '<i class="fas fa-chevron-up"></i>';
    document.body.appendChild(scrollBtn);

    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) scrollBtn.classList.add('show');
        else scrollBtn.classList.remove('show');
    });

    scrollBtn.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));

    // ===== Close dropdowns when clicking outside =====
    document.addEventListener('click', (e) => {
        const userMenu = document.querySelector('.user-menu');
        const userDropdown = document.getElementById('userDropdown');
        if (userMenu && !userMenu.contains(e.target)) userDropdown?.classList.remove('show');
        if (navMenu && menuToggle && !navMenu.contains(e.target) && !menuToggle.contains(e.target)) {
            navMenu.classList.remove('show');
        }
    });

    // ===== Notification System =====
    window.showNotification = function (message, type = 'info') {
        const notification = document.createElement('div');
        notification.classList.add('notification', `notification-${type}`);
        const icon = document.createElement('i');
        icon.className = type === 'success' ? 'fas fa-check-circle' :
            type === 'error' ? 'fas fa-exclamation-circle' : 'fas fa-info-circle';
        notification.appendChild(icon);
        notification.appendChild(document.createTextNode(message));
        document.body.appendChild(notification);
        setTimeout(() => notification.classList.add('show'), 100);
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    };

    // ===== Search Functionality =====
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        let searchTimeout;
        searchInput.addEventListener('input', (e) => {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                const query = e.target.value.trim();
                if (query.length >= 2) {
                    console.log('Searching for:', query);
                    // showSearchResults(query);
                }
            }, 300);
        });
    }

}); // end DOMContentLoaded
