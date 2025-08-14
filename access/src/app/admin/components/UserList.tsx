"use client"
import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'

export default function UserList() {
  const [users, setUsers] = useState<any[]>([])

  useEffect(() => {
    async function fetchUsers() {
      const { data, error } = await supabase.from('user').select('*')
      if (error) console.log(error)
      else setUsers(data)
    }
    fetchUsers()
  }, [])

  const toggleActive = async (id: number, active: boolean) => {
    const { error } = await supabase
      .from('user')
      .update({ active: !active })
      .eq('id', id)
    if (error) console.log(error)
    else setUsers(users.map(u => u.id === id ? { ...u, active: !active } : u))
  }

  return (
    <div>
      <h2>Usuários do Script</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Ativo</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          {users.map(u => (
            <tr key={u.id}>
              <td>{u.id}</td>
              <td>{u.username}</td>
              <td>{u.active ? '✅' : '❌'}</td>
              <td>
                <button onClick={() => toggleActive(u.id, u.active)}>
                  {u.active ? 'Desativar' : 'Ativar'}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
