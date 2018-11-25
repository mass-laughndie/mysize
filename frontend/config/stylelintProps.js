// From https://www.script-tutorials.com/css-reference/
const groups = {
  animation: [
    '@keyframes',
    'animation',
    'animation-delay',
    'animation-direction',
    'animation-duration',
    'animation-iteration-count',
    'animation-name',
    'animation-play-state',
    'animation-timing-function',
  ],
  background: [
    'background',
    'background-attachment',
    'background-clip',
    'background-color',
    'background-image',
    'background-origin',
    'background-position',
    'background-repeat',
    'background-size',
  ],
  borderAndOutline: [
    'border',
    'border-bottom',
    'border-bottom-color',
    'border-bottom-left-radius',
    'border-bottom-right-radius',
    'border-bottom-style',
    'border-bottom-width',
    'border-color',
    'border-image',
    'border-image-outset',
    'border-image-repeat',
    'border-image-slice',
    'border-image-source',
    'border-image-width',
    'border-left',
    'border-left-color',
    'border-left-style',
    'border-left-width',
    'border-radius',
    'border-right',
    'border-right-color',
    'border-right-style',
    'border-right-width',
    'border-style',
    'border-top',
    'border-top-color',
    'border-top-left-radius',
    'border-top-right-radius',
    'border-top-style',
    'border-top-width',
    'border-width',
    'box-decoration-break',
    'box-shadow',
    'outline',
    'outline-color',
    'outline-style',
    'outline-width',
    'cursor', // <= positioning
  ],
  box: [
    'overflow-style',
    'overflow-x',
    'overflow-y',
    'rotation',
    'rotation-point',
  ],
  color: ['color-profile', 'opacity', 'rendering-intent'],
  dimension: [
    'height',
    'max-height',
    'max-width',
    'min-height',
    'min-width',
    'width',
  ],
  flexibleBox: [
    'box-align',
    'box-direction',
    'box-flex',
    'box-flex-group',
    'box-lines',
    'box-ordinal-group',
    'box-orient',
    'box-pack',
  ],
  font: [
    '@font-face',
    'font',
    'font-family',
    'font-size',
    'font-size-adjust',
    'font-stretch',
    'font-style',
    'font-variant',
    'font-weight',
  ],
  generatedContent: [
    'content',
    'counter-increment',
    'counter-reset',
    'quotes',
    'crop',
    'move-to',
    'page-policy',
  ],
  linebox: [
    'alignment-adjust',
    'alignment-baseline',
    'baseline-shift',
    'dominant-baseline',
    'drop-initial-after-adjust',
    'drop-initial-after-align',
    'drop-initial-before-adjust',
    'drop-initial-before-align',
    'drop-initial-size',
    'drop-initial-value',
    'inline-box-align',
    'line-stacking',
    'line-stacking-ruby',
    'line-stacking-shift',
    'line-stacking-strategy',
    'text-height',
  ],
  list: [
    'list-style',
    'list-style-image',
    'list-style-position',
    'list-style-type',
  ],
  margin: [
    'margin',
    'margin-bottom',
    'margin-left',
    'margin-right',
    'margin-top',
  ],
  padding: [
    'padding',
    'padding-bottom',
    'padding-left',
    'padding-right',
    'padding-top',
  ],
  positioning: [
    'bottom',
    'clear',
    'clip',
    'clip-path',
    // 'cursor', // => borderAndOutline
    'display',
    'float',
    'left',
    'overflow',
    'position',
    'right',
    'top',
    'visibility',
    'z-index',
  ],
  table: [
    'border-collapse',
    'border-spacing',
    'caption-side',
    'empty-cells',
    'table-layout',
  ],
  text: [
    'color',
    'direction',
    'hanging-punctuation',
    'letter-spacing',
    'line-height',
    'punctuation-trim',
    'text-align',
    'text-align-last',
    'text-decoration',
    'text-indent',
    'text-justify',
    'text-outline',
    'text-overflow',
    'text-shadow',
    'text-transform',
    'text-wrap',
    'unicode-bidi',
    'vertical-align',
    'white-space',
    'word-break',
    'word-spacing',
    'word-wrap',
  ],
  transition: [
    'transition',
    'transition-delay',
    'transition-duration',
    'transition-property',
    'transition-timing-function',
  ],
  userInterface: [
    'appearance',
    'box-sizing',
    'icon',
    'nav-down',
    'nav-index',
    'nav-left',
    'nav-right',
    'nav-up',
    'outline-offset',
    'resize',
  ],

  // Unused
  contentForPagedMedia: [
    'bookmark-label',
    'bookmark-level',
    'bookmark-target',
    'float-offset',
    'hyphenate-after',
    'hyphenate-before',
    'hyphenate-character',
    'hyphenate-lines',
    'hyphenate-resource',
    'hyphens',
    'image-resolution',
    'marks',
    'string-set',
  ],
  grid: ['grid-columns', 'grid-rows'],
  hyperlink: ['target', 'target-name', 'target-new', 'target-position'],
  marquee: [
    'marquee-direction',
    'marquee-play-count',
    'marquee-speed',
    'marquee-style',
  ],
  multiColumn: [
    'column-count',
    'column-fill',
    'column-gap',
    'column-rule',
    'column-rule-color',
    'column-rule-style',
    'column-rule-width',
    'column-span',
    'column-width',
    'columns',
  ],
  pagedMedia: ['fit', 'fit-position', 'image-orientation', 'page', 'size'],
  print: [
    'orphans',
    'page-break-after',
    'page-break-before',
    'page-break-inside',
    'widows',
  ],
  ruby: ['ruby-align', 'ruby-overhang', 'ruby-position'],
  speech: [
    'mark',
    'mark-after',
    'mark-before',
    'phonemes',
    'rest',
    'rest-after',
    'rest-before',
    'voice-balance',
    'voice-duration',
    'voice-pitch',
    'voice-range',
    'voice-rate',
    'voice-stress',
    'voice-volume',
  ],
  transform: [
    'backface-visibility',
    'perspective',
    'perspective-origin',
    'transform',
    'transform-origin',
    'transform-style',
  ],
};

const props = {
  blockElement: [
    ...groups.positioning,
    ...groups.table,
    ...groups.userInterface,
  ],
  boxModel: [
    ...groups.box,
    ...groups.dimension,
    ...groups.flexibleBox,
    ...groups.margin,
    ...groups.padding,
  ],
  text: [
    ...groups.color,
    ...groups.font,
    ...groups.generatedContent,
    ...groups.linebox,
    ...groups.ruby,
    ...groups.text,
  ],
  decoration: [
    ...groups.animation,
    ...groups.background,
    ...groups.borderAndOutline,
    ...groups.list,
    ...groups.transition,
  ],
};

module.exports = props;