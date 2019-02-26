exports.onWindow = browserWindow => browserWindow.setVibrancy('dark');

exports.decorateConfig = (config) => {
  return Object.assign({}, config, {
    foregroundColor: '#eceff1',
    backgroundColor: `rgba(38, 50, 56, ${ config.backgroundOpacity || '0.8' })`,
    borderColor: 'transparent',
    cursorColor: '#68b6f3',
    colors: {
      black: '#263238',
      red: '#FF5252',
      green: '#9CCC65',
      yellow: '#fee94e',
      blue: '#2b98f0',
      magenta: '#b38bfc',
      cyan: '#68b6f3',
      white: '#ECEFF1',
      lightBlack: '#617d8a',
      lightRed: '#fc625d',
      lightGreen: '#9CCC65',
      lightYellow: '#fee94e',
      lightBlue: '#2b98f0',
      lightMagenta: '#b38bfc',
      lightCyan: '#68b6f3',
      lightWhite: '#ffffff'
    },
    termCSS: `
      ${config.termCSS || ''}
      @keyframes blink-animation {
        to {
          background-color: transparent;
        }
      }
      .cursor-node[focus=true]:not([moving]) {
        animation: blink-animation .777s ease-in-out infinite;
        box-sizing: content-box !important;
        mix-blend-mode: difference;
      }
      ::-webkit-scrollbar {
        width: 7px;
      }
      ::-webkit-scrollbar-thumb {
        border-radius: 3.5px;
        background-color: rgba(236, 239, 241, 0.4);
      }
    `,
    css: `
      ${config.css || ''}
      .header_header {
        background: rgba(34, 45, 50, 0.5) !important;
      }
      .tab_tab {
        color: hsl(0, 0%, 77%);
      }
      .hyperterm_main, .tab_tab, .tab_text {
        border: none !important;
        padding: 0 !important;
      }
      .tab {
        color: red !important;
      }
      .tab_tab::before {
        position: absolute;
        content: "";
        display: block;
        left: 0px;
        right: 0px;
        bottom: 0px;
        transition: border-color .3s ease-in-out;
        border-bottom: 3px solid transparent;
      }
      .tab_active::before {
        border-bottom: 3px solid #a04a92;
      }
    `
  })
}
