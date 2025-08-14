"use client"
import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'

export default function Dashboard() {
  const [totalUsers, setTotalUsers] = useState(0)
  const [activeUsers, setActiveUsers] = useState(0)

  useEffect(() => {
    async function fetchStats() {
      const { data: users } = await supabase.from('user').select('*')
      if (users) {
        setTotalUsers(users.length)
        setActiveUsers(users.filter(u => u.active).length)
      }
    }
    fetchStats()
  }, [])

  return (
    <div style={{ marginBottom: 30 }}>
      <h2>Dashboard</h2>
      <p>Total de usuários: {totalUsers}</p>
      <p>Usuários ativos: {activeUsers}</p>
    </div>
  )
}
