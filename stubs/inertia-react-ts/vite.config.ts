import { defineConfig } from 'vite'
import Rails from 'vite-plugin-rails'
import react from '@vitejs/plugin-react'

export default defineConfig({
  resolve: {
    dedupe: ['axios']
  },
  plugins: [
    Rails(),
    react(),
  ],
})
