import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      'cesium': path.resolve(__dirname, './node_modules/cesium')
    }
  },
  server: {
    port: 5174,
    open: false
  },
  build: {
    rollupOptions: {
      external: ['cesium']
    }
  }
})
