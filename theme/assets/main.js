(function () {
  var navPanel = document.querySelector('[data-nav-panel]');
  var navOpen = document.querySelector('[data-nav-open]');
  var navCloseBtns = document.querySelectorAll('[data-nav-close]');
  var header = document.querySelector('.site-header');
  var root = document.documentElement;
  var body = document.body;
  var lockedScrollY = 0;

  function lockBodyScroll() {
    if (!body || body.classList.contains('nav-locked')) return;
    lockedScrollY = window.scrollY || window.pageYOffset || 0;
    if (root) root.classList.add('nav-locked');
    body.style.top = '-' + lockedScrollY + 'px';
    body.style.position = 'fixed';
    body.style.left = '0';
    body.style.right = '0';
    body.style.width = '100%';
    body.classList.add('nav-locked');
  }

  function unlockBodyScroll() {
    if (!body || !body.classList.contains('nav-locked')) return;
    if (root) root.classList.remove('nav-locked');
    body.classList.remove('nav-locked');
    body.style.position = '';
    body.style.top = '';
    body.style.left = '';
    body.style.right = '';
    body.style.width = '';
    window.scrollTo(0, lockedScrollY);
  }

  function openNav() {
    if (!navPanel) return;
    navPanel.classList.add('is-open');
    navPanel.setAttribute('aria-hidden', 'false');
    lockBodyScroll();
    if (navOpen) {
      navOpen.classList.add('is-open');
      navOpen.setAttribute('aria-label', 'Close navigation');
    }
  }

  function closeNav() {
    if (!navPanel) return;
    navPanel.classList.remove('is-open');
    navPanel.setAttribute('aria-hidden', 'true');
    unlockBodyScroll();
    if (navOpen) {
      navOpen.classList.remove('is-open');
      navOpen.setAttribute('aria-label', 'Open navigation');
    }
  }

  function toggleNav() {
    if (!navPanel) return;
    if (navPanel.classList.contains('is-open')) {
      closeNav();
    } else {
      openNav();
    }
  }

  if (navOpen) {
    navOpen.addEventListener('click', toggleNav);
  }
  navCloseBtns.forEach(function (btn) {
    btn.addEventListener('click', closeNav);
  });

  if (navPanel) {
    navPanel.addEventListener('click', function (event) {
      var target = event.target;
      if (!target) return;
      var link = target.closest('a');
      if (!link) return;
      closeNav();
    });
  }

  if (header) {
    header.addEventListener('click', function (event) {
      var target = event.target;
      if (!target) return;
      var button = target.closest('a, button');
      if (!button) return;
      if (button.hasAttribute('data-nav-open')) return;
      closeNav();
    });
  }

  function setHeaderHeight() {
    if (!header) return;
    document.documentElement.style.setProperty('--header-height', header.offsetHeight + 'px');
  }

  setHeaderHeight();
  window.addEventListener('resize', setHeaderHeight);
  window.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
      closeNav();
    }
  });
})();
