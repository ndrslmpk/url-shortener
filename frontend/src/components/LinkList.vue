<template>
  <div class="mt-4">
    <h2 class="h4 mb-3">Your Shortened Links</h2>
    <div v-if="store.links.length === 0" class="alert alert-info">
      No links shortened yet. Try shortening your first URL above!
    </div>
    <div v-else class="list-group">
      <div v-for="link in store.links" :key="link.id" class="list-group-item">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="mb-1">{{ link.short_path }}</h6>
            <small class="text-muted">{{ link.original_url }}</small>
          </div>
          <div class="d-flex align-items-center">
            <button
              class="btn btn-sm btn-outline-primary"
              @click="copyLinkToClipboard(link.short_path)"
            >
              Copy
            </button>
            <button
              class="btn btn-sm btn-outline-primary"
              @click="openLink(link.short_path)"
            >
              Open
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useLinkStore } from '@/stores/links'
import { onMounted } from 'vue'

const store = useLinkStore()

onMounted(() => {
  store.fetchLinks()
})

const openLink = async (path: string) => {
  try {
    // Can be improved to return full URL, but needs ENV variable or something to define the host for backend
    const hostUrl = "http://localhost:3000/"
    const finalUrl = hostUrl + path
    window.open(finalUrl)
  } catch (err) {
    console.error('Failed to copy:', err)
  }
}

const copyLinkToClipboard = async (path: string) => {
  try {
    // Can be improved to return full URL, but needs ENV variable or something to define the host for backend
    const hostUrl = "http://localhost:3000/"
    const finalUrl = hostUrl + path
    await navigator.clipboard.writeText(finalUrl)
    // You could add a toast notification here
  } catch (err) {
    console.error('Failed to copy:', err)
  }
}
</script>
