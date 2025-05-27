import { defineStore } from 'pinia'
import type { Link } from '@/types/link'
import api from '@/services/api'

export const useLinkStore = defineStore('links', {
  state: () => ({
    links: [] as Link[],
  }),
  actions: {
    async fetchLinks() {
      const { data } = await api.get<Link[]>('/links')
      this.links = data
    },
    async shortenUrl(original_url: string) {
      const { data } = await api.post<Link>('/links', { original_url })
      this.links.unshift(data)
    },
  },
})
