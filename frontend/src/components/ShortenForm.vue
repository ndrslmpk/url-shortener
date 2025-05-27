<template>
  <div class="card shadow-sm">
    <div class="card-body">
      <form @submit.prevent="handleSubmit" class="shorten-form">
        <div class="mb-3">
          <label for="url" class="form-label">Enter URL to shorten</label>
          <div class="input-group">
            <input
              v-model="url"
              type="url"
              class="form-control"
              id="url"
              placeholder="https://example.com"
              :class="{ 'is-invalid': error }"
              required
            />
            <button
              type="submit"
              class="btn btn-primary"
              :disabled="isLoading"
            >
              <span v-if="isLoading" class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
              {{ isLoading ? 'Shortening...' : 'Shorten' }}
            </button>
          </div>
          <div v-if="error" class="invalid-feedback d-block">
            {{ error }}
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useLinkStore } from '@/stores/links'

const url = ref('')
const error = ref('')
const isLoading = ref(false)
const store = useLinkStore()

const handleSubmit = async () => {
  if (!url.value) return

  try {
    error.value = ''
    isLoading.value = true
    await store.shortenUrl(url.value)
    url.value = ''
  } catch (e) {
    error.value = e instanceof Error ? e.message : 'Failed to shorten URL'
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
.shorten-form {
  max-width: 800px;
  margin: 0 auto;
}
</style>
