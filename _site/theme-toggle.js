/* Two round buttons in the bottom-right corner of every page.
 *
 *   🎨  cycles the color theme:  default -> flatly -> warm -> midnight
 *   Aa  cycles the font theme:   default -> reader -> garamond
 *
 * Both choices live in localStorage, so a reader keeps them from one visit to
 * the next, on that browser only. Nothing is sent anywhere.
 *
 * The color themes are CSS classes on <html> (theme-flatly, theme-warm,
 * theme-midnight); the default theme is the absence of a class. The font
 * themes work the same way (font-reader, font-garamond). Every rule for them
 * is in styles.css, so this file only decides which class is on.
 *
 * Printing always uses the light surface and the Garamond font, whatever is
 * active on screen, because the theme rules hardcode screen colors that waste
 * ink and read badly on paper.
 */
(function() {
  // Color cycle. Add a theme by adding its id here and a matching
  // .theme-<id> block in styles.css.
  var themes = ['default', 'flatly', 'warm', 'midnight'];
  var themeClasses = ['theme-flatly', 'theme-warm', 'theme-midnight'];
  var saved = localStorage.getItem('site-theme') || 'default';

  function applyTheme(id) {
    var root = document.documentElement;
    for (var i = 0; i < themeClasses.length; i++) root.classList.remove(themeClasses[i]);
    if (id !== 'default' && themes.indexOf(id) !== -1) root.classList.add('theme-' + id);
  }

  // Applied before first paint, so a reader who chose midnight never sees a
  // white flash on the way in.
  applyTheme(saved);

  // Font cycle. Each entry swaps the two family tokens and the two scale
  // knobs defined at the top of styles.css.
  var fonts = [
    { id: 'default',  cls: null,            title: 'Font: Default (Nunito + PT Sans)' },
    { id: 'reader',   cls: 'font-reader',   title: 'Font: Reader (Inter + Literata)' },
    { id: 'garamond', cls: 'font-garamond', title: 'Font: Garamond' }
  ];
  var savedFont = localStorage.getItem('site-font') || 'default';

  function applyFont(id) {
    var root = document.documentElement;
    root.classList.remove('font-reader', 'font-garamond');
    for (var i = 0; i < fonts.length; i++) {
      if (fonts[i].id === id && fonts[i].cls) root.classList.add(fonts[i].cls);
    }
  }

  function fontMeta(id) {
    for (var i = 0; i < fonts.length; i++) {
      if (fonts[i].id === id) return fonts[i];
    }
    return fonts[0];
  }

  function fontIndex(id) {
    for (var i = 0; i < fonts.length; i++) {
      if (fonts[i].id === id) return i;
    }
    return 0;
  }

  applyFont(savedFont);

  // --- Printing ----------------------------------------------------------
  // The .theme-* rules set their colors at a higher specificity than the
  // accent tokens, so the class itself has to come off for the duration of
  // the print job and go back afterwards.
  var printRestore = null;

  function enterPrint() {
    if (printRestore) return;
    printRestore = {
      theme: localStorage.getItem('site-theme') || 'default',
      font: localStorage.getItem('site-font') || 'default'
    };
    applyTheme('default');
    document.documentElement.classList.remove('font-reader', 'font-garamond');
  }

  function exitPrint() {
    if (!printRestore) return;
    applyTheme(printRestore.theme);
    applyFont(printRestore.font);
    printRestore = null;
  }

  window.addEventListener('beforeprint', enterPrint);
  window.addEventListener('afterprint', exitPrint);

  // Safari and some headless renderers drive printing through the media
  // query rather than the events, so listen to both.
  if (window.matchMedia) {
    var printQuery = window.matchMedia('print');
    var onPrintChange = function(e) { if (e.matches) enterPrint(); else exitPrint(); };
    if (printQuery.addEventListener) printQuery.addEventListener('change', onPrintChange);
    else if (printQuery.addListener) printQuery.addListener(onPrintChange);
  }

  // --- The two buttons ---------------------------------------------------
  // A small corner badge shows the 1-based position in the cycle, so you can
  // tell how far you are from wrapping back to the first one.
  function makeBadge(text) {
    var badge = document.createElement('span');
    badge.style.cssText = 'position:absolute;top:-5px;right:-5px;box-sizing:border-box;min-width:16px;height:16px;line-height:13px;border-radius:8px;border:1.5px solid var(--site-accent);background:var(--bs-body-bg,#fff);color:var(--site-accent);font-size:10px;font-weight:700;font-family:sans-serif;text-align:center;pointer-events:none;';
    badge.textContent = text;
    return badge;
  }

  function hoverGrow(btn) {
    btn.addEventListener('mouseenter', function() { btn.style.transform = 'scale(1.1)'; });
    btn.addEventListener('mouseleave', function() { btn.style.transform = 'scale(1)'; });
  }

  document.addEventListener('DOMContentLoaded', function() {
    var base = 'position:fixed;right:20px;z-index:9999;width:42px;height:42px;border-radius:50%;' +
               'border:2px solid var(--site-accent);background:var(--bs-body-bg,#fff);' +
               'color:var(--site-accent);cursor:pointer;box-shadow:0 2px 8px rgba(0,0,0,0.15);' +
               'transition:all 0.2s;';

    // Color toggle, in the corner.
    var btn = document.createElement('button');
    btn.id = 'theme-toggle';
    btn.title = 'Switch theme';
    btn.innerHTML = '🎨';
    btn.style.cssText = base + 'bottom:20px;font-size:20px;';

    var themeBadge = makeBadge(String(themes.indexOf(localStorage.getItem('site-theme') || 'default') + 1));
    btn.appendChild(themeBadge);
    hoverGrow(btn);

    btn.addEventListener('click', function() {
      var current = localStorage.getItem('site-theme') || 'default';
      var next = themes[(themes.indexOf(current) + 1) % themes.length];
      applyTheme(next);
      localStorage.setItem('site-theme', next);
      themeBadge.textContent = String(themes.indexOf(next) + 1);
    });

    document.body.appendChild(btn);

    // Font toggle, stacked directly above the color toggle.
    var fbtn = document.createElement('button');
    fbtn.id = 'font-toggle';
    fbtn.innerHTML = 'Aa';
    fbtn.style.cssText = base + 'bottom:72px;font-size:17px;font-weight:600;line-height:1;font-family:var(--site-font-heading);';
    fbtn.title = fontMeta(localStorage.getItem('site-font') || 'default').title;

    var fontBadge = makeBadge(String(fontIndex(localStorage.getItem('site-font') || 'default') + 1));
    fbtn.appendChild(fontBadge);
    hoverGrow(fbtn);

    fbtn.addEventListener('click', function() {
      var current = localStorage.getItem('site-font') || 'default';
      var next = fonts[(fontIndex(current) + 1) % fonts.length];
      applyFont(next.id);
      localStorage.setItem('site-font', next.id);
      fbtn.title = next.title;
      fontBadge.textContent = String(fontIndex(next.id) + 1);
    });

    document.body.appendChild(fbtn);
  });
})();
