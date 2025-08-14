"use client"
import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'

// Tipo da tabela admin_users
type Admin = {
  id: number
  email: string
  password: string
}

export default function AdminList() {
  const [admins, setAdmins] = useState<Admin[]>([])
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  // Pegar admins existentes
  useEffect(() => {
    async function fetchAdmins() {
      const { data, error } = await supabase
        .from('admin_users')
        .select('*')
      if (error) console.log(error)
      else if (data) setAdmins(data as Admin[])
    }
    fetchAdmins()
  }, [])

  // Adicionar novo admin
  const addAdmin = async () => {
    if (!email || !password) return alert('Preencha email e senha')

    const { data: newAdmin, error } = await supabase
      .from('admin_users')
      .insert([{ email, password }])
      .select() // retorna o admin criado

    if (error) console.log(error)
    else if (newAdmin) {
      setAdmins([...admins, ...(newAdmin as Admin[])])
      setEmail('')
      setPassword('')
    }
  }

  // Remover admin
  const removeAdmin = async (id: number) => {
    const { error } = await supabase
      .from('admin_users')
      .delete()
      .eq('id', id)

    if (error) console.log(error)
    else setAdmins(admins.filter(a => a.id !== id))
  }

  return (
    <div className="p-4 bg-white rounded shadow">
      <h2 className="text-xl font-bold mb-2">Admins</h2>

      <div className="flex gap-2 mb-4">
        <input
          className="border p-2 rounded flex-1"
          placeholder="Email"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />
        <input
          className="border p-2 rounded flex-1"
          placeholder="Senha"
          type="password"
          value={password}
          onChange={e => setPassword(e.target.value)}
        />
        <button
          className="bg-blue-500 text-white px-4 rounded"
          onClick={addAdmin}
        >
          Adicionar
        </button>
      </div>

      <ul>
        {admins.map(a => (
          <li key={a.id} className="flex justify-between mb-2 p-2 border rounded">
            <span>{a.email}</span>
            <button
              className="bg-red-500 text-white px-2 rounded"
              onClick={() => removeAdmin(a.id)}
            >
              Remover
            </button>
          </li>
        ))}
      </ul>
    </div>
  )
}
