"use client"
import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'

export default function AdminList() {
  const [admins, setAdmins] = useState<any[]>([])
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  useEffect(() => {
    async function fetchAdmins() {
      const { data } = await supabase.from('admin_users').select('*')
      if (data) setAdmins(data)
    }
    fetchAdmins()
  }, [])

  const addAdmin = async () => {
    if (!email || !password) return alert('Preencha email e senha')
    const { error } = await supabase.from('admin_users').insert([{ email, password }])
    if (error) console.log(error)
    else setAdmins([...admins, { email, password }])
  }

  const removeAdmin = async (id: number) => {
    const { error } = await supabase.from('admin_users').delete().eq('id', id)
    if (error) console.log(error)
    else setAdmins(admins.filter(a => a.id !== id))
  }

  return (
    <div>
      <h2>Admins</h2>
      <input
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
      />
      <input
        placeholder="Senha"
        type="password"
        value={password}
        onChange={e => setPassword(e.target.value)}
      />
      <button onClick={addAdmin}>Adicionar Admin</button>

      <ul>
        {admins.map(a => (
          <li key={a.id}>
            {a.email} 
            <button onClick={() => removeAdmin(a.id)}>Remover</button>
          </li>
        ))}
      </ul>
    </div>
  )
}
