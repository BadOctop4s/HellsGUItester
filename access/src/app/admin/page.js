"use client"
import { useEffect, useState } from 'react'
import { supabase } from '../../../lib/supabase'

export default function Admin() {
  const [users, setUsers] = useState([])

  useEffect(() => {
    const fetchUsers = async () => {
      const { data } = await supabase.from('users_script').select('*')
      setUsers(data || [])
    }
    fetchUsers()
  }, [])

  const toggleActive = async (id, active) => {
    await supabase.from('users_script').update({ active: !active }).eq('id', id)
    setUsers(users.map(u => u.id === id ? { ...u, active: !active } : u))
  }

  return (
    <div style={{ padding: 50 }}>
      <h1>Painel Admin</h1>
      <ul>
        {users.map(u => (
          <li key={u.id}>
            {u.username} - {u.active ? 'Ativo' : 'Bloqueado'}
            <button onClick={() => toggleActive(u.id, u.active)}>Alternar</button>
          </li>
        ))}
      </ul>
    </div>
  )
}
