import { create } from 'zustand'
import { persist } from 'zustand/middleware'

export interface AuthUser {
  userId: string
  userName: string
  role: string
}

interface AuthState {
  user: AuthUser | null
  setUser: (user: AuthUser) => void
  clearUser: () => void
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      setUser: (user) => set({ user }),
      clearUser: () => set({ user: null }),
    }),
    {
      name: 'aml-auth',
    }
  )
)
