import { createRouter, createWebHistory } from 'vue-router'
import LoginPage from '../pages/LoginPage.vue'
import MainLayout from '../components/layout/MainLayout.vue'
import DashboardPage from '../pages/dashboard/DashboardPage.vue'
import StrCasesPage from '../pages/str/StrCasesPage.vue'
import CtrCasesPage from '../pages/ctr/CtrCasesPage.vue'
import WatchlistPage from '../pages/wlf/WatchlistPage.vue'
import RaPage from '../pages/ra/RaPage.vue'
import KycPage from '../pages/kyc/KycPage.vue'
import CustomerPage from '../pages/customer/CustomerPage.vue'

const routes = [
  { path: '/login', component: LoginPage },
  {
    path: '/',
    component: MainLayout,
    children: [
      { path: '', redirect: '/dashboard' },
      { path: 'dashboard', component: DashboardPage },
      { path: 'str/cases', component: StrCasesPage },
      { path: 'ctr/cases', component: CtrCasesPage },
      { path: 'wlf/search', component: WatchlistPage },
      { path: 'ra/items', component: RaPage },
      { path: 'kyc/list', component: KycPage },
      { path: 'customers', component: CustomerPage },
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
