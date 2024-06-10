import { defineConfig } from 'vite'
import Rails from 'vite-plugin-rails'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  resolve: {
    dedupe: ['axios']
  },
  plugins: [
    Rails(),
    vue(),
  ],
})
