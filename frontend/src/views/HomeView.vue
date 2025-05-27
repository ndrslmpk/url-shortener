<template>
  <div class="home-view">
    <h1>🔗 Link Shortener</h1>
    <ShortenForm />
    <LinkList />
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { useLinkStore } from '@/stores/links'
import ShortenForm from '@/components/ShortenForm.vue'
import LinkList from '@/components/LinkList.vue'

const store = useLinkStore()

onMounted(() => {
  store.fetchLinks()
})
</script>

<style scoped>
.home-view {
  max-width: 600px;
  margin: 0 auto;
  padding: 2rem;
  font-family: system-ui, sans-serif;
}
</style>
