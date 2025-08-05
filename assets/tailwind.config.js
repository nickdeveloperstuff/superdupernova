module.exports = {
  content: [
    "./lib/**/*.{ex,heex}",
    "./node_modules/daisyui/dist/**/*.js"
  ],
  theme: {
    extend: {
      spacing: {
        'unit': '0.25rem',    // 4pt
        'unit-2': '0.5rem',   // 8pt
        'unit-3': '0.75rem',  // 12pt
        'unit-4': '1rem',     // 16pt (standard gutter)
        'unit-6': '1.5rem',   // 24pt
        'unit-8': '2rem',     // 32pt
        'unit-12': '3rem',    // 48pt
        'unit-16': '4rem',    // 64pt
      },
      gridTemplateColumns: {
        'lego': 'repeat(12, minmax(0, 1fr))',
      },
      gap: {
        'lego': '1rem', // Standard 16pt gutter
      }
    }
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark"],
  },
}