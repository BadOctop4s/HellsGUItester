"use client"
import Dashboard from './components/Dashboard'
import UserList from './components/UserList'
import AdminList from './components/Adminlist'
import { useRouter } from 'next/navigation'
import { useEffect } from 'react'

export default function AdminPage() {
  const router = useRouter()
  useEffect(() => {
    const email = localStorage.getItem('admin_email')
    if (!email) router.push('/login')
  }, [])

  return (
    <div style={{ padding: 50 }}>
      <h1>Painel Admin</h1>
      <Dashboard />
      <hr />
      <UserList />
      <hr />
      <AdminList />
    </div>
  )
}
