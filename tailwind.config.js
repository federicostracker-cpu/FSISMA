/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        mera: {
          900: '#0A1628',
          800: '#0F2040',
          700: '#1A3460',
          600: '#1E4080',
          500: '#2255A4',
          400: '#3B72C8',
          300: '#6A9FE0',
          200: '#A8C8F0',
          100: '#E8F1FC',
          50:  '#F4F8FF',
        },
        accent: {
          500: '#00C9A7',
          400: '#00E6BF',
          300: '#5FFCDE',
        },
        danger: '#E53E3E',
        warning: '#F6AD55',
        success: '#48BB78',
      },
      fontFamily: {
        display: ['Georgia', 'Times New Roman', 'serif'],
        body: ['system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      boxShadow: {
        'mera': '0 4px 24px rgba(10, 22, 40, 0.15)',
        'mera-lg': '0 8px 48px rgba(10, 22, 40, 0.2)',
        'card': '0 1px 4px rgba(10,22,40,0.08), 0 4px 16px rgba(10,22,40,0.06)',
      },
      animation: {
        'fade-in': 'fadeIn 0.4s ease forwards',
        'slide-up': 'slideUp 0.4s ease forwards',
        'pulse-soft': 'pulseSoft 2s ease-in-out infinite',
      },
      keyframes: {
        fadeIn: {
          from: { opacity: 0 },
          to: { opacity: 1 },
        },
        slideUp: {
          from: { opacity: 0, transform: 'translateY(16px)' },
          to: { opacity: 1, transform: 'translateY(0)' },
        },
        pulseSoft: {
          '0%, 100%': { opacity: 1 },
          '50%': { opacity: 0.6 },
        },
      },
    },
  },
  plugins: [],
}
