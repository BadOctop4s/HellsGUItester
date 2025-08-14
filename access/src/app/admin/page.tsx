"use client"

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Dashboard from './components/Dashboard'
import UserList from './components/UserList'
import AdminList from './components/ListaAdmin'

export default function AdminPage() {
  const router = useRouter()

  // Verifica se o admin está logado
  useEffect(() => {
    const email = localStorage.getItem('admin_email')
    if (!email) router.push('/login')
  }, [])

  return (
    <div style={{ padding: 50 }}>
      <h1>Painel Admin</h1>

      {/* Dashboard com estatísticas */}
      <Dashboard />

      <hr style={{ margin: '20px 0' }} />

      {/* Lista de usuários */}
      <UserList />

      <hr style={{ margin: '20px 0' }} />

      {/* Lista de admins */}
      <AdminList />
    </div>
  )
}
