import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import MainLayout from './components/layout/MainLayout'
import LoginPage from './pages/LoginPage'
import DashboardPage from './pages/DashboardPage'
import CustomersPage from './pages/CustomersPage'
import KycPage from './pages/KycPage'
import WatchlistPage from './pages/WatchlistPage'
import TmsAlertsPage from './pages/TmsAlertsPage'
import CasesPage from './pages/CasesPage'
import CaseDetailPage from './pages/CaseDetailPage'
import StrReportPage from './pages/StrReportPage'
import CtrReportPage from './pages/CtrReportPage'
import RaItemsPage from './pages/RaItemsPage'
import RaResultsPage from './pages/RaResultsPage'
import TmsTransactionsPage from './pages/tms/TmsTransactionsPage'
import TmsScenariosPage from './pages/tms/TmsScenariosPage'
import TmsSetValsPage from './pages/tms/TmsSetValsPage'
import TmsApprovalsPage from './pages/tms/TmsApprovalsPage'
import TmsStatsPage from './pages/tms/TmsStatsPage'
import StrCasesPage from './pages/str/StrCasesPage'
import CtrCasesPage from './pages/ctr/CtrCasesPage'
import { useAuthStore } from './store/authStore'

function PrivateRoute({ children }: { children: React.ReactNode }) {
  const user = useAuthStore((s) => s.user)
  if (!user) return <Navigate to="/login" replace />
  return <>{children}</>
}

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route
          path="/"
          element={
            <PrivateRoute>
              <MainLayout />
            </PrivateRoute>
          }
        >
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<DashboardPage />} />
          <Route path="customers" element={<CustomersPage />} />
          <Route path="kyc" element={<KycPage />} />
          <Route path="watchlist" element={<WatchlistPage />} />
          {/* TMS routes */}
          <Route path="tms/transactions" element={<TmsTransactionsPage />} />
          <Route path="tms/alerts" element={<TmsAlertsPage />} />
          <Route path="tms/str" element={<StrReportPage />} />
          <Route path="tms/ctr" element={<CtrReportPage />} />
          <Route path="tms/scenarios" element={<TmsScenariosPage />} />
          <Route path="tms/setvals" element={<TmsSetValsPage />} />
          <Route path="tms/approvals" element={<TmsApprovalsPage />} />
          <Route path="tms/stats" element={<TmsStatsPage />} />
          {/* STR / CTR processing */}
          <Route path="str/cases" element={<StrCasesPage />} />
          <Route path="ctr/cases" element={<CtrCasesPage />} />
          {/* Cases */}
          <Route path="cases" element={<CasesPage />} />
          <Route path="cases/:caseId" element={<CaseDetailPage />} />
          {/* Reports (keep existing paths) */}
          <Route path="reports/str" element={<StrReportPage />} />
          <Route path="reports/ctr" element={<CtrReportPage />} />
          {/* RA */}
          <Route path="ra/items" element={<RaItemsPage />} />
          <Route path="ra/results" element={<RaResultsPage />} />
        </Route>
        <Route path="*" element={<Navigate to="/dashboard" replace />} />
      </Routes>
    </BrowserRouter>
  )
}
